import 'package:jiffy/jiffy.dart';
import 'package:mapalus/shared/values.dart';

class Rating {
  int number;
  String message;
  final String _ratingTimeStamp;

  Rating(
    this.number,
    this.message,
    Jiffy ratingTimeStamp,
  ) : _ratingTimeStamp = ratingTimeStamp.format(Values.formatRawDate);

  Jiffy get ratingTimeStamp {
    return Jiffy(_ratingTimeStamp, Values.formatRawDate);
  }

  Rating.zero()
      : number = 0,
        message = '',
        _ratingTimeStamp = '';

  Rating.fromMap(Map<String, dynamic> data)
      : number = data["number"],
        message = data["message"],
        _ratingTimeStamp = data["rate_time_stamp"];

  Map<String, dynamic> toMap() {
    return {
      "number": number,
      "message": message,
      "rate_time_stamp": _ratingTimeStamp,
    };
  }

  @override
  String toString() {
    return 'Rating{number: $number, message: $message, _ratingTimeStamp: $_ratingTimeStamp}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rating &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          message == other.message &&
          _ratingTimeStamp == other._ratingTimeStamp;

  @override
  int get hashCode =>
      number.hashCode ^ message.hashCode ^ _ratingTimeStamp.hashCode;
}