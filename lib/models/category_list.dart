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
  final String? categoryImage;
  final String? categoryIcon;

  Category({
    this.categoryId,
    this.categoryName,
    this.categorySlug,
    this.productsCount,
    this.categoryImage,
    this.categoryIcon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categorySlug: json["category_slug"],
        productsCount: json["products_count"],
        categoryImage: json["category_image"],
        categoryIcon: json["category_icon"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_slug": categorySlug,
        "products_count": productsCount,
        "category_image": categoryImage,
        "category_icon": categoryIcon,
      };
}
