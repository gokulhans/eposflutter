import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos_machine/models/category_list.dart';
import 'package:http/http.dart' as http;

import '../resources/app_url.dart';

class CategoryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Category>? categoryList = [];
  List<Category>? categoryListWithoutQuery = [];
  String categoryText = '';
  //bool _isLoading = false;
  CategoryProvider() {
    listAllCategory();
  }
  String get getCategoryText => categoryText;
  int categoryCount = 0;

  int get getCount => categoryCount;

  setCategoryItemCount(int value) {
    categoryCount = value;
    notifyListeners();
  }

  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  List<Category>? get category => categoryList;
  Category categoryDemo = Category(
      categoryId: 0,
      categorySlug: "ALL",
      categoryName: "ALL",
      productsCount: 0);
  int categoryId = 0;
  int get getCategoryId => categoryId;

  // List<int> selectedIndices = [];

  // CategoryProvider() {
  //   listAllCategory();
  // }
  //          *********************** LIST ALL CATEGORY  API ***************************************************

  Future<void> listAllCategory() async {
    debugPrint("LIST ALL CATEGORY ");
// Set isLoading to true to show a loading indicator
    // _isLoading = true;
    // notifyListeners();

    final url = Uri.parse(APPUrl.categoryListUrl);
    try {
      final response =
          await http.post(url, headers: {'Content-Type': 'application/json'});
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        // debugPrint('inside');

        // debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        CategoryListModel categoryListModel =
            CategoryListModel.fromJson(jsonData);

        categoryList = categoryListWithoutQuery = categoryListModel.category;
        categoryList!.insert(0, categoryDemo);
        // debugPrint('List Category Name in Category Provider');
        // for (var v in categoryList ?? []) {
        //   debugPrint(v.categoryName);
        // }
        categoryText =
            categoryList!.isEmpty ? "" : categoryList![0].categoryName ?? "";
        categoryCount =
            categoryList!.isEmpty ? 0 : categoryList![0].productsCount ?? 0;
        // _selectedCategoryIndex = 0;
        notifyListeners();
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }

  //          *********************** SELECT CATEGORY  FUNCTION ***************************************************
  void selectCategory(int index, String categoryName, int categoryCounts) {
    _selectedCategoryIndex = index;
    notifyListeners();
    categoryText = categoryName;
    categoryCount = categoryCounts;
    notifyListeners();
  }

  //          ***********************SET THE SELECTED CATEGORY INDEX FUNCTION ***************************************************
  void setSelectCategoryIndex(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  //          *********************** FUNCTION FOR SEARCH BY CATEGORY  ***************************************************
  List<Category> searchCategories(String query) {
    if (query.isNotEmpty) {
      return categoryList!
          .where((category) => category.categoryName!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    } else {
      return categoryListWithoutQuery!;
    }
  }

  //          *********************** FUNCTION FOR UPDATE BY CATEGORY  ***************************************************
  // Add this method to update the filtered categories
  void updateFilteredCategories(List<Category> filteredCategories) {
    categoryList = filteredCategories;
    notifyListeners();
  }
}
