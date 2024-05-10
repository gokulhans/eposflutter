import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  int? _userId;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;
  int? get userId => _userId;
  String? get token => _token;

  void login(String token, int userId) {
    _isLoggedIn = true;
    _userId = userId;
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
