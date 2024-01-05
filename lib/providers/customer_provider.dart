import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/app_url.dart';

class CustomerProvider {
  //                 *********************** LIST CUSTOMER API ***************************************************

  Future<dynamic> listCustomer(String accessToken, BuildContext context) async {
    debugPrint("listCustomer");

    final url = Uri.parse(APPUrl.customerListUrl);
    try {
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());
        return json.decode(response.body);
      } else if (response.statusCode > 400) {
        throw const HttpException("Customers Not Found.Try Again!");
      } else {
        throw const HttpException('Failed to load data ,Try Again Later!');
      }
    } catch (error) {
      rethrow;
    } finally {}
  }

  //                 *********************** ADD CUSTOMER API ***************************************************

  Future<dynamic> addCustomer(
      String accessToken,
      String phone,
      String storeID,
      String name,
      String email,
      String address,
      String pincode,
      String city,
      String state,
      String country,
      BuildContext context) async {
    debugPrint("listCustomer");
    final Map<String, dynamic> apiBodyData = {
      'phone': phone,
      'name': name,
      'email': email,
      'store_id': storeID,
      'address': address,
      'pin_code': pincode,
      'city': city,
      'state': state,
      'country': country,
    };
    final url = Uri.parse(APPUrl.addCustomerUrl);
    try {
      final response = await http.post(url,
          body: json.encode(apiBodyData),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());
        return json.decode(response.body);
      } else if (response.statusCode > 400) {
        throw const HttpException("Customers Not Found.Try Again!");
      } else {
        throw const HttpException('Failed to load data ,Try Again Later!');
      }
    } catch (error) {
      rethrow;
    } finally {}
  }
}
