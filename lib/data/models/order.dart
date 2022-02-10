import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/enums.dart';

class Order {
  late int id;
  late String orderTimeStamp;
  late String finishTimeStamp;
  late List<ProductOrder> products;
  late OrderStatus status;

  Order({
    required this.id,
    required this.orderTimeStamp,
    required this.finishTimeStamp,
    required this.products,
    required this.status,
  });
}