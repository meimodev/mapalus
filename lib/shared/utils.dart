import 'package:intl/intl.dart';

class Utils {
  static String formatNumberToCurrency(dynamic number) {
    var f = NumberFormat('#,###');
    var s = "Rp. ${f.format(number)}".replaceAll(",", ".");
    return s;
  }

  static double formatCurrencyToNumber(String currencyNumber) {
    var string = currencyNumber.replaceAll("Rp. ", "");
    var safe = string.replaceAll(".", "");
    return double.parse(safe);
  }
}