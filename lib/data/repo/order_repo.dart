import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

abstract class OrderRepoContract {
  Future<Order> createOrder({
    required List<ProductOrder> products,
    required UserApp user,
    required OrderInfo orderInfo,
    required String paymentMethod,
    required String note,
    int paymentAmount,
  });

  Future<Order?> readOrder(String id);

  Future<List<Order>> readUserOrders(UserApp user);

  Future<List<Order>> updateOrderStatus({
    required Order order,
    required UserApp user,
    required OrderStatus status,
  });

  Future<Order> rateOrder(Order order, Rating rating);
}

class OrderRepo extends OrderRepoContract {
  FirestoreService firestore = FirestoreService();

  @override
  Future<Order> createOrder({
    required List<ProductOrder> products,
    required UserApp user,
    required OrderInfo orderInfo,
    required String paymentMethod,
    required String note,
    int paymentAmount = 0,
  }) async {
    Order order = Order(
      orderingUser: user,
      status: OrderStatus.placed,
      products: products,
      orderInfo: orderInfo,
      paymentMethod: paymentMethod,
      paymentAmount: paymentAmount,
      note: note,
    );
    await firestore.createOrder(
      order.generateId(),
      user.phone,
      order.toMap(),
    );
    return order;
  }

  @override
  Future<Order> rateOrder(Order order, Rating rating) async {
    order.rating = rating;
    order.status = OrderStatus.finished;
    order.setFinishTimeStamp(rating.ratingTimeStamp);
    final res = await firestore.updateOrder(order.generateId(), order.toMap());
    final updatedOrder = Order.fromMap(res as Map<String, dynamic>);
    return updatedOrder;
  }

  @override
  Future<Order?> readOrder(String id) async {
    final res = await firestore.readOrder(id);
    if (res == null) {
      return null;
    }
    final data = res as Map<String, dynamic>;
    return Order.fromMap(data);
  }

  @override
  Future<List<Order>> readUserOrders(UserApp user) async {
    final res = await firestore.readUserOrders(user.phone);
    final data =
        res.map((e) => Order.fromMap(e as Map<String, dynamic>)).toList();
    return data;
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
