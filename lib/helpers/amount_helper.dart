import 'package:intl/intl.dart';

class AmountHelper {
  static String formatAmount(amount) {
    final NumberFormat formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }
}
