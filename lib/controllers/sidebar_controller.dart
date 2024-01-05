import 'package:get/get.dart';
import 'package:pos_machine/screens/customers/add_customers.dart';
import 'package:pos_machine/screens/cart/cart_list.dart';
import 'package:pos_machine/screens/customers/customers.dart';
import 'package:pos_machine/screens/dashboard/dashboard.dart';

import 'package:pos_machine/screens/loyality_card/loyality.dart';
import 'package:pos_machine/screens/notifications/notifications.dart';
import 'package:pos_machine/screens/profile/open_profile.dart';
import 'package:pos_machine/screens/sales/sales.dart';
import 'package:pos_machine/screens/support/support.dart';
import 'package:pos_machine/screens/transaction/transaction.dart';

import '../screens/sales/widgets/sales_order_details.dart';
import '../widgets/category_list.dart';

class SideBarController extends GetxController {
  RxInt index = 0.obs;

  var screens = const [
    CategoryList(),
    DashboardScreen(),
    SalesScreen(),
    CartScreen(),
    TransactionScreen(),
    CustomersScreen(),
    LoyalityCardScreen(),
    NotificationScreen(),
    SupportScreen(),
    AddCustomersScreen(),
    OpenProfileScreen(),
    SalesOrderDetailsScreen()
  ];
}
