// To parse this JSON data, do
//
//     final listTransactionModel = listTransactionModelFromJson(jsonString);

import 'dart:convert';

ListTransactionModel listTransactionModelFromJson(String str) =>
    ListTransactionModel.fromJson(json.decode(str));

String listTransactionModelToJson(ListTransactionModel data) =>
    json.encode(data.toJson());

class ListTransactionModel {
  final String? status;
  final String? message;
  final List<ListTransaction>? data;

  ListTransactionModel({
    this.status,
    this.message,
    this.data,
  });

  factory ListTransactionModel.fromJson(Map<String, dynamic> json) =>
      ListTransactionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ListTransaction>.from(
                json["data"]!.map((x) => ListTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListTransaction {
  final int? id;
  final int? companyId;
  final String? type;
  final String? paymentMethod;
  final int? accountId;
  final String? amount;
  final String? currency;
  final int? userId;
  final int? orderId;
  final String? transactionComment;
  final dynamic reference;
  final String? status;
  final int? createdBy;
  final int? verifiedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;
  final String? accountName;
  final User? user;
  final Account? account;

  ListTransaction({
    this.id,
    this.companyId,
    this.type,
    this.paymentMethod,
    this.accountId,
    this.amount,
    this.currency,
    this.userId,
    this.orderId,
    this.transactionComment,
    this.reference,
    this.status,
    this.createdBy,
    this.verifiedBy,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.accountName,
    this.user,
    this.account,
  });

  factory ListTransaction.fromJson(Map<String, dynamic> json) =>
      ListTransaction(
        id: json["id"],
        companyId: json["company_id"],
        type: json["type"],
        paymentMethod: json["payment_method"],
        accountId: json["account_id"],
        amount: json["amount"],
        currency: json["currency"],
        userId: json["user_id"],
        orderId: json["order_id"],
        transactionComment: json["transaction_comment"],
        reference: json["reference"],
        status: json["status"],
        createdBy: json["created_by"],
        verifiedBy: json["verified_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
        accountName: json["account_name"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "type": type,
        "payment_method": paymentMethod,
        "account_id": accountId,
        "amount": amount,
        "currency": currency,
        "user_id": userId,
        "order_id": orderId,
        "transaction_comment": transactionComment,
        "reference": reference,
        "status": status,
        "created_by": createdBy,
        "verified_by": verifiedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_name": userName,
        "account_name": accountName,
        "user": user?.toJson(),
        "account": account?.toJson(),
      };
}

class Account {
  final int? id;
  final String? accountType;
  final String? accountName;
  final String? accountLabel;
  final int? userId;
  final int? storeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Account({
    this.id,
    this.accountType,
    this.accountName,
    this.accountLabel,
    this.userId,
    this.storeId,
    this.createdAt,
    this.updatedAt,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        accountType: json["account_type"],
        accountName: json["account_name"],
        accountLabel: json["account_label"],
        userId: json["user_id"],
        storeId: json["store_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_type": accountType,
        "account_name": accountName,
        "account_label": accountLabel,
        "user_id": userId,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
