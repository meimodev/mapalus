import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user.dart';
import 'package:mapalus/shared/enums.dart';

abstract class OrderRepoContract {
  Future<bool> createOrder(Order order);

  Future<Order> readOrder(int id);

  Future<List<Order>> readOrders(User user);

  Future<List<Order>> updateOrderStatus({
    required Order order,
    required User user,
    required OrderStatus status,
  });

  Future<bool> rateOrder(Order order, User user, Rating rating);
}