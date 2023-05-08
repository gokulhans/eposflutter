
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String weight;
  final double price;
  final String imageUrl;

  bool isSelected;

  Product({
    required this.id,
    required this.title,
    required this.weight,
    required this.price,
    required this.imageUrl,
    this.isSelected = false,
  });

  void setSelectedValue(bool newValue) {
    isSelected = newValue;
    notifyListeners();
  }
}
