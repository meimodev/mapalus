import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user.dart';
import 'package:mapalus/shared/enums.dart';

class Order {
  int id;
  String orderTimeStamp;
  String finishTimeStamp;
  List<ProductOrder> products;
  OrderStatus status;
  Rating? rating;
  User? orderingUser;
  User? deliveringUser;

  Order({
    this.rating,
    this.deliveringUser,
    this.orderingUser,
    required this.id,
    required this.orderTimeStamp,
    required this.finishTimeStamp,
    required this.products,
    required this.status,
  });
}