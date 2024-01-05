// To parse this JSON data, do
//
//     final customerListModel = customerListModelFromJson(jsonString);

import 'dart:convert';

CustomerListModel customerListModelFromJson(String str) =>
    CustomerListModel.fromJson(json.decode(str));

String customerListModelToJson(CustomerListModel data) =>
    json.encode(data.toJson());

class CustomerListModel {
  final String? status;
  final String? message;
  final List<CustomerListModelData>? data;

  CustomerListModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) =>
      CustomerListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CustomerListModelData>.from(
                json["data"]!.map((x) => CustomerListModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CustomerListModelData {
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
  final List<Customer>? customers;

  CustomerListModelData({
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
    this.customers,
  });

  factory CustomerListModelData.fromJson(Map<String, dynamic> json) =>
      CustomerListModelData(
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
        customers: json["customers"] == null
            ? []
            : List<Customer>.from(
                json["customers"]!.map((x) => Customer.fromJson(x))),
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
        "customers": customers == null
            ? []
            : List<dynamic>.from(customers!.map((x) => x.toJson())),
      };
}

class Customer {
  final int? id;
  final int? userId;
  final String? address;
  final String? pinCode;
  final int? city;
  final int? state;
  final int? country;
  final int? storeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Customer({
    this.id,
    this.userId,
    this.address,
    this.pinCode,
    this.city,
    this.state,
    this.country,
    this.storeId,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        pinCode: json["pin_code"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        storeId: json["store_id"],
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
        "address": address,
        "pin_code": pinCode,
        "city": city,
        "state": state,
        "country": country,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
