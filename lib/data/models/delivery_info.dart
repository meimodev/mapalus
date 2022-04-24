import 'package:jiffy/jiffy.dart';
import 'package:mapalus/shared/utils.dart';

class DeliveryInfo {
  String id;
  final String _start;
  final String _end;
  bool available;
  final String _discount;

  String currentDate = Jiffy().format("dd/MM/yyyy");

  final List<List<double>> priceMatrixFromWeight = [
    //[0 - 2Km, >2Km - 4Km, >4Km - 6.5Km, >6.5km - 8Km]
    [6000, 8000, 10000, 20000], //0 - 2Kg
    [12000, 16000, 20000, 40000], // >2Kg - 4Kg
    [18000, 24000, 30000, 80000], // >4Kg - 6Kg
    [27000, 36000, 45000, 120000], // >6Kg - 9Kg
  ];

  DeliveryInfo(
    this.id,
    this._start,
    this._end,
    this.available,
    this._discount,
  );

  DeliveryInfo.fromJSON(Map<String, dynamic> json)
      : id = json["id"],
        _discount = json['discount'],
        _start = json["start"],
        _end = json["end"],
        available = json["available"];

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
    print('is tomorrow = $isTomorrow, '
        'startDate = ${startDate.format("E, dd MMMM HH:mm")} '
        'endDate = ${endDate.format("E, dd MMMM HH:mm")} '
        'now = ${Jiffy().format("E, dd MMMM HH:mm")} '
        'isAvailable = $available}');
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
    double distanceFee = 0;
    //determine the weight in which class
    weight = weight / 1000;
    if (weight > 0 && weight <= 2.0) {
      distanceFee = _calculateDistance(distance, 0);
    } else if (weight > 2.0 && weight <= 4.0) {
      distanceFee = _calculateDistance(distance, 1);
    } else if (weight > 4.0 && weight <= 6.0) {
      distanceFee = _calculateDistance(distance, 2);
    } else if (weight > 6 && weight <= 9) {
      distanceFee = _calculateDistance(distance, 3);
    } else {
      return 'invalid weight $weight';
    }
    return Utils.formatNumberToCurrency(
        ((distanceFee / 1000) * discount).round() * 1000);
  }

  double _calculateDistance(double dis, int weightRow) {
    if (dis > 0 && dis <= 2.0) {
      return priceMatrixFromWeight[weightRow][0];
    } else if (dis > 2 && dis <= 4.0) {
      return priceMatrixFromWeight[weightRow][1];
    } else if (dis > 4 && dis <= 6.0) {
      return priceMatrixFromWeight[weightRow][2];
    } else if (dis > 6 && dis <= 9.0) {
      return priceMatrixFromWeight[weightRow][3];
    } else {
      return -1;
    }
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

  DeliveryInfo.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        _start = data["start"],
        _end = data["end"],
        available = data["available"],
        _discount = data["discount"];
}