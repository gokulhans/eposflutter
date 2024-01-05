import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  final List<Category>? category;
  final String? status;

  CategoryListModel({
    this.category,
    this.status,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "status": status,
      };
}

class Category {
  final int? categoryId;
  final String? categoryName;
  final String? categorySlug;
  final int? productsCount;

  Category({
    this.categoryId,
    this.categoryName,
    this.categorySlug,
    this.productsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categorySlug: json["category_slug"],
        productsCount: json["products_count"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_slug": categorySlug,
        "products_count": productsCount,
      };
}
