import 'package:jiffy/jiffy.dart';
import 'package:mapalus/data/models/pricing_modifier.dart';
import 'package:mapalus/shared/utils.dart';

class DeliveryInfo {
  String id;
  final String _start;
  final String _end;
  bool available;
  final String _discount;
  PricingModifier pricingModifier;

  String currentDate = Jiffy().format("dd/MM/yyyy");

  // final List<List<double>> priceMatrixFromWeight = [
  //   //[0 - 2Km, >2Km - 4Km, >4Km - 6.5Km, >6.5km - 8Km]
  //   [6000, 8000, 10000, 20000], //0 - 5Kg
  //   [12000, 16000, 20000, 40000], // >5Kg - 7Kg
  //   [18000, 24000, 30000, 80000], // >7Kg - 9Kg
  //   [27000, 36000, 45000, 120000], // >9Kg - 11Kg
  // ];

  final List<double> weightMilestones = [5.0, 7.0, 9.0, 11.0];

  DeliveryInfo({
    required start,
    required end,
    required discount,
    required this.id,
    required this.available,
    required this.pricingModifier,
  })  : _start = start,
        _end = end,
        _discount = discount;

  factory DeliveryInfo.fromJSON(Map<String, dynamic> json) => DeliveryInfo(
        id: json["id"],
        start: json["start"],
        end: json["end"],
        available: json["available"],
        discount: json['discount'],
        pricingModifier: PricingModifier(
          distancePrice: json['distance_price'] ?? 1000,
          weightPrice: json['weight_price'] ?? 1000,
          distanceUnit: json['distance_unit'] ?? 1,
          weightUnit: json['weight_unit'] ?? 1,
        ),
      );

  Jiffy get startDate {
    var res = Jiffy("$_start $currentDate", "HH:mm dd/MM/yyyy");
    return res;
  }

  Jiffy get endDate {
    var res = Jiffy("$_end $currentDate", "HH:mm dd/MM/yyyy");
    return res;
  }

  bool get isTomorrow {
    if (id == "NOW") {
      return !Jiffy().isBetween(startDate, endDate);
    }
    return Jiffy().isAfter(startDate);
  }

  String get title {
    // print('is tomorrow = $isTomorrow, '
    //     'startDate = ${startDate.format("E, dd MMMM HH:mm")} '
    //     'endDate = ${endDate.format("E, dd MMMM HH:mm")} '
    //     'now = ${Jiffy().format("E, dd MMMM HH:mm")} '
    //     'isAvailable = $available}');
    if (id == "NOW") {
      return "Sekarang";
    }

    String timeOfTheDay = '';
    int startHour = startDate.hour;
    if (startHour > 0 && startHour < 10) {
      timeOfTheDay = "Pagi";
    } else if (startHour >= 10 && startHour < 13) {
      timeOfTheDay = "Siang";
    } else if (startHour >= 13 && startHour < 17) {
      timeOfTheDay = "Sore";
    } else if (startHour > 17) {
      timeOfTheDay = "Malam";
    }
    return "Pukul ${startDate.hour} - ${endDate.hour} $timeOfTheDay";
  }

  bool get isAvailable {
    if (id == "NOW") {
      return !isTomorrow && available;
    }
    return available;
  }

  double get discount {
    return double.parse(_discount);
  }

  String price({required double distance, required double weight}) {
    weight = weight / 1000;

    /*Default price modifier */

    final perDistancePrice = pricingModifier.distancePrice;
    final perWeightPrice = pricingModifier.weightPrice;
    final perDistanceUnit = pricingModifier.distanceUnit;
    final perWeightUnit = pricingModifier.weightUnit;

    var fee = 0;

    final calculatedDistanceUnit = (distance / perDistanceUnit).ceil();
    final distanceUnit =
        calculatedDistanceUnit <= 0 ? 1 : calculatedDistanceUnit;
    final calculatedWeightUnit = (weight / perWeightUnit).ceil();
    final weightUnit = calculatedWeightUnit <= 0 ? 1 : calculatedWeightUnit;

    //based on distance
    fee = (distanceUnit * perDistancePrice) + (weightUnit * perWeightPrice);

    var res = ((fee / 1000) * discount).round() * 1000;
    if (res <= 0) {
      res = 0;
    }
    return Utils.formatNumberToCurrency(
      res,
      canBeFree: true,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          _start == other._start &&
          _end == other._end &&
          available == other.available &&
          _discount == other._discount;

  @override
  int get hashCode =>
      id.hashCode ^
      _start.hashCode ^
      _end.hashCode ^
      available.hashCode ^
      _discount.hashCode;

  @override
  String toString() {
    return 'DeliveryInfo{id: $id, _start: $_start, _end: $_end, '
        'available: $available, _discount: $_discount}';
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "start": _start,
      "end": _end,
      "available": available,
      "discount": _discount,
    };
  }
}
