// To parse this JSON data, do
//
//     final resetPasswordModelError = resetPasswordModelErrorFromJson(jsonString);

import 'dart:convert';

ResetPasswordModelError resetPasswordModelErrorFromJson(String str) =>
    ResetPasswordModelError.fromJson(json.decode(str));

String resetPasswordModelErrorToJson(ResetPasswordModelError data) =>
    json.encode(data.toJson());

class ResetPasswordModelError {
  final String? status;
  final String? message;
  final ResetPasswordModelErrors? errors;

  ResetPasswordModelError({
    this.status,
    this.message,
    this.errors,
  });

  factory ResetPasswordModelError.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModelError(
        status: json["status"],
        message: json["message"],
        errors: json["errors"] == null
            ? null
            : ResetPasswordModelErrors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors?.toJson(),
      };
}

class ResetPasswordModelErrors {
  final List<String>? code;
  final List<String>? password;

  ResetPasswordModelErrors({
    this.code,
    this.password,
  });

  factory ResetPasswordModelErrors.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModelErrors(
        code: json["code"] == null
            ? []
            : List<String>.from(json["code"]!.map((x) => x)),
        password: json["password"] == null
            ? []
            : List<String>.from(json["password"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? [] : List<dynamic>.from(code!.map((x) => x)),
        "password":
            password == null ? [] : List<dynamic>.from(password!.map((x) => x)),
      };
}
