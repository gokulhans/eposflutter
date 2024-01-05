// To parse this JSON data, do
//
//     final addToCustomerModel = addToCustomerModelFromJson(jsonString);

import 'dart:convert';

AddToCustomerModel addToCustomerModelFromJson(String str) =>
    AddToCustomerModel.fromJson(json.decode(str));

String addToCustomerModelToJson(AddToCustomerModel data) =>
    json.encode(data.toJson());

class AddToCustomerModel {
  final String? status;
  final AddToCustomerModelData? data;
  final String? message;

  AddToCustomerModel({
    this.status,
    this.data,
    this.message,
  });

  factory AddToCustomerModel.fromJson(Map<String, dynamic> json) =>
      AddToCustomerModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : AddToCustomerModelData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class AddToCustomerModelData {
  final String? name;
  final String? email;
  final String? phone;
  final String? defaultPassword;
  final String? phoneVerified;
  final int? doneBy;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final List<Role>? roles;

  AddToCustomerModelData({
    this.name,
    this.email,
    this.phone,
    this.defaultPassword,
    this.phoneVerified,
    this.doneBy,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.roles,
  });

  factory AddToCustomerModelData.fromJson(Map<String, dynamic> json) =>
      AddToCustomerModelData(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        defaultPassword: json["default_password"],
        phoneVerified: json["phone_verified"],
        doneBy: json["done_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "default_password": defaultPassword,
        "phone_verified": phoneVerified,
        "done_by": doneBy,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  final int? id;
  final String? name;
  final String? guardName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  final int? modelId;
  final int? roleId;
  final String? modelType;

  Pivot({
    this.modelId,
    this.roleId,
    this.modelType,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
