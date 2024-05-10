// To parse this JSON data, do
//
//     final getInvoiceAccountTypesModel = getInvoiceAccountTypesModelFromJson(jsonString);

import 'dart:convert';

GetInvoiceAccountTypesModel getInvoiceAccountTypesModelFromJson(String str) =>
    GetInvoiceAccountTypesModel.fromJson(json.decode(str));

String getInvoiceAccountTypesModelToJson(GetInvoiceAccountTypesModel data) =>
    json.encode(data.toJson());

class GetInvoiceAccountTypesModel {
  final String? status;
  final String? message;
  final Map<String, String>? getInvoiceAccountTypesModelData;

  GetInvoiceAccountTypesModel({
    this.status,
    this.message,
    this.getInvoiceAccountTypesModelData,
  });

  factory GetInvoiceAccountTypesModel.fromJson(Map<String, dynamic> json) =>
      GetInvoiceAccountTypesModel(
        status: json["status"],
        message: json["message"],
        getInvoiceAccountTypesModelData: Map.from(json["data"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(getInvoiceAccountTypesModelData!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
