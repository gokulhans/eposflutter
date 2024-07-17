import 'package:get/get.dart';
import 'package:pos_machine/screens/category/add_category.dart';
import 'package:pos_machine/screens/category/add_category_properties.dart';
import 'package:pos_machine/screens/category/add_category_screen.dart';
import 'package:pos_machine/screens/category/edit_category_screen.dart';
import 'package:pos_machine/screens/category/widgets/view_category.dart';
import 'package:pos_machine/screens/customer_profile/open_customer_profile.dart';
import 'package:pos_machine/screens/customers/add_customers.dart';
import 'package:pos_machine/screens/cart/cart_list.dart';
import 'package:pos_machine/screens/customers/customers.dart';
import 'package:pos_machine/screens/dashboard/dashboard.dart';

import 'package:pos_machine/screens/loyality_card/loyality.dart';
import 'package:pos_machine/screens/notifications/notifications.dart';
import 'package:pos_machine/screens/product/add_product.dart';
import 'package:pos_machine/screens/product/tabbar_for_edit_product.dart';
import 'package:pos_machine/screens/product/widgets/view_product.dart';
import 'package:pos_machine/screens/purchase/purchase.dart';
import 'package:pos_machine/screens/product/tabbar_for_add_new_product.dart';
import 'package:pos_machine/screens/product/stock.dart';
import 'package:pos_machine/screens/purchase/purchase_voucher.dart';
import 'package:pos_machine/screens/purchase/widgets/add_purchase.dart';
import 'package:pos_machine/screens/profile/open_profile.dart';
import 'package:pos_machine/screens/purchase/widgets/view_purchase.dart';
import 'package:pos_machine/screens/purchase/widgets/view_voucher.dart';
import 'package:pos_machine/screens/sales/sales.dart';
import 'package:pos_machine/screens/support/support.dart';
import 'package:pos_machine/screens/transaction-customer/invoice_list.dart';
import 'package:pos_machine/screens/transaction-customer/receipt_voucher.dart';
import 'package:pos_machine/screens/transaction-customer/transaction_list.dart';
import 'package:pos_machine/screens/transaction-customer/widgets/add_voucher_details.dart';
import 'package:pos_machine/screens/transaction-customer/widgets/create_new_invoice.dart';
import 'package:pos_machine/screens/transaction-customer/widgets/create_new_voucher.dart';
import 'package:pos_machine/screens/transaction-customer/widgets/view_invoice.dart';
import 'package:pos_machine/screens/transaction-customer/widgets/view_transaction_details.dart';
import 'package:pos_machine/screens/transaction-customer/widgets/view_voucher_details.dart';
import 'package:pos_machine/screens/transaction/transaction.dart';

import '../screens/product/widgets/add_product_stock.dart';
import '../screens/product/widgets/stock_details.dart';
import '../screens/sales/widgets/sales_order_details.dart';
import '../widgets/category_list.dart';

class SideBarController extends GetxController {
  RxInt index = 0.obs;
  RxBool isExpanded = false.obs;
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  var screens = const [
    CategoryList(), //0
    DashboardScreen(), //1
    SalesScreen(), //2
    CartScreen(), //3
    TransactionScreen(), //4
    CustomersScreen(), //5
    LoyalityCardScreen(), //6
    NotificationScreen(), //7
    SupportScreen(), //8
    AddCustomersScreen(), //9
    OpenProfileScreen(), //10
    SalesOrderDetailsScreen(), //11
    AddCategoryScreen(), //12
    AddCategoryPropertiesScreen(), //13
    AddProductScreen(), //14
    AddStockScreen(), //15
    AddCategoryPageScreen(), //16
    TabBarForAddNewProduct(), //17
    AddProductStockScreen(), //18
    PurchaseScreen(), //19
    AddPurchaseScreen(), //20
    InvoiceListcreen(), //21
    VoucherListScreen(), //22
    CustomerTransactionListScreen(), //23
    CreateNewInvoiceScreen(), //24
    CreateNewVoucherScreen(), //25
    PurchaseVoucherScreen(), //26
    ViewCategoryWidget(), //27
    ViewProductWidget(), //28
    ViewVoucherWidget(), //29
    ViewTransactionDetailsWidget(), //30
    ViewInvoiceDetailsWidget(), //31
    ViewVoucherDetailsWidget(), //32
    StockDetailsWidget(), //33
    EditCategoryPageScreen(), //34
    TabBarForEditProduct(), //35
    ViewPurchaseWidget(), //36
    AddVoucherDetailsWidget(), //37
    OpenCustomerProfileScreen(), //38
  ];
}
