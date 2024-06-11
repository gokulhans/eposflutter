import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pos_machine/models/get_invoice_account_type.dart';
import 'package:pos_machine/models/get_voucher_account_type.dart';

import '../models/get_payment_method.dart';

import '../models/get_users.dart';

import '../models/list_transaction.dart';
import '../resources/app_url.dart';

class InvoiceProvider extends ChangeNotifier {
  bool isLoading = false;
  ListTransaction? listTransaction;
  List<ListTransaction>? transactionListDetails;
  Map<String, String>? paymentList;
  Map<String, String>? getVoucherAccountTypesModelData = {};
  Map<String, String>? getInvoiceAccountTypesModelData = {};
  List<GetUsersModelData>? getUsersList = [];
  ListTransaction? get getListTransaction => listTransaction;
  List<GetUsersModelData>? get getUsersListAPI => getUsersList;
  Map<String, String>? get getVoucherAccountTypes =>
      getVoucherAccountTypesModelData;
  Map<String, String>? get getInvoiceAccountTypes =>
      getInvoiceAccountTypesModelData;
  Map<String, String>? get getPaymentType => paymentList;

  String? getUserUpOnId(int value) {
    var user = getUsersList!.firstWhere((e) => e.id == value,
        // sample data
        // orElse: () => GetUsersModelData(id: 0, name: "Unknown"));
        orElse: () => GetUsersModelData(id: 0, name: "Super Admin"));

    return user.name;
  }

  void callListTransactionDetails({required transactionId}) {
    ListTransaction transaction = transactionListDetails!
        .firstWhere((element) => element.id == transactionId);
    listTransaction = transaction;
    notifyListeners();
  }

  String? getInvoiceNameUpOnId(int value, String type) {
    var accountTypes = getInvoiceAccountTypes;
    var accountVoucherTypes = getVoucherAccountTypesModelData;
    if (accountTypes != null && accountVoucherTypes != null) {
      // return accountTypes[value];
      String? accountTypeName = type == 'Cr'
          ? accountTypes['$value']
          : accountVoucherTypes['$value']; // Retrieve payment type with key '1'
      debugPrint(accountTypeName);
      return accountTypeName;
    }
    return null;
  }

  String? getVoucherNameUpOnId(int value) {
    var accountTypes = getVoucherAccountTypesModelData;
    if (accountTypes != null) {
      return accountTypes[value];
    }
    return null;
  }

  InvoiceProvider();

  //          *********************** LIST ALL PAYMENT LIST  API ***************************************************

  Future<void> listAllPaymentList(
    String accessToken,
  ) async {
    debugPrint("LIST ALL listAllPaymentList ");

    final url = Uri.parse(APPUrl.listTransactionType);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        GetPaymentMethodsModel getPaymentMethodsModel =
            GetPaymentMethodsModel.fromJson(jsonData);

        paymentList = getPaymentMethodsModel.paymentList;

        notifyListeners();
      } else {}
    } finally {}
  }
  //          *********************** LIST ALL INVOICE ACCOUNT TYPES  API ***************************************************

  Future<void> listAllInvoiceAccountTypes(
    String accessToken,
  ) async {
    debugPrint("LIST ALL listAllInvoiceAccountTypes ");

    final url = Uri.parse(APPUrl.listInvoiceAccountType);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        // debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);
        GetInvoiceAccountTypesModel getInvoiceAccountTypesModel =
            GetInvoiceAccountTypesModel.fromJson(jsonData);

        getInvoiceAccountTypesModelData =
            getInvoiceAccountTypesModel.getInvoiceAccountTypesModelData;

        notifyListeners();
      } else {}
    } finally {}
  }
  //          *********************** LIST VOUCHER ACCOUNT TYPE  API ***************************************************

  Future<void> listVoucherAccountType(
    String accessToken,
  ) async {
    debugPrint("LIST ALL listVoucherAccountType ");

    final url = Uri.parse(APPUrl.listVoucherAccountType);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        //   debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);
        GetVoucherAccountTypesModel getVoucherAccountTypesModel =
            GetVoucherAccountTypesModel.fromJson(jsonData);
        getVoucherAccountTypesModelData =
            getVoucherAccountTypesModel.getVoucherAccountTypesModelData;
        notifyListeners();
      } else {}
    } finally {}
  }
  //          *********************** LIST USERS LIST  API ***************************************************

  Future<void> listUsersList(
    String accessToken,
  ) async {
    debugPrint("LIST ALL listUsersList ");

    final url = Uri.parse(APPUrl.listUser);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        //   debugPrint(response.body.toString());
        final jsonData = json.decode(response.body);
        GetUsersModel getUsersModel = GetUsersModel.fromJson(jsonData);
        getUsersList = getUsersModel.data;
        notifyListeners();
      } else {}
    } finally {}
  }

  //          *********************** ADD VOUCHER / INVOICE  API ***************************************************

  Future<dynamic> addVoucher({
    required String accountType,
    required String paymentMethod,
    required String paymentMethodRef,
    required String amount,
    required String toUserID,
    required String type,
    required String comment,
    required String particular,
    required String accessToken,
  }) async {
    debugPrint("$comment $particular");
    final Map<String, dynamic> apiBodyData = type == "invoice"
        ? {
            'type': type,
            "from_id": toUserID,
            'amount': amount,
            'payment_method_ref': paymentMethodRef,
            'payment_method': paymentMethod,
            'account_type': accountType,
            'comment': comment,
            'particulars': particular
          }
        : {
            'type': type,
            'to_id': toUserID,
            'amount': amount,
            'payment_method_ref': paymentMethodRef,
            'payment_method': paymentMethod,
            'account_type': accountType,
            'comment': comment,
            'particulars': particular
          };
    debugPrint(apiBodyData.toString());
    final url = Uri.parse(APPUrl.addInvoiceorVoucher);
    try {
      final response = await http.post(url, body: apiBodyData, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());

        return json.decode(response.body);
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }
  //          *********************** LIST ALL TRANSACTION ALL/ INVOICE/ VOUCHER  API ***************************************************

  Future<dynamic> listAllTransaction({
    required String? type,
    required String accessToken,
  }) async {
    final Map<String, dynamic> apiBodyData = {
      'type': type,
    };
    debugPrint(apiBodyData.toString());
    final url = type == null
        ? Uri.parse(APPUrl.listAllTransaction)
        : type == "Cr"
            ? Uri.parse("${APPUrl.listAllTransaction}?type=Cr")
            : Uri.parse("${APPUrl.listAllTransaction}?type=Dr");
    try {
      final response = await http.get(url, headers: {
        //'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        ListTransactionModel listTransactionModel =
            ListTransactionModel.fromJson(jsonData);

        transactionListDetails = listTransactionModel.data;
        notifyListeners();
        return json.decode(response.body);
      } else {}
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
  }
  //          *********************** CALL DETAILS OF TRANSACTION / INVOICE/ VOUCHER  API ***************************************************

  Future<void> callDetailsOfTransaction({
    required int id,
    required String accessToken,
  }) async {
    debugPrint("CALL DETAILS OF TRANSACTION / INVOICE/ VOUCHER  API");
    final url = Uri.parse("${APPUrl.detailsOfTransaction}?id=$id");

    try {
      final response = await http.get(url, headers: {
        //'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      debugPrint('inside ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.decode(response.body).toString());
        final jsonData = json.decode(response.body);
        ListTransaction listTransactionModel =
            ListTransaction.fromJson(jsonData["data"]);

        listTransaction = listTransactionModel;
        notifyListeners();
      } else {}
    } finally {}
  }
}
