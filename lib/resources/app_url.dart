class APPUrl {
  static const String baseURL = "https://epos.enke.ae";
  // static const String baseURL = "http://13.212.33.222";
  static const String categoryListUrl = '$baseURL/api/list-category';
  static const String getProcductUrl = '$baseURL/api/list-products';
  static const String addToCartUrl = '$baseURL/api/add-to-cart';
  static const String listCartUrl = '$baseURL/api/list-carts';
  static const String addToOrderUrl = '$baseURL/api/add-to-order';
  static const String getListOrder = '$baseURL/api/list-orders';
  static const String getListOrderDetails = '$baseURL/api/order-details';

  static const String loginUrl = '$baseURL/api/user/signin';
  static const String forgotPasswordUrl = '$baseURL/api/user/forgot';
  static const String resetPasswordUrl = '$baseURL/api/user/reset';

  static const String logoutUrl = '$baseURL/api/user/signout';
  static const String dashBoardUrl = '$baseURL/api/sales/dashboard';
  static const String addCustomerUrl = '$baseURL/api/sales/add-customer';
  static const String customerListUrl = '$baseURL/api/sales/list-customer';
}
