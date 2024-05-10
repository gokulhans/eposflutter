// To parse this JSON data, do
//
//     final viewStockModel = viewStockModelFromJson(jsonString);

import 'dart:convert';

import 'package:pos_machine/models/list_stock.dart';

ViewStockModel viewStockModelFromJson(String str) =>
    ViewStockModel.fromJson(json.decode(str));

String viewStockModelToJson(ViewStockModel data) => json.encode(data.toJson());

class ViewStockModel {
  final String? status;
  final String? message;
  final ViewStockModelData? data;

  ViewStockModel({
    this.status,
    this.message,
    this.data,
  });

  factory ViewStockModel.fromJson(Map<String, dynamic> json) => ViewStockModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : ViewStockModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ViewStockModelData {
  final int? id;
  final int? productId;
  final int? storeId;
  final int? userId;
  final int? quantity;
  final String? unit;
  final int? purchaseRate;
  final int? retailPrice;
  final int? wholesalePrice;
  final int? wholesaleMinUnit;
  final DateTime? expiryDate;
  final String? batchNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? productName;
  final String? storeName;
  final String? userName;
  final List<dynamic>? stockProperties;
  final ProductDetails? product;
  final StoreDetails? store;
  final UserDetails? user;

  ViewStockModelData({
    this.id,
    this.productId,
    this.storeId,
    this.userId,
    this.quantity,
    this.unit,
    this.purchaseRate,
    this.retailPrice,
    this.wholesalePrice,
    this.wholesaleMinUnit,
    this.expiryDate,
    this.batchNumber,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.storeName,
    this.userName,
    this.stockProperties,
    this.product,
    this.store,
    this.user,
  });

  factory ViewStockModelData.fromJson(Map<String, dynamic> json) =>
      ViewStockModelData(
        id: json["id"],
        productId: json["product_id"],
        storeId: json["store_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
        unit: json["unit"],
        purchaseRate: json["purchase_rate"],
        retailPrice: json["retail_price"],
        wholesalePrice: json["wholesale_price"],
        wholesaleMinUnit: json["wholesale_min_unit"],
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        batchNumber: json["batch_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productName: json["product_name"],
        storeName: json["store_name"],
        userName: json["user_name"],
        stockProperties: json["stock_properties"] == null
            ? []
            : List<dynamic>.from(json["stock_properties"]!.map((x) => x)),
        product: json["product"] == null
            ? null
            : ProductDetails.fromJson(json["product"]),
        store:
            json["store"] == null ? null : StoreDetails.fromJson(json["store"]),
        user: json["user"] == null ? null : UserDetails.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "store_id": storeId,
        "user_id": userId,
        "quantity": quantity,
        "unit": unit,
        "purchase_rate": purchaseRate,
        "retail_price": retailPrice,
        "wholesale_price": wholesalePrice,
        "wholesale_min_unit": wholesaleMinUnit,
        "expiry_date":
            "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
        "batch_number": batchNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_name": productName,
        "store_name": storeName,
        "user_name": userName,
        "stock_properties": stockProperties == null
            ? []
            : List<dynamic>.from(stockProperties!.map((x) => x)),
        "product": product?.toJson(),
        "store": store?.toJson(),
        "user": user?.toJson(),
      };
}

class UserDetails {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? phoneVerified;
  final dynamic emailVerifiedAt;
  final String? defaultPassword;
  final int? doneBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserDetails({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.phoneVerified,
    this.emailVerifiedAt,
    this.defaultPassword,
    this.doneBy,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        phoneVerified: json["phone_verified"],
        emailVerifiedAt: json["email_verified_at"],
        defaultPassword: json["default_password"],
        doneBy: json["done_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "phone_verified": phoneVerified,
        "email_verified_at": emailVerifiedAt,
        "default_password": defaultPassword,
        "done_by": doneBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
