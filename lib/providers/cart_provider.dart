import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/add_to_cart.dart';
import '../models/add_to_order.dart';
import '../models/list_cart.dart';
import '../resources/app_url.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  StreamController<List<ListCartModelData>> _cartStreamController =
      StreamController<List<ListCartModelData>>.broadcast();

  Stream<List<ListCartModelData>> get cartStream =>
      _cartStreamController.stream;
  PriceSummary? priceSummary = PriceSummary(
    discount: 0,
    netPayable: 0,
    subTotal: 0,
    totalTax: 0,
    netTotal: 0,
  );
  int cartId = 0;
  setCartIDForOrder(int value) {
    cartId = value;
    notifyListeners();
  }

  int get getCartIDForOrder => cartId;

  Future<void> fetchCartDataFromApi(
      {required int customerId, required String accessToken}) async {
    // Fetch cart data from your API and add it to the stream
    List<ListCartModelData> cartData =
        await fetchCartData(customerId: customerId, token: accessToken);
    _cartStreamController.add(cartData.isEmpty ? [] : cartData);
  }

  CartProvider() {
    getData();
    // Initialize your stream or add any initial data here if needed.
  }
  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? customerId = prefs.getInt('customerId');
    // sample data
    // int? customerId = 1;
    String? token = prefs.getString('access_token');
    fetchCartDataFromApi(customerId: customerId ?? 1, accessToken: token ?? "");
  }

  // Dispose the stream controller when done
  @override
  void dispose() {
    _cartStreamController.close();
    super.dispose();
  }

  //          *********************** FETCH  LIST CART API ***************************************************

  Future<List<ListCartModelData>> fetchCartData(
      {required int customerId, required String token}) async {
    debugPrint("LIST ALL CART ITEMS ");
    debugPrint("customerId $customerId");
    // sample data
    // customerId = 1;
    final Map<String, dynamic> apiBodyData = {
      'customer_id': customerId,
    };
    final url = Uri.parse(APPUrl.listCartUrl);
    try {
      final response =
          await http.post(url, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('inside');
        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        ListCartModel listCartModel = ListCartModel.fromJson(jsonData);
        // List<ListCartModelData> cartData = await fetchCartData(customerId: 1);
        //   _cartStreamController.add(cartData);

        PriceSummary? priceSummary = listCartModel.data!.isEmpty
            ? PriceSummary(
                discount: 0,
                netPayable: 0,
                subTotal: 0,
                totalTax: 0,
                netTotal: 0,
              )
            : listCartModel.data!.map((e) => e.priceSummary).first;

        if (listCartModel.data!.isNotEmpty) {
          debugPrint("  listCartModel.data!.isNotEmpty");
          debugPrint("${listCartModel.data![0].id ?? 0}");
          setCartIDForOrder(listCartModel.data![0].id ?? 0);
          notifyListeners();
          debugPrint(
              "  listCartModel.data!.isNotEmpty cartId $cartId $getCartIDForOrder");
          debugPrint("${listCartModel.data![0].id ?? 0}");
        }
        updateSummary(priceSummary);

        return listCartModel.data ?? [];
      } else {
        return [];
      }
    } finally {}
  }

  //          *********************** UPDATE PRICE SUMMARY ***************************************************

  void updateSummary(PriceSummary? priceSummaryUpdate) {
    priceSummary = priceSummaryUpdate;
    notifyListeners();
  }

  //          *********************** ADD TO CART API ***************************************************

  Future<dynamic> addToCartAPI({
    required int customerId,
    required int productId,
    required int quantity,
    required String accessToken,
  }) async {
    // sample data
    // customerId = 1;
    debugPrint("********************ADD TO CART API******************** ");
    final Map<String, dynamic> apiBodyData = {
      'customer_id': customerId,
      'quantity': quantity,
      'app_type': "api",
      'product_id': productId,
      "type": 1
    };
    debugPrint("productId $productId");
    debugPrint("customerId $customerId");
    final url = Uri.parse(APPUrl.addToCartUrl);
    try {
      final response =
          await http.post(url, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('inside');

        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        AddToCartModel addToCartModel = AddToCartModel.fromJson(jsonData);
        await fetchCartDataFromApi(
            customerId: customerId, accessToken: accessToken);
        // customerId: customerId, accessToken: accessToken);
        debugPrint(addToCartModel.status);
        // List<ListCartModelData> cartData = await fetchCartData(customerId: 1);
        //   _cartStreamController.add(cartData);

        // ListCartModelDataPriceSummary? priceSummary =
        //     addToCartModel.cart!.map((e) => e.priceSummary).single;

        // updateSummary(priceSummary);
        if (addToCartModel.status == 'sucesss') {
          debugPrint("  if (addToCartModel.status == 'sucesss') {");
          debugPrint("${addToCartModel.cart!.cartItem![0].cartItemId ?? 0}");

          setCartIDForOrder(addToCartModel.cart!.cartItem![0].cartItemId ?? 0);
        }

        return jsonData; //addToCartModel.status == 'sucesss' ? true : false;
      } else {
        return false;
      }
    } finally {}
  }

  //          *********************** REMOVE FROM CART API ***************************************************

  Future<dynamic> removeFromCartAPI({
    required int customerId,
    required int productId,
    required String remove,
    // required int quantity,
    required String accessToken,
  }) async {
    debugPrint("********************REMOVE FROM CART API******************** ");
    final Map<String, dynamic> apiBodyData = {
      'cart_item_id': productId,
      'remove': remove
    };
    debugPrint("productId $productId");
    // debugPrint("customerId $customerId");
    final url = Uri.parse(APPUrl
        .removeFromCartUrl); // Update this to the correct endpoint for removing items
    try {
      final response =
          await http.post(url, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('inside');

        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        AddToCartModel addToCartModel = AddToCartModel.fromJson(jsonData);
        await fetchCartDataFromApi(
            customerId: customerId, accessToken: accessToken);
        // customerId: customerId, accessToken: accessToken);
        debugPrint(addToCartModel.status);
        if (addToCartModel.status == 'success') {
          debugPrint("  if (addToCartModel.status == 'success') {");
          debugPrint("${addToCartModel.cart!.cartItem![0].cartItemId ?? 0}");

          setCartIDForOrder(addToCartModel.cart!.cartItem![0].cartItemId ?? 0);
        }

        return jsonData; // Return response data or success status
      } else {
        return false;
      }
    } finally {}
  }

  //          *********************** ADD TO ORDER API ***************************************************

  Future<dynamic> addToOrderAPI(
      {required int cartIds,
      required String accessToken,
      required int customerId}) async {
    debugPrint("********************ADD TO ORDER API******************** ");
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    debugPrint("$cartIds CadtId Inside ADD TO CART API $formattedDate");

    // 'cart_id': cartIds,
    final Map<String, dynamic> apiBodyData = {
      "store_id": 1,
      "customer_id": customerId,
    };
    // "order_date": formattedDate

    final url = Uri.parse(APPUrl.addToOrderUrl);

    try {
      final response =
          await http.post(url, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('inside 200');

        // debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        // AddToOrderModel addToOrderModel = AddToOrderModel.fromJson(jsonData);

        // debugPrint(jsonData);
        // debugPrint(addToOrderModel.status);
        getData();
        return jsonData; //addToOrderModel.status == 'success' ? true : false;
      } else {
        return false;
      }
    } finally {}
  }
}
