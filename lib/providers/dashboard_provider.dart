import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/app_url.dart';

class DashboardProvider {
  //                 *********************** DASHBOARD API ***************************************************

  Future<dynamic> dashbaord(String accessToken, BuildContext context) async {
    debugPrint("dashbaord");

    final url = Uri.parse(APPUrl.dashBoardUrl);
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      });

      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());
        return json.decode(response.body);
      } else if (response.statusCode > 400) {
        throw const HttpException("Data Not Found.Try Again!");
      } else {
        throw const HttpException('Failed to load data ,Try Again Later!');
      }
    } catch (error) {
      rethrow;
    } finally {}
  }
}
