import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider {
  saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('inside shared ');

    prefs.setString('access_token', accessToken);
    debugPrint('inside shared ,$accessToken');
  }

  saveAccessTokenandCustomerId(
    String accessToken,
    int customerId,
    String customerName,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('inside shared ');

    prefs.setString('access_token', accessToken);
    prefs.setInt('customerId', customerId);
    prefs.setString('customerName', customerName);
    debugPrint('inside shared ,$customerName');
  }

  removeToken() async {
    debugPrint("removeToken  prefs.remove('access_token');");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('access_token');
  }

  removeTokenAndCustomerId() async {
    debugPrint("removeTokenAndCustomerId  prefs.remove('access_token');");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('access_token');
    prefs.remove('customerId');
    prefs.remove('customerName');
  }

  Future<String?> getToken() async {
    debugPrint("getToken  String? token = prefs.getString('access_token');");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('access_token');
    return token;
    // return '101|LbzEubzMNqBffc10NqHnnbDu1pWcTOhplh2D9Kfo';
  }

  Future<int?> getCustomerId() async {
    debugPrint(" int? customerId = prefs.getInt('customerId');");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? customerId = prefs.getInt('customerId');
    return customerId;
    // return '101|LbzEubzMNqBffc10NqHnnbDu1pWcTOhplh2D9Kfo';
  }

  Future<String> getCustomerName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerName = prefs.getString('customerName');
    return customerName ?? 'Default Name'; // Return a default value if null
  }
}
