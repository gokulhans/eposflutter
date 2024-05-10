// To parse this JSON data, do
//
//     final getSuppliersModel = getSuppliersModelFromJson(jsonString);

import 'dart:convert';

GetSuppliersModel getSuppliersModelFromJson(String str) =>
    GetSuppliersModel.fromJson(json.decode(str));

String getSuppliersModelToJson(GetSuppliersModel data) =>
    json.encode(data.toJson());

class GetSuppliersModel {
  final String? status;
  final List<GetSuppliersModelData>? data;

  GetSuppliersModel({
    this.status,
    this.data,
  });

  factory GetSuppliersModel.fromJson(Map<String, dynamic> json) =>
      GetSuppliersModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<GetSuppliersModelData>.from(
                json["data"]!.map((x) => GetSuppliersModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetSuppliersModelData {
  final int? id;
  final int? userId;
  final String? name;
  final String? phone;
  final String? email;
  final String? productCategory;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GetSuppliersModelData({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.email,
    this.productCategory,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory GetSuppliersModelData.fromJson(Map<String, dynamic> json) =>
      GetSuppliersModelData(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        productCategory: json["product_category"],
        address: json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "email": email,
        "product_category": productCategory,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
