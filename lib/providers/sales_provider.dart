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

  Future<void> fetchOrders({
    required String accessToken,
    required int storeId,
    String? orderNumber,
    String? filterName,
    String? date,
    String? filterStatus,
    String? filterPrice,
    String? filterEmail,
    String? filterPhone,
    String? filterStore,
    String? filterCreatedBy,
    int? page,
  }) async {
    final queryParameters = <String, String>{
      'store_id': storeId.toString(),
    };

    // Add filters to query parameters if they are not null
    if (orderNumber != null) queryParameters['filter_number'] = orderNumber;
    if (filterName != null) queryParameters['filter_name'] = filterName;
    if (date != null) queryParameters['filter_date'] = date;
    if (filterStatus != null) queryParameters['filter_status'] = filterStatus;
    if (filterPrice != null) queryParameters['filter_price'] = filterPrice;
    if (filterEmail != null) queryParameters['filter_email'] = filterEmail;
    if (filterPhone != null) queryParameters['filter_phone'] = filterPhone;
    if (filterStore != null) queryParameters['filter_store'] = filterStore;
    if (filterCreatedBy != null) {
      queryParameters['filter_created_by'] = filterCreatedBy;
    }
    if (page != null) queryParameters['page'] = page.toString();

    final uri = Uri.parse(APPUrl.getListOrder)
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      debugPrint('fetchOrders response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonData = json.decode(response.body);
          debugPrint('Received JSON data: ${jsonData.toString()}');

          try {
            ListSalesOrderModel listSalesOrderModel =
                ListSalesOrderModel.fromJson(jsonData);
            _orders = listSalesOrderModel.data ?? [];
            notifyListeners();
          } catch (e) {
            debugPrint('Error parsing JSON data: $e');
            debugPrint('JSON structure: ${jsonData.runtimeType}');
            if (jsonData is Map) {
              jsonData.forEach((key, value) {
                debugPrint('Key: $key, Value type: ${value.runtimeType}');
              });
            }
            throw Exception('Failed to parse order list data: $e');
          }
        } else {
          debugPrint('Empty response body');
          throw Exception('Received empty response');
        }
      } else {
        debugPrint(
            'Failed to load orders: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      debugPrint('Error in fetchOrders: $error');
      _orders = [];
      rethrow;
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

        debugPrint("status${jsonData["status"]}");

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
