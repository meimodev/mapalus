import 'package:jiffy/jiffy.dart';
import 'package:mapalus/shared/values.dart';

class Rating {
  int id;
  int number;
  String message;
  final String _ratingTimeStamp;

  Rating(
    this.id,
    this.number,
    this.message,
    Jiffy ratingTimeStamp,
  ) : _ratingTimeStamp = ratingTimeStamp.format(Values.formatRawDate);

  Jiffy? get ratingTimeStamp {
    if (_ratingTimeStamp.isNotEmpty) {
      return Jiffy(_ratingTimeStamp, Values.formatRawDate);
    }
    return null;
  }

  Rating.zero()
      : id = 0,
        number = 0,
        message = '',
        _ratingTimeStamp = '';

  Rating.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        number = data["number"],
        message = data["message"],
        _ratingTimeStamp = data["rate_time_stamp"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "number": number,
      "message": message,
      "rate_time_stamp": _ratingTimeStamp,
    };
  }
}