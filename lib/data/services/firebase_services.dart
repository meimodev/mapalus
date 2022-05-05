import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/user_app.dart';

class FirestoreService {
  FirebaseFirestore fireStore;

  FirestoreService() : fireStore = FirebaseFirestore.instance;

  Future<UserApp?> getUser(String phone) async {
    CollectionReference col = fireStore.collection('users');
    DocumentSnapshot doc = await col.doc(phone).get();

    if (doc.exists) {
      Map data = doc.data() as Map<String, dynamic>;
      UserApp userApp = UserApp(
        phone: phone,
        name: data["name"],
        orders: List<String>.from(data["orders"]),
      );
      return userApp;
    } else {
      return null;
    }
  }

  Future<bool> checkPhoneRegistration(String phone) async {
    CollectionReference col = fireStore.collection('users');
    DocumentSnapshot doc = await col.doc(phone).get();

    return doc.exists;
  }

  Future<UserApp> createUser(UserApp user) async {
    CollectionReference users = fireStore.collection('users');

    users.doc(user.phone).set(user.toMap()).then((value) {
      if (kDebugMode) {
        print('[FIRESTORE] USER successfully registered');
      }
    }).onError((e, _) {
      if (kDebugMode) {
        print('[FIRESTORE] USER creation error $e');
      }
    });

    return user;
  }

  Future<List<Map<String, dynamic>>> getDeliveryTimes() async {
    CollectionReference col = fireStore.collection('delivery_time');
    DocumentSnapshot doc = await col.doc('-env').get();

    Map data = doc.data() as Map<String, dynamic>;

    return Future.value(List<Map<String, dynamic>>.from(data["deliveries"]));
  }

  Future<Order> createOrder(Order order) async {
    CollectionReference orders = fireStore.collection('orders');

    orders.doc(order.generateId()).set(order.toMap()).then((_) {
      if (kDebugMode) {
        print('[FIRESTORE] ORDER successfully created');
      }
    }).onError((e, _) {
      if (kDebugMode) {
        print('[FIRESTORE] ORDER creation error $e');
      }
    });

    order.orderingUser.orders.add(order.generateId());
    CollectionReference users = fireStore.collection('users');

    users
        .doc(order.orderingUser.phone)
        .update({"orders": order.orderingUser.orders}).then((_) {
      if (kDebugMode) {
        print('[FIRESTORE] USER-ORDER successfully created');
      }
    }).onError((e, _) {
      if (kDebugMode) {
        print('[FIRESTORE] USER-ORDER creation error $e');
      }
    });

    return order;
  }

  Future<Order?> readOrder(String id) async {
    CollectionReference orders = fireStore.collection('orders');
    DocumentSnapshot doc = await orders.doc(id).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return Order.fromMap(data);
    }
    return null;
  }

  Future<Order> updateOrder(Order order) async {
    CollectionReference orders = fireStore.collection('orders');

    orders.doc(order.generateId()).set(order.toMap()).then((_) {
      if (kDebugMode) {
        print('[FIRESTORE] ORDER successfully updated');
      }
    }).onError((e, _) {
      if (kDebugMode) {
        print('[FIRESTORE] ORDER update error $e');
      }
    });

    return order;
  }

  Future<List<Product>> getProducts() async {
    CollectionReference products = fireStore.collection('products');

    var productsWithOrder = await products.orderBy("id").get();

    var res = <Product>[];
    for (var e in productsWithOrder.docs) {
      var map = e.data() as Map<String, dynamic>;
      res.add(Product.fromMap(map));
    }
    return res;
  }
}