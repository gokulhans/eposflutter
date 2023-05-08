import 'package:flutter/material.dart';

import 'package:pos_machine/resources/asset_manager.dart';

import 'product.dart';

class ProductList with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'MIGHTY ZINGER',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.mightyZinkerImage),
    Product(
        id: 'p2',
        title: 'MIGHTY ZINGER BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.mightyZinkerBoxImage),
    Product(
        id: 'p3',
        title: 'ZINGER BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerBoxImage),
    Product(
        id: 'p4',
        title: 'ZINGER SHRIMP BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerShrimpBoxImage),
    Product(
        id: 'p5',
        title: 'MIGHTY ZINGER',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.mightyZinkerImage),
    Product(
        id: 'p6',
        title: 'MIGHTY ZINGER BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.mightyZinkerBoxImage),
    Product(
        id: 'p7',
        title: 'ZINGER BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerBoxImage),
    Product(
        id: 'p8',
        title: 'ZINGER SHRIMP BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerShrimpBoxImage),
    Product(
        id: 'p4',
        title: 'ZINGER SHRIMP BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerShrimpBoxImage),
    Product(
        id: 'p5',
        title: 'MIGHTY ZINGER',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.mightyZinkerImage),
    Product(
        id: 'p6',
        title: 'MIGHTY ZINGER BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.mightyZinkerBoxImage),
    Product(
        id: 'p7',
        title: 'ZINGER BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerBoxImage),
    Product(
        id: 'p8',
        title: 'ZINGER SHRIMP BOX',
        weight: '150',
        price: 3.50,
        imageUrl: ImageAssets.zinkerShrimpBoxImage),
  ];

  //var _showFavoritesOnly = false;

  final String? authToken;
  final String? userId;
  ProductList(
    this.authToken,
    this.userId,
    this._items,
  );

  // String? _authToken;

  // set authToken(String value) {
  //   _authToken = value;
  // }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();
    // }
    return [..._items];
  }
}
