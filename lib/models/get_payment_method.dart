// To parse this JSON data, do
//
//     final getPaymentMethodsModel = getPaymentMethodsModelFromJson(jsonString);

import 'dart:convert';

GetPaymentMethodsModel getPaymentMethodsModelFromJson(String str) =>
    GetPaymentMethodsModel.fromJson(json.decode(str));

class GetPaymentMethodsModel {
  final String? status;
  final String? message;
  final Map<String, String>? paymentList;

  GetPaymentMethodsModel({
    this.status,
    this.message,
    this.paymentList,
  });

  factory GetPaymentMethodsModel.fromJson(Map<String, dynamic> json) =>
      GetPaymentMethodsModel(
        status: json["status"],
        message: json["message"],
        paymentList: json["data"] == null
            ? null
            : Map<String, String>.from(json['data']),
      );
}

class GetPaymentMethodsModelData {
  final String? cod;
  final String? cash;
  final String? upi;
  final String? card;
  final String? cheque;

  GetPaymentMethodsModelData({
    this.cod,
    this.cash,
    this.upi,
    this.card,
    this.cheque,
  });

  factory GetPaymentMethodsModelData.fromJson(Map<String, dynamic> json) =>
      GetPaymentMethodsModelData(
        cod: json["COD"],
        cash: json["CASH"],
        upi: json["UPI"],
        card: json["CARD"],
        cheque: json["CHEQUE"],
      );

  Map<String, dynamic> toJson() => {
        "COD": cod,
        "CASH": cash,
        "UPI": upi,
        "CARD": card,
        "CHEQUE": cheque,
      };
}
