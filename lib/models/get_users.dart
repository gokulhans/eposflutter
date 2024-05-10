// To parse this JSON data, do
//
//     final getUsersModel = getUsersModelFromJson(jsonString);

import 'dart:convert';

GetUsersModel getUsersModelFromJson(String str) =>
    GetUsersModel.fromJson(json.decode(str));

String getUsersModelToJson(GetUsersModel data) => json.encode(data.toJson());

class GetUsersModel {
  final String? status;
  final String? message;
  final List<GetUsersModelData>? data;

  GetUsersModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetUsersModel.fromJson(Map<String, dynamic> json) => GetUsersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetUsersModelData>.from(
                json["data"]!.map((x) => GetUsersModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetUsersModelData {
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
  final List<Role>? roles;

  GetUsersModelData({
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
    this.roles,
  });

  factory GetUsersModelData.fromJson(Map<String, dynamic> json) =>
      GetUsersModelData(
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
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
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
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  final String? name;
  final Pivot? pivot;

  Role({
    this.name,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
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
