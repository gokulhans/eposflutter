// To parse this JSON data, do
//
//     final executiveModel = executiveModelFromJson(jsonString);

import 'dart:convert';

ExecutiveModel executiveModelFromJson(String str) =>
    ExecutiveModel.fromJson(json.decode(str));

String executiveModelToJson(ExecutiveModel data) => json.encode(data.toJson());

class ExecutiveModel {
  final String? status;
  final String? message;
  final String? accessToken;
  final String? tokenType;

  ExecutiveModel({
    this.status,
    this.message,
    this.accessToken,
    this.tokenType,
  });

  factory ExecutiveModel.fromJson(Map<String, dynamic> json) => ExecutiveModel(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
