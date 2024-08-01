import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_machine/models/get_product_sales_report_model.dart';
import 'package:pos_machine/models/get_sales_report_model.dart';
import 'package:pos_machine/models/get_supplier_sales_report_model.dart';

import '../models/get_customer_account_book_model.dart';
import '../resources/app_url.dart';

class ReportsProvider with ChangeNotifier {
  GetCustomerAccountBookResponse? _customerAccountBook;
  GetProductSalesReportResponse? _productSalesReport;
  GetSalesReportResponse? _salesReport;
  GetSupplierSalesReportResponse? _supplierSalesReport;

  GetCustomerAccountBookResponse? get customerAccountBook =>
      _customerAccountBook;
  GetProductSalesReportResponse? get productSalesReport => _productSalesReport;
  GetSalesReportResponse? get salesReport => _salesReport;
  GetSupplierSalesReportResponse? get supplierSalesReport =>
      _supplierSalesReport;

  Future<void> fetchCustomerAccountBook({
    required String accessToken,
    String? customerName,
    String? fromDate,
    String? toDate,
    String? amount,
  }) async {
    final queryParameters = <String, String>{};
    if (customerName != null && customerName.isNotEmpty) {
      queryParameters['customer_name'] = customerName;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      queryParameters['from_date'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      queryParameters['to_date'] = toDate;
    }
    if (amount != null && amount.isNotEmpty) {
      queryParameters['amount'] = amount;
    }

    final uri = Uri.parse(APPUrl.customerAccountBook)
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _customerAccountBook =
            GetCustomerAccountBookResponse.fromJson(jsonData);
        notifyListeners();
      } else {
        throw Exception('Failed to load customer account book');
      }
    } catch (error) {
      debugPrint('Error fetching customer account book: $error');
      rethrow;
    }
  }

  Future<void> fetchProductSalesReport({
    required String accessToken,
    String? categoryId,
    String? productId,
    String? startDate,
    String? endDate,
    String? amount,
  }) async {
    final queryParameters = <String, String>{};

    // Add query parameters if they are not null or empty
    if (categoryId != null) {
      queryParameters['category_id'] = categoryId.toString();
    }
    if (productId != null) {
      queryParameters['product_id'] = productId.toString();
    }
    if (startDate != null && startDate.isNotEmpty) {
      queryParameters['from_date'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      queryParameters['to_date'] = endDate;
    }
    if (amount != null && amount.isNotEmpty) {
      queryParameters['amount'] = amount;
    }

    final uri = Uri.parse(APPUrl.productSalesReport)
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15)); // Adding a timeout

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonData = json.decode(response.body);
          _productSalesReport =
              GetProductSalesReportResponse.fromJson(jsonData);
          notifyListeners();
        } else {
          debugPrint('Empty response body');
          throw Exception('Received empty response');
        }
      } else {
        debugPrint(
            'Failed to load product sales report: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load product sales report');
      }
    } catch (error) {
      debugPrint('Error fetching product sales report: $error');
      rethrow; // Rethrow the error for further handling
    }
  }

  Future<void> fetchSalesReport({
    required String accessToken,
    String? customerName,
    String? createdBy,
    String? startDate,
    String? endDate,
  }) async {
    final queryParameters = <String, String>{};

    // Add query parameters if they are not null or empty
    if (customerName != null && customerName.isNotEmpty) {
      queryParameters['customer_name'] = customerName;
    }
    if (createdBy != null && createdBy.isNotEmpty) {
      queryParameters['created_by'] = createdBy;
    }
    if (startDate != null && startDate.isNotEmpty) {
      queryParameters['from_date'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      queryParameters['to_date'] = endDate;
    }

    final uri =
        Uri.parse(APPUrl.salesReport).replace(queryParameters: queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15)); // Adding a timeout

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonData = json.decode(response.body);
          _salesReport = GetSalesReportResponse.fromJson(jsonData);
          notifyListeners();
        } else {
          debugPrint('Empty response body');
          throw Exception('Received empty response');
        }
      } else {
        debugPrint(
            'Failed to load sales report: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load sales report');
      }
    } catch (error) {
      debugPrint('Error fetching sales report: $error');
      rethrow; // Rethrow the error for further handling
    }
  }

  Future<void> fetchSupplierSalesReport({
    required String accessToken,
    String? supplierName,
    String? startDate,
    String? endDate,
    String? amount,
  }) async {
    final queryParameters = <String, String>{};

    // Add query parameters if they are not null or empty
    if (supplierName != null && supplierName.isNotEmpty) {
      queryParameters['supplier_name'] = supplierName;
    }
    if (startDate != null && startDate.isNotEmpty) {
      queryParameters['from_date'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      queryParameters['to_date'] = endDate;
    }
    if (amount != null && amount.isNotEmpty) {
      queryParameters['amount'] = amount;
    }

    final uri = Uri.parse(APPUrl.supplierSalesReport)
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15)); // Adding a timeout

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonData = json.decode(response.body);
          _supplierSalesReport =
              GetSupplierSalesReportResponse.fromJson(jsonData);
          notifyListeners();
        } else {
          debugPrint('Empty response body');
          throw Exception('Received empty response');
        }
      } else {
        debugPrint(
            'Failed to load supplier sales report: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load supplier sales report');
      }
    } catch (error) {
      debugPrint('Error fetching supplier sales report: $error');
      rethrow; // Rethrow the error for further handling
    }
  }

  // You can add other report-related methods here as needed
}
