import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pos_machine/models/list_unit.dart';

import '../models/get_store.dart';
import '../models/get_suppliers.dart';
import '../models/list_purchase.dart';

import '../resources/app_url.dart';

class PurchaseProvider extends ChangeNotifier {
  bool isLoading = false;
  List<GetStoreModelData>? storeList = [];
  List<GetSuppliersModelData>? supplierList = [];
  List<PurchaseItem>? purchaseItems = [];
  List<PurchaseItem>? purchaseItemListAllPurchase;
  List<PurchaseItem>? listPurchaseItemView = [];
  List<GetStoreModelData>? get getStoreList => storeList;
  List<VoucherDetail>? voucherDetailsList = [];
  VoucherDetail? voucherDetails;
  List<PurchaseItem>? get getlistPurchaseItemView => listPurchaseItemView;
  VoucherDetail? get getVoucherDetails => voucherDetails;

  ListPurchaseModelData? ListPurchaseModelDataDetails;
  // List<PurchaseItem>? get getlistPurchaseItemView => listPurchaseItemView;
  ListPurchaseModelData? get getListPurchaseModelDataDetails =>
      ListPurchaseModelDataDetails;
  // UnitList? unitList;
  // UnitList? get getUnitList => unitList;
  Map<String, String>? unitList;
  Map<String, String>? get getUnitList => unitList;
  List<VoucherDetail>? get getVoucherDetailsList => voucherDetailsList;
  List<GetSuppliersModelData>? get getSupplierList => supplierList;
  GetStoreModelData storeDemo = GetStoreModelData(
    id: 0,
    name: "Select Store",
    code: "Select Store",
    status: "Y",
  );

  void callVoucherDetails({required int voucherId, required int purchaseId}) {
    debugPrint("voucherId $voucherId purchaseId $purchaseId");
    List<PurchaseItem> purchaseItemList = purchaseItemListAllPurchase!;
    // .firstWhere((element) =>
    //     element.any((element) => element.purchaseId == purchaseId));
    listPurchaseItemView = purchaseItemList;
    VoucherDetail? voucher = voucherDetailsList!.firstWhere(
      (element) => element.id == voucherId,
    );
    voucherDetails = voucher;
    notifyListeners();
  }

  String? storeName(int value) {
    var store = storeList!.firstWhere((e) => e.id == value,
        orElse: () => GetStoreModelData(id: 0, name: "Unknown"));
    return store.name;
  }

  String? supplierName(int value) {
    var supplier = supplierList!.firstWhere((e) => e.id == value,
        orElse: () => GetSuppliersModelData(id: 0, name: "Unknown"));
    return supplier.name;
  }

  PurchaseProvider();
  GetSuppliersModelData supplierDemo = GetSuppliersModelData(
      id: 0, name: "Select Supplier", phone: "", email: "");

  //          *********************** LIST ALL STORES  API ***************************************************

  Future<void> listAllStores(String accessToken, String? storeName) async {
    debugPrint("LIST ALL STORES ");

    final url = storeName == null
        ? Uri.parse(APPUrl.getStores)
        : Uri.parse("${APPUrl.getStores}=$storeName");
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        GetStoreModel getStoreModel = GetStoreModel.fromJson(jsonData);

        storeList = getStoreModel.data ?? [];
        storeList!.insert(0, storeDemo);

        notifyListeners();
      } else {}
    } finally {}
  }
  //          *********************** LIST ALL STORES  API ***************************************************

  Future<void> listAllSuppliers(
      String accessToken, String? supplierName) async {
    debugPrint("LIST ALL STORES ");

    final url = supplierName == null
        ? Uri.parse(APPUrl.getSuppliers)
        : Uri.parse("${APPUrl.getSuppliers}=$supplierName");
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);
        GetSuppliersModel getSuppliersModel =
            GetSuppliersModel.fromJson(jsonData);

        supplierList = getSuppliersModel.data ?? [];
        supplierList!.insert(0, supplierDemo);

        notifyListeners();
        debugPrint('List supplierList Name in Purchase Provider');
        for (var v in supplierList ?? []) {
          debugPrint(v.name);
        }
      } else {}
    } finally {}
  }
  //          *********************** LIST ALL UNITS  API ***************************************************

  Future<void> listAllUnits(
    String accessToken,
  ) async {
    debugPrint("LIST ALL UNITS ");

    final url = Uri.parse(APPUrl.listUnits);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);
        UnitsResponse unitsResponse = UnitsResponse.fromJson(jsonData);

        unitList = unitsResponse.unitList;

        notifyListeners();
      } else {}
    } finally {}
  }
  
  //          *********************** LIST PURCHASES  API ***************************************************

  Future<void> listPurchase(
      String accessToken, String? storeId, String? supplierId) async {
    debugPrint("LIST ALL Purchase ");

    final url = Uri.parse(
        "${APPUrl.listPurchases}?store_id=$storeId&supplier_id=$supplierId");
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);

        ListPurchaseModel listPurchaseModel =
            ListPurchaseModel.fromJson(jsonData);
        List<ListPurchaseModelData>? data = listPurchaseModel.data;
        List<PurchaseItem> purchaseItems = data!
            .map((e) => e.purchaseItems ?? []) // Extract purchase item lists
            .expand((items) => items)
            .toList();
        List<VoucherDetail> voucherDetails = data
            .map((e) => e.voucherDetails ?? []) // Extract voucher detail lists
            .expand((details) => details)
            .toList();
// List<VoucherDetail>? voucherDetails = data!.expand((e) => e.voucherDetails ?? []).toList();
//         List<VoucherDetail>? voucherDetails = data!.map((e) => e.voucherDetails).toList();

        voucherDetailsList = voucherDetails;
        List<PurchaseItem>? listPurchaseitem = purchaseItems;
        purchaseItemListAllPurchase = listPurchaseitem;
        notifyListeners();
      } else {}
    } finally {}
  }
  //          *********************** LIST ALL PURCHASE ITEMS API ***************************************************

  Future<dynamic> listAllPurchaseItems(
    String accessToken,
  ) async {
    debugPrint("LIST ALL Purchase Item");

    final url = Uri.parse(APPUrl.listPurchaseItems);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);
        ListPurchaseItemModel listPurchaseItemModel =
            ListPurchaseItemModel.fromJson(jsonData);

        purchaseItems = listPurchaseItemModel.data;

        notifyListeners();
        return json.decode(response.body);
      } else {}
    } finally {}
  }
  //          *********************** ADD PURCHASE ITEM API ***************************************************

  Future<dynamic> addPurchaseItem({
    required String categoryId,
    required String productId,
    required String quantity,
    required String unit,
    required String supplierId,
    required String storeId,
    required String batchNumber,
    required String accessToken,
  }) async {
    final Map<String, dynamic> apiBodyData = {
      'category_id': categoryId,
      'product_id': productId,
      'quantity': quantity,
      'unit': unit,
      'supplier_id': supplierId,
      'store_id': storeId,
      'batch_number': batchNumber,
    };
    debugPrint(apiBodyData.toString());
    final url = Uri.parse(APPUrl.addToPurchaseItem);
    try {
      final response = await http.post(url, body: apiBodyData, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());

        return json.decode(response.body);
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }
  //          *********************** ADD PURCHASE  API ***************************************************

  Future<dynamic> addPurchase({
    required String purchaseId,
    required String accessToken,
  }) async {
    final Map<String, dynamic> apiBodyData = {
      'purchase_id': purchaseId,
    };
    debugPrint(apiBodyData.toString());
    final url = Uri.parse(APPUrl.finishPurchaseOrder);
    try {
      final response = await http.post(url, body: apiBodyData, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());

        return json.decode(response.body);
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }
  //          *********************** REMOVE PURCHASE ITEM API ***************************************************

  Future<dynamic> removePurchaseItem({
    required String itemId,
    required String accessToken,
  }) async {
    final Map<String, dynamic> apiBodyData = {
      'item_id': itemId,
    };
    debugPrint(apiBodyData.toString());
    final url = Uri.parse(APPUrl.removePurchaseitem);
    try {
      final response = await http.post(url, body: apiBodyData, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());

        return json.decode(response.body);
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }
}
