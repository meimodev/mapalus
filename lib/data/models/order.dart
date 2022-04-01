import 'package:jiffy/jiffy.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/values.dart';

class Order {
  int id;
  List<ProductOrder> products;
  DeliveryInfo deliveryInfo;
  OrderStatus status;
  String? _orderTimeStamp;
  String? _finishTimeStamp;
  Rating? rating;
  User? orderingUser;
  User? deliveringUser;

  Order({
    rating,
    deliveringUser,
    Jiffy? orderTimeStamp,
    Jiffy? finishTimeStamp,
    required this.id,
    required this.orderingUser,
    required this.deliveryInfo,
    required this.products,
    required this.status,
  }) {
    rating = Rating(0, 1, "default");
    deliveringUser = User(name: '', phone: 'default');
    if (orderTimeStamp == null) {
      _orderTimeStamp = Jiffy().format(Values.formatRawDate);
    }

    if (finishTimeStamp != null) {
      _finishTimeStamp = finishTimeStamp.format(Values.formatRawDate);
    }
  }

  @override
  String toString() {
    return 'Order{id: $id, products: $products, deliveryInfo: $deliveryInfo, status: $status, _orderTimeStamp: $_orderTimeStamp, _finishTimeStamp: $_finishTimeStamp, rating: $rating, orderingUser: $orderingUser, deliveringUser: $deliveringUser}';
  }
}