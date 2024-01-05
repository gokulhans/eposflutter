import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider {
  saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('inside shared ');

    prefs.setString('access_token', accessToken);
    debugPrint('inside shared ,$accessToken');
  }

  removeToken() async {
    debugPrint("removeToken  prefs.remove('access_token');");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('access_token');
  }

  Future<String?> getToken() async {
    debugPrint("getToken  String? token = prefs.getString('access_token');");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('access_token');
    return token;
    // return '101|LbzEubzMNqBffc10NqHnnbDu1pWcTOhplh2D9Kfo';
  }
}
