// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(String str) =>
    AddToCartModel.fromJson(json.decode(str));

String addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
  final String? status;
  final AddToCart? cart;

  AddToCartModel({
    this.status,
    this.cart,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        status: json["status"],
        cart: json["cart"] == null ? null : AddToCart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cart": cart?.toJson(),
      };
}

class AddToCart {
  final List<AddToCartCartItem>? cartItem;
  final PriceSummary? priceSummary;

  AddToCart({
    this.cartItem,
    this.priceSummary,
  });

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
        cartItem: json["cart_item"] == null
            ? []
            : List<AddToCartCartItem>.from(
                json["cart_item"]!.map((x) => AddToCartCartItem.fromJson(x))),
        priceSummary: json["price_summary"] == null
            ? null
            : PriceSummary.fromJson(json["price_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_item": cartItem == null
            ? []
            : List<dynamic>.from(cartItem!.map((x) => x.toJson())),
        "price_summary": priceSummary?.toJson(),
      };
}

class AddToCartCartItem {
  final int? cartItemId;
  final int? cartId;
  final int? productId;
  final int? customerId;
  final int? quantity;
  final int? unitPrice;
  final int? totalPrice;
  final String? currency;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final AddToCartProductName? productName;

  AddToCartCartItem({
    this.cartItemId,
    this.cartId,
    this.productId,
    this.customerId,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.currency,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.productName,
  });

  factory AddToCartCartItem.fromJson(Map<String, dynamic> json) =>
      AddToCartCartItem(
        cartItemId: json["cart_item_id"],
        cartId: json["cart_id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        totalPrice: json["total_price"],
        currency: json["currency"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productName: json["product_name"] == null
            ? null
            : AddToCartProductName.fromJson(json["product_name"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_item_id": cartItemId,
        "cart_id": cartId,
        "product_id": productId,
        "customer_id": customerId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "total_price": totalPrice,
        "currency": currency,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_name": productName?.toJson(),
      };
}

class AddToCartProductName {
  final int? id;
  final String? name;
  final int? categoryId;
  final String? slug;
  final int? price;
  final dynamic createdUser;
  final String? updatedUser;
  final String? barcode;
  final String? unit;
  final String? status;
  final String? currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddToCartProductName({
    this.id,
    this.name,
    this.categoryId,
    this.slug,
    this.price,
    this.createdUser,
    this.updatedUser,
    this.barcode,
    this.unit,
    this.status,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  factory AddToCartProductName.fromJson(Map<String, dynamic> json) =>
      AddToCartProductName(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        slug: json["slug"],
        price: json["price"],
        createdUser: json["created_user"],
        updatedUser: json["updated_user"],
        barcode: json["barcode"],
        unit: json["unit"],
        status: json["status"],
        currency: json["currency"],
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
        "category_id": categoryId,
        "slug": slug,
        "price": price,
        "created_user": createdUser,
        "updated_user": updatedUser,
        "barcode": barcode,
        "unit": unit,
        "status": status,
        "currency": currency,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PriceSummary {
  final int? subTotal;
  final int? totalTax;
  final int? netTotal;
  final int? discount;
  final int? netPayable;

  PriceSummary({
    this.subTotal,
    this.totalTax,
    this.netTotal,
    this.discount,
    this.netPayable,
  });

  factory PriceSummary.fromJson(Map<String, dynamic> json) => PriceSummary(
        subTotal: json["sub_total"],
        totalTax: json["total_tax"],
        netTotal: json["net_total"],
        discount: json["discount"],
        netPayable: json["net_payable"],
      );

  Map<String, dynamic> toJson() => {
        "sub_total": subTotal,
        "total_tax": totalTax,
        "net_total": netTotal,
        "discount": discount,
        "net_payable": netPayable,
      };
}
