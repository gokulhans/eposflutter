// To parse this JSON data, do
//
//     final getVoucherAccountTypesModel = getVoucherAccountTypesModelFromJson(jsonString);

import 'dart:convert';

GetVoucherAccountTypesModel getVoucherAccountTypesModelFromJson(String str) =>
    GetVoucherAccountTypesModel.fromJson(json.decode(str));

String getVoucherAccountTypesModelToJson(GetVoucherAccountTypesModel data) =>
    json.encode(data.toJson());

class GetVoucherAccountTypesModel {
  final String? status;
  final String? message;
  final Map<String, String>? getVoucherAccountTypesModelData;

  GetVoucherAccountTypesModel({
    this.status,
    this.message,
    this.getVoucherAccountTypesModelData,
  });

  factory GetVoucherAccountTypesModel.fromJson(Map<String, dynamic> json) =>
      GetVoucherAccountTypesModel(
        status: json["status"],
        message: json["message"],
        getVoucherAccountTypesModelData: Map.from(json["data"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(getVoucherAccountTypesModelData!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
