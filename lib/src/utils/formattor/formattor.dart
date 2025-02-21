import 'package:intl/intl.dart';

class Formattor {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_ruppee', symbol: '₹')
        .format(amount);
  }
}
