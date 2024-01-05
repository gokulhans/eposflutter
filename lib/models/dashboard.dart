// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) =>
    DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  final String? status;
  final String? message;
  final DashBoardModelData? data;

  DashBoardModel({
    this.status,
    this.message,
    this.data,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DashBoardModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DashBoardModelData {
  final List<ProfileDetail>? profileDetails;
  final Total? totalSales;
  final Total? totalCustomers;

  DashBoardModelData({
    this.profileDetails,
    this.totalSales,
    this.totalCustomers,
  });

  factory DashBoardModelData.fromJson(Map<String, dynamic> json) =>
      DashBoardModelData(
        profileDetails: json["profile_details"] == null
            ? []
            : List<ProfileDetail>.from(
                json["profile_details"]!.map((x) => ProfileDetail.fromJson(x))),
        totalSales: json["total_sales"] == null
            ? null
            : Total.fromJson(json["total_sales"]),
        totalCustomers: json["total_customers"] == null
            ? null
            : Total.fromJson(json["total_customers"]),
      );

  Map<String, dynamic> toJson() => {
        "profile_details": profileDetails == null
            ? []
            : List<dynamic>.from(profileDetails!.map((x) => x.toJson())),
        "total_sales": totalSales?.toJson(),
        "total_customers": totalCustomers?.toJson(),
      };
}

class ProfileDetail {
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

  ProfileDetail({
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

  factory ProfileDetail.fromJson(Map<String, dynamic> json) => ProfileDetail(
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

class Total {
  final int? today;
  final int? week;
  final int? month;

  Total({
    this.today,
    this.week,
    this.month,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        today: json["today"],
        week: json["week"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "today": today,
        "week": week,
        "month": month,
      };
}
