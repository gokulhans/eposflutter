// To parse this JSON data, do
//
//     final listOrderModel = listOrderModelFromJson(jsonString);

import 'dart:convert';

import 'add_to_cart.dart';

ListSalesOrderModel listOrderModelFromJson(String str) =>
    ListSalesOrderModel.fromJson(json.decode(str));

String listOrderModelToJson(ListSalesOrderModel data) =>
    json.encode(data.toJson());

class ListSalesOrderModel {
  final String? status;
  final List<ListOrderModelData>? data;

  ListSalesOrderModel({
    this.status,
    this.data,
  });

  factory ListSalesOrderModel.fromJson(Map<String, dynamic> json) =>
      ListSalesOrderModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ListOrderModelData>.from(
                json["data"]!.map((x) => ListOrderModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListOrderModelData {
  final int? ordersId;
  final int? storeId;
  final String? orderDate;
  final int? cartId;
  final String? orderNumber;
  final String? orderStatus;
  final CustomerDetails? customerDetails;
  final PriceSummary? priceSummary;
  final int? totalItems;
  final dynamic paymentStatus;
  final dynamic deliveryStatus;
  final PaymentDetails? paymentDetails;
  final List<OrderProp>? orderProps;

  ListOrderModelData({
    this.ordersId,
    this.storeId,
    this.orderDate,
    this.cartId,
    this.orderNumber,
    this.orderStatus,
    this.customerDetails,
    this.priceSummary,
    this.totalItems,
    this.paymentStatus,
    this.deliveryStatus,
    this.paymentDetails,
    this.orderProps,
  });

  factory ListOrderModelData.fromJson(Map<String, dynamic> json) =>
      ListOrderModelData(
        ordersId: json["orders_id"],
        storeId: json["store_id"],
        orderDate: json["order_date"],
        cartId: json["cart_id"],
        orderNumber: json["order_number"],
        orderStatus: json["order_status"],
        customerDetails: json["customer_details"] == null
            ? null
            : CustomerDetails.fromJson(json["customer_details"]),
        priceSummary: json["price_summary"] == null
            ? null
            : PriceSummary.fromJson(json["price_summary"]),
        totalItems: json["total_items"],
        paymentStatus: json["payment_status"],
        deliveryStatus: json["delivery_status"],
        paymentDetails: json["payment_details"] == null
            ? null
            : PaymentDetails.fromJson(json["payment_details"]),
        orderProps: json["order_props"] == null
            ? []
            : List<OrderProp>.from(
                json["order_props"]!.map((x) => OrderProp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders_id": ordersId,
        "store_id": storeId,
        "order_date": orderDate,
        "cart_id": cartId,
        "order_number": orderNumber,
        "order_status": orderStatus,
        "customer_details": customerDetails?.toJson(),
        "price_summary": priceSummary?.toJson(),
        "total_items": totalItems,
        "payment_status": paymentStatus,
        "delivery_status": deliveryStatus,
        "payment_details": paymentDetails?.toJson(),
        "order_props": orderProps == null
            ? []
            : List<dynamic>.from(orderProps!.map((x) => x.toJson())),
      };
}

class CustomerDetails {
  final String? name;
  final String? email;
  final String? phone;
  final int? customerId;

  CustomerDetails({
    this.name,
    this.email,
    this.phone,
    this.customerId,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "customer_id": customerId,
      };
}

class OrderProp {
  final String? propsId;
  final String? propsValue;

  OrderProp({
    this.propsId,
    this.propsValue,
  });

  factory OrderProp.fromJson(Map<String, dynamic> json) => OrderProp(
        propsId: json["props_id"],
        propsValue: json["props_value"],
      );

  Map<String, dynamic> toJson() => {
        "props_id": propsId,
        "props_value": propsValue,
      };
}

class PaymentDetails {
  final int? paymentId;
  final String? paymentStatus;

  PaymentDetails({
    this.paymentId,
    this.paymentStatus,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        paymentId: json["payment_id"],
        paymentStatus: json["payment_status"],
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "payment_status": paymentStatus,
      };
}

// class PriceSummary {
//     final int? subTotal;
//     final int? totalTax;
//     final int? netTotal;
//     final int? discount;
//     final int? netPayable;

//     PriceSummary({
//         this.subTotal,
//         this.totalTax,
//         this.netTotal,
//         this.discount,
//         this.netPayable,
//     });

//     factory PriceSummary.fromJson(Map<String, dynamic> json) => PriceSummary(
//         subTotal: json["sub_total"],
//         totalTax: json["total_tax"],
//         netTotal: json["net_total"],
//         discount: json["discount"],
//         netPayable: json["net_payable"],
//     );

//     Map<String, dynamic> toJson() => {
//         "sub_total": subTotal,
//         "total_tax": totalTax,
//         "net_total": netTotal,
//         "discount": discount,
//         "net_payable": netPayable,
//     };
//}
