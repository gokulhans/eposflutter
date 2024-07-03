// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromJson(jsonString);

import 'dart:convert';

GetProductModel getProductModelFromJson(String str) =>
    GetProductModel.fromJson(json.decode(str));

String getProductModelToJson(GetProductModel data) =>
    json.encode(data.toJson());

class GetProductModel {
  final List<GetProduct>? product;
  final String? status;

  GetProductModel({
    this.product,
    this.status,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) =>
      GetProductModel(
        product: json["product"] == null
            ? []
            : List<GetProduct>.from(
                json["product"]!.map((x) => GetProduct.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "product": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
        "status": status,
      };
}

class GetProduct {
  final int? productId;
  final int? categoryId;
  final String? productName;
  final String? productSlug;
  final String? barcode;
  final List<ProductCategory>? category;
  final String? numberOfProductsAvailble;
  final String? rating;
  final String? unit;
  final String? currency;
  final dynamic description;
  final ProductPrice? price;
  final List<Attachment>? attachment;
  bool isSelected = false;
  final Names? names;
  final List<ProductProp>? productProps; // Changed from Map<String, String>?

  // final List<dynamic>? propValues;
  // final List<dynamic>? attachement;

  GetProduct({
    this.productId,
    this.categoryId,
    this.productName,
    this.productSlug,
    this.barcode,
    this.category,
    this.numberOfProductsAvailble,
    this.rating,
    this.price,
    this.unit,
    this.currency,
    this.description,
    this.attachment,
    this.names,
    this.productProps,
  });

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        productId: json["product_id"],
        categoryId: json["category_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        barcode: json["barcode"],
        category: json["category"] == null
            ? []
            : List<ProductCategory>.from(
                json["category"]!.map((x) => ProductCategory.fromJson(x))),
        numberOfProductsAvailble: json["number_of_products_availble"],
        rating: json["rating"],
        unit: json["unit"],
        currency: json["currency"],
        description: json["description"],
        price:
            json["price"] == null ? null : ProductPrice.fromJson(json["price"]),
        attachment: json["attachment"] == null
            ? []
            : List<Attachment>.from(
                json["attachment"]!.map((x) => Attachment.fromJson(x))),
        names: json["names"] == null ? null : Names.fromJson(json["names"]),
        productProps: json["product_props"] == null
            ? []
            : List<ProductProp>.from(
                json["product_props"]!.map((x) => ProductProp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "category_id": categoryId,
        "product_name": productName,
        "product_slug": productSlug,
        "barcode": barcode,
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "number_of_products_availble": numberOfProductsAvailble,
        "rating": rating,
        "price": price?.toJson(),
        "unit": unit,
        "currency": currency,
        "description": description,

        "attachment": attachment == null
            ? []
            : List<dynamic>.from(attachment!.map((x) => x.toJson())),
        // "attachement": attachement == null
        //     ? []
        //     : List<dynamic>.from(attachement!.map((x) => x)),
        "names": names?.toJson(),
        "product_props": productProps == null
            ? []
            : List<dynamic>.from(productProps!.map((x) => x.toJson())),
      };
}

class Attachment {
  final int? id;
  final int? productId;
  final int? userId;
  final String? title;
  final int? isPrimary;
  final String? fileType;
  final String? filePath;
  final String? status;
  final String? alt;
  final String? description;

  Attachment({
    this.id,
    this.productId,
    this.userId,
    this.title,
    this.isPrimary,
    this.fileType,
    this.filePath,
    this.status,
    this.alt,
    this.description,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        title: json["title"],
        isPrimary: json["is_primary"],
        fileType: json["file_type"],
        filePath: json["file_path"],
        status: json["status"],
        alt: json["alt"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "title": title,
        "is_primary": isPrimary,
        "file_type": fileType,
        "file_path": filePath,
        "status": status,
        "alt": alt,
        "description": description,
      };
}

class ProductCategory {
  final String? name;
  final String? slug;

  ProductCategory({
    this.name,
    this.slug,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
      };
}

class ProductPrice {
  final dynamic oldPrice;
  final dynamic price;
  final dynamic percentage;

  ProductPrice({
    this.oldPrice,
    this.price,
    this.percentage,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
        oldPrice: json["old_price"],
        price: json["price"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "old_price": oldPrice,
        "price": price,
        "percentage": percentage,
      };
}

class Names {
  final String? en;
  final String? hi;
  final String? ar;

  Names({
    this.en,
    this.hi,
    this.ar,
  });

  factory Names.fromJson(Map<String, dynamic> json) => Names(
        en: json["en"],
        hi: json["hi"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "hi": hi,
        "ar": ar,
      };
}

class ProductProp {
  final int? id;
  final int? categoryId;
  final String? propsCode;
  final String? label;
  final String? masterValue;
  final String? type;
  final int? propsId;
  final String? stockApplicable;

  ProductProp({
    this.id,
    this.categoryId,
    this.propsCode,
    this.label,
    this.masterValue,
    this.type,
    this.propsId,
    this.stockApplicable,
  });

  factory ProductProp.fromJson(Map<String, dynamic> json) => ProductProp(
        id: json["id"],
        categoryId: json["category_id"],
        propsCode: json["props_code"],
        label: json["label"],
        masterValue: json["master_value"],
        type: json["type"],
        propsId: json["props_id"],
        stockApplicable: json["stock_applicable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "props_code": propsCode,
        "label": label,
        "master_value": masterValue,
        "type": type,
        "props_id": propsId,
        "stock_applicable": stockApplicable,
      };
}
