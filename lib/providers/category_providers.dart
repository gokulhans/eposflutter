import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos_machine/models/category_list.dart';
import 'package:http/http.dart' as http;
import 'package:pos_machine/models/view_category.dart';

import '../resources/app_url.dart';

class CategoryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Category>? categoryList = [];
  List<Category>? categoryListWithoutQuery = [];
  String categoryText = '';
  ViewCategory? viewCategory;
  String parentCategory = '0';
  //bool _isLoading = false;
  CategoryProvider() {
    listAllCategory();
  }
  ViewCategory? get getViewCategory => viewCategory;
  String get getCategoryText => categoryText;
  int categoryCount = 0;
  String get getParentCategory => parentCategory;
  int get getCount => categoryCount;

  setCategoryItemCount(int value) {
    categoryCount = value;
    notifyListeners();
  }

  setParentCategory(String value) {
    parentCategory = value;
    notifyListeners();
  }

  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  List<Category>? get category => categoryList;
  Category categoryDemo = Category(
    categoryId: 0,
    categorySlug: "ALL",
    categoryName: "ALL",
    productsCount: 0,
    categoryIcon: "https://via.placeholder.com/95",
    categoryImage: "https://via.placeholder.com/95",
  );
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
          await http.get(url, headers: {'Content-Type': 'application/json'});
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        // debugPrint('inside');

        debugPrint(json.decode(response.body).toString());
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
  //          *********************** VIEW  CATEGORY USING CATEGORY ID API ***************************************************

  Future<void> viewCategoryApi({required int categoryId}) async {
    debugPrint("VIEW  CATEGORY ");

    final url = Uri.parse("${APPUrl.viewCategoryListUrl}?id=$categoryId");
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        ViewCategoryModel viewCategoryModel =
            ViewCategoryModel.fromJson(jsonData);

        viewCategory = viewCategoryModel.data;

        notifyListeners();
      } else {}
    } finally {}
  }

  //          *********************** ADD CATEGORY  API ***************************************************

  Future<dynamic> addCategory(
      {required String categoryName,
      required String slug,
      required String parentCategory,
      required String categoryNameEnglish,
      required String categoryNameHindi,
      required String categoryNameArabic,
      required String accessToken}) async {
    debugPrint("ADD CATEGORY  API parentCategory $parentCategory ");
    debugPrint("ADD CATEGORY  API categoryName $categoryName ");
    debugPrint("ADD CATEGORY  API slug $slug ");
    debugPrint("ADD CATEGORY  API categoryNameEnglish $categoryNameEnglish ");
    debugPrint("ADD CATEGORY  API categoryNameHindi $categoryNameHindi ");
    debugPrint("ADD CATEGORY  API categoryNameArabic $categoryNameArabic ");

    final Map<String, dynamic> apiBodyData = {
      'name': categoryName,
      'slug': slug,
      'parent_category': parentCategory,
      'category_lang_name[en]': categoryNameEnglish,
      'category_lang_name[hi]': categoryNameHindi,
      'category_lang_name[ar]': categoryNameArabic,
      'category_image': "1",
      'category_icon': "1"
    };
    debugPrint(apiBodyData.toString());
    final url = Uri.parse(APPUrl.addCategoryUrl);
    try {
      final response = await http.post(url, body: apiBodyData, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        listAllCategory();
        notifyListeners();
        debugPrint(json.decode(response.body).toString());
        debugPrint(json.decode(response.body).toString());
        return json.decode(response.body);
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

  //          *********************** EDIT CATEGORY  API ***************************************************
  Future<dynamic> editCategory(
      {required int categoryId,
      required String categoryName,
      required String slug,
      required String parentCategory,
      required String categoryNameEnglish,
      required String categoryNameHindi,
      required String categoryNameArabic,
      required String accessToken}) async {
    debugPrint("ADD CATEGORY  API parentCategory $parentCategory ");
    debugPrint("ADD CATEGORY  API categoryName $categoryName ");
    debugPrint("ADD CATEGORY  API slug $slug ");
    debugPrint("ADD CATEGORY  API categoryNameEnglish $categoryNameEnglish ");
    debugPrint("ADD CATEGORY  API categoryNameHindi $categoryNameHindi ");
    debugPrint("ADD CATEGORY  API categoryNameArabic $categoryNameArabic ");

    final Map<String, dynamic> apiBodyData = {
      'name': categoryName,
      'slug': slug,
      'parent_category': parentCategory,
      'category_lang_name[en]': categoryNameEnglish,
      'category_lang_name[hi]': categoryNameHindi,
      'category_lang_name[ar]': categoryNameArabic,
    };
    debugPrint(apiBodyData.toString());
    final url = Uri.parse("${APPUrl.editCategoryUrl}/$categoryId");
    try {
      final response = await http.post(url, body: apiBodyData, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        listAllCategory();
        notifyListeners();
        debugPrint(json.decode(response.body).toString());
        debugPrint(json.decode(response.body).toString());
        return json.decode(response.body);
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }
}
