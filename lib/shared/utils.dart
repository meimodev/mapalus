import 'package:intl/intl.dart';

class Utils {
  static String formatNumberToCurrency(dynamic number) {
    var f = NumberFormat('#,###');
    return "Rp. ${f.format(number)}".replaceAll(",", ".");
  }

  static int formatCurrencyToNumber(String currencyNumber) {
    var string = currencyNumber.replaceAll("Rp. ", "");
    var safe = string.replaceAll(".", "");
    return int.parse(safe);
  }
}