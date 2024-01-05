// To parse this JSON data, do
//
//     final forgotModelError = forgotModelErrorFromJson(jsonString);

import 'dart:convert';

ForgotModelError forgotModelErrorFromJson(String str) =>
    ForgotModelError.fromJson(json.decode(str));

String forgotModelErrorToJson(ForgotModelError data) =>
    json.encode(data.toJson());

class ForgotModelError {
  final String? status;
  final String? message;
  final Errors? errors;

  ForgotModelError({
    this.status,
    this.message,
    this.errors,
  });

  factory ForgotModelError.fromJson(Map<String, dynamic> json) =>
      ForgotModelError(
        status: json["status"],
        message: json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors?.toJson(),
      };
}

class Errors {
  final List<String>? email;

  Errors({
    this.email,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
      };
}
