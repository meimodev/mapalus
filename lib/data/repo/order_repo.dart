import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/services/firebase_services.dart';
import 'package:mapalus/shared/enums.dart';

abstract class OrderRepoContract {
  Future<Order> createOrder({
    required DeliveryInfo deliveryInfo,
    required List<ProductOrder> products,
    required UserApp user,
    required OrderInfo orderInfo,
  });

  Future<Order?> readOrder(String id);

  Future<List<Order>> readOrders(UserApp user);

  Future<List<Order>> updateOrderStatus({
    required Order order,
    required UserApp user,
    required OrderStatus status,
  });

  Future<bool> rateOrder(Order order, UserApp user, Rating rating);
}

class OrderRepo extends OrderRepoContract {
  FirestoreService firestore = FirestoreService();

  @override
  Future<Order> createOrder({
    required DeliveryInfo deliveryInfo,
    required List<ProductOrder> products,
    required UserApp user,
    required OrderInfo orderInfo,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    Order order = Order(
      orderingUser: user,
      status: OrderStatus.placed,
      products: products,
      deliveryInfo: deliveryInfo,
      orderInfo: orderInfo,
    );
    final newOrder = await firestore.createOrder(order);
    return Future.value(newOrder);
  }

  @override
  Future<bool> rateOrder(Order order, UserApp user, Rating rating) {
    // TODO: implement rateOrder
    throw UnimplementedError();
  }

  @override
  Future<Order?> readOrder(String id) async {
    var res = await firestore.readOrder(id);
    return res;
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