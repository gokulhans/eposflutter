import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get token => _token;

  void login(String token) {
    _isLoggedIn = true;
    // _userId = userId;
    _token = token;

    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userId = null;
    _token = null;
    notifyListeners();
  }
}
