import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:math';

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

  /// Result in Kilometer
  static double calculateDistance(LatLng pos1, LatLng pos2) {
    double lat1 = pos1.latitude;
    double lat2 = pos2.latitude;

    double lon1 = pos1.longitude;
    double lon2 = pos2.longitude;

    var earthRadius = 6372.8; // in KiloMeters
    double dLat = (lat2 - lat1) * pi / 180;
    double dLon = (lon2 - lon1) * pi / 180;
    lat1 = lat1 * pi / 180;
    lat2 = lat2 * pi / 180;
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}