// To parse this JSON data, do
//
//     final getProductListFileModel = getProductListFileModelFromJson(jsonString);

import 'dart:convert';

GetProductListFileModel getProductListFileModelFromJson(String str) =>
    GetProductListFileModel.fromJson(json.decode(str));

String getProductListFileModelToJson(GetProductListFileModel data) =>
    json.encode(data.toJson());

class GetProductListFileModel {
  final String? status;
  final String? message;
  final List<GetProductListFileModelData>? data;

  GetProductListFileModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetProductListFileModel.fromJson(Map<String, dynamic> json) =>
      GetProductListFileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetProductListFileModelData>.from(json["data"]!
                .map((x) => GetProductListFileModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetProductListFileModelData {
  final int? id;
  final String? title;
  final String? path;
  final String? alt;
  final String? width;
  final String? height;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? s3Url;

  GetProductListFileModelData({
    this.id,
    this.title,
    this.path,
    this.alt,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
    this.s3Url,
  });

  factory GetProductListFileModelData.fromJson(Map<String, dynamic> json) =>
      GetProductListFileModelData(
        id: json["id"],
        title: json["title"],
        path: json["path"],
        alt: json["alt"],
        width: json["width"],
        height: json["height"],
        s3Url: json["s3Url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "path": path,
        "alt": alt,
        "width": width,
        "height": height,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "s3Url": s3Url,
      };
}
