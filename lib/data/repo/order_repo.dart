import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/shared/enums.dart';

abstract class OrderRepoContract {
  Future<Order> createOrder({
    required DeliveryInfo deliveryInfo,
    required List<ProductOrder> products,
    required UserApp user,
  });

  Future<Order> readOrder(int id);

  Future<List<Order>> readOrders(UserApp user);

  Future<List<Order>> updateOrderStatus({
    required Order order,
    required UserApp user,
    required OrderStatus status,
  });

  Future<bool> rateOrder(Order order, UserApp user, Rating rating);
}

class OrderRepo extends OrderRepoContract {
  @override
  Future<Order> createOrder({
    required DeliveryInfo deliveryInfo,
    required List<ProductOrder> products,
    required UserApp user,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    Order res = Order(
      orderingUser: user,
      status: OrderStatus.placed,
      id: 99,
      products: products,
      deliveryInfo: deliveryInfo,
    );
    return Future.value(res);
  }

  @override
  Future<bool> rateOrder(Order order, UserApp user, Rating rating) {
    // TODO: implement rateOrder
    throw UnimplementedError();
  }

  @override
  Future<Order> readOrder(int id) {
    // TODO: implement readOrder
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> readOrders(UserApp user) {
    // TODO: implement readOrders
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> updateOrderStatus(
      {required Order order,
      required UserApp user,
      required OrderStatus status}) {
    // TODO: implement updateOrderStatus
    throw UnimplementedError();
  }
}