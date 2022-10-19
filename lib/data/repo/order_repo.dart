import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/services/firebase_services.dart';
import 'package:mapalus/shared/enums.dart';

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

  Future<List<Order>> readOrders(UserApp user);

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
    int paymentAmount = 0,
    required String note
  }) async {
    Order order = Order(
      orderingUser: user,
      status: OrderStatus.placed,
      products: products,
      orderInfo: orderInfo,
      paymentMethod: paymentMethod,
      paymentAmount: paymentAmount,
      note:note,
    );
    final newOrder = await firestore.createOrder(order);
    return newOrder;
  }

  @override
  Future<Order> rateOrder(Order order, Rating rating) async {
    //new order with updated rating
    order.rating = rating;
    order.status = OrderStatus.finished;
    order.setFinishTimeStamp(rating.ratingTimeStamp);
    return await firestore.updateOrder(order);
  }

  @override
  Future<Order?> readOrder(String id) async {
    var res = await firestore.readOrder(id);
    return res;
  }

  @override
  Future<List<Order>> readOrders(UserApp user) async {
    var res = <Order>[];
    var userOrders = user.orders;
    for (String id in userOrders) {
      Order? o = await firestore.readOrder(id);
      if (o != null) {
        res.add(o);
      }
    }
    return res;
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
