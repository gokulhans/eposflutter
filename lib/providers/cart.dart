import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  int cartItems = 0;
  int get getCartItems {
    return cartItems;
  }

  setCartItem(int value) {
    cartItems = value;
    notifyListeners();
  }
}
