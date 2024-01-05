import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/get_product.dart';
import '../resources/app_url.dart';
import 'package:http/http.dart' as http;

class GridSelectionProvider extends ChangeNotifier {
  List<int> selectedIndices = [];
  List<GetProduct>? productList = [];
  List<GetProduct> selectedProductList = [];
  bool isLoading = false;
  bool isSelected = false;
  int selectedCategoryId = 0;
  int get getselectedCategoryId => selectedCategoryId;
  List<GetProduct>? get getProducts => productList;
  List<GetProduct> get getSelectedProductList => selectedProductList;

  GridSelectionProvider() {
    listAllProducts(categoryId: 0);
  }
  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  List<GetProduct> get selectedProductsUpOnCategory {
    if (selectedCategoryId == 0) {
      return productList!;
    } else {
      return productList = productList!
          .where((product) => product.categoryId == getselectedCategoryId)
          .toList();
    }
    // notifyListeners();
  }

  void toggleSelectionProduct(int index, GetProduct product) {
    //  selectedProductList.add(product);
    //  productList![index].isSelected = !productList![index].isSelected;
    if (selectedProductList.contains(product)) {
      selectedProductList.remove(product);
      // isSelected = false;
      // product.isSelected = false;
    } else {
      selectedProductList.add(product);
      // isSelected = true;
      // product.isSelected = true;
    }

    notifyListeners();
  }

  setSelection(bool selected) {
    isSelected = selected;
    notifyListeners();
  }

  //          *********************** SELECT CATEGORY ID FUNCTION ***************************************************
  void updateCategory(int iD) {
    selectedCategoryId = iD;
    notifyListeners();
  }

  void clearSelection() {
    selectedIndices.clear();
    notifyListeners();
  }

  List<GetProduct> selectedProducts(int selectedCategoryID) {
    return selectedCategoryID == 0
        ? productList!
        : productList!
            .where((product) => product.categoryId == selectedCategoryID)
            .toList();
  }
  //          *********************** LIST ALL PRODUCTS  API ***************************************************

  Future<void> listAllProducts({required int categoryId}) async {
    debugPrint("LIST ALL PRODUCTS $categoryId ");
    final Map<String, dynamic> apiBodyData = {
      'category_id': categoryId == 0 ? null : categoryId,
    };
    isLoading = true;
    selectedCategoryId = categoryId;
    notifyListeners();
    productList = [];
    final url = Uri.parse(APPUrl.getProcductUrl);
    try {
      final response = await http.post(url,
          body: json.encode(apiBodyData),
          headers: {'Content-Type': 'application/json'});
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        // debugPrint('inside');

        // debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        GetProductModel getProductModel = GetProductModel.fromJson(jsonData);

        productList = getProductModel.product;
        // selectedCategoryId =
        //     productList!.isEmpty ? 0 : productList![0].categoryId ?? 0;
        notifyListeners();
        // debugPrint('List Product Name in Category Provider');
      } else {}
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //          *********************** LIST ALL PRODUCTS FUNCTION RETURNING PRODUCT LIST API ***************************************************

  Future<List<GetProduct>> listAllProductList({required int categoryId}) async {
    List<GetProduct> productLists = [];
    debugPrint("LIST ALL PRODUCTS $categoryId ");
    final Map<String, dynamic> apiBodyData = {
      'category_id': categoryId == 0 ? null : categoryId,
    };
    isLoading = true;
    selectedCategoryId = categoryId;
    notifyListeners();
    productList = [];
    final url = Uri.parse(APPUrl.getProcductUrl);
    try {
      final response = await http.post(url,
          body: json.encode(apiBodyData),
          headers: {'Content-Type': 'application/json'});
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        // debugPrint('inside');

        // debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        GetProductModel getProductModel = GetProductModel.fromJson(jsonData);
        productList = productLists = getProductModel.product ?? [];
        notifyListeners();
        // selectedCategoryId =
        //     productList!.isEmpty ? 0 : productList![0].categoryId ?? 0;
        return productLists;

        // debugPrint('List Product Name in Category Provider');
      } else {
        return productLists;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
