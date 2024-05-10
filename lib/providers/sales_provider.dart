import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/list_sales_order.dart';
import '../resources/app_url.dart';

class SalesProvider with ChangeNotifier {
  List<ListOrderModelData> _orders = [];

  List<ListOrderModelData> get orders => _orders;
  String _orderId = "";
  String get getOrderId {
    return _orderId;
  }

  int userId = 0;
  setUserId(int value) {
    userId = value;
    notifyListeners();
  }

  setOrderId(String value) {
    _orderId = value;
    debugPrint(_orderId);
    notifyListeners();
  }

  Future<void> fetchOrders(
      {int? customerId,
      required String accessToken,
      required int storeId,
      String? date,
      required bool orderNumberSelect,
      String? orderNumber}) async {
    debugPrint("fetchOrders customerId $customerId");
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    debugPrint("fetchOrders customerId $userId $date");
    final response = orderNumberSelect
        ? await http.get(
            Uri.parse(
                "${APPUrl.getListOrder}?order_number=$orderNumber&store_id=$storeId"),
            headers: {
                'Authorization': 'Bearer $accessToken',
                'content-type': 'application/json'
              })
        : date != null
            ? await http.get(
                Uri.parse(
                    "${APPUrl.getListOrder}?order_date=$date &store_id=$storeId"),
                headers: {
                    'Authorization': 'Bearer $accessToken',
                    'content-type': 'application/json'
                  })
            // : userId == 0
            //     ? await http.get(Uri.parse(
            //         "${APPUrl.getListOrder}?&order_date=${date ?? formattedDate}&store_id=$storeId"))
            //     :
            : await http.get(
                Uri.parse(
                    "${APPUrl.getListOrder}?customer_id=$userId&order_date=${date ?? formattedDate}&store_id=$storeId"),
                headers: {
                    'Authorization': 'Bearer $accessToken',
                    'content-type': 'application/json'
                  });

    if (response.statusCode == 200) {
      debugPrint("response.statusCode == 200");

      //final jsonData = json.decode(response.body);

      ListSalesOrderModel listSalesOrderModel =
          ListSalesOrderModel.fromJson(json.decode(response.body));
      _orders = listSalesOrderModel.data ?? [];

      notifyListeners();
    } else {
      _orders = [];
      throw Exception('Failed to load orders');
    }
  }

  //          *********************** LIST ORDER DETAILS API ***************************************************
  Future<dynamic> listOrderDetails(
      BuildContext context, String id, String accessToken) async {
    debugPrint(" API listOrderDetails $_orderId   passed one$id");
    final url = Uri.parse("${APPUrl.getListOrderDetails}?order_id=$id");

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'content-type': 'application/json'
      });
      if (response.statusCode == 200) {
        debugPrint('List listOrderDetails  inside');

        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);

        debugPrint(jsonData["status"]);

        return json.decode(response.body);
      } else if (response.statusCode > 400) {
        throw const HttpException("Please Try Again!");
      } else {
        throw const HttpException('Failed to load Data,,Try Again Later!');
      }
    } catch (error) {
      rethrow;
    } finally {}
  }
}
