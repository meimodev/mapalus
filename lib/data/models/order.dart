import 'dart:math';

import 'package:jiffy/jiffy.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/utils.dart';
import 'package:mapalus/shared/values.dart';

class Order {
  String? id;
  List<ProductOrder> products;

  // DeliveryInfo deliveryInfo;
  OrderStatus status;
  String? _orderTimeStamp;
  String? _finishTimeStamp;
  Rating rating;
  UserApp orderingUser;
  UserApp? deliveringUser;
  OrderInfo orderInfo;
  String paymentMethod;
  int paymentAmount;
  String note;

  Order({
    rating,
    deliveringUser,
    Jiffy? orderTimeStamp,
    Jiffy? finishTimeStamp,
    required this.orderingUser,
    // required this.deliveryInfo,
    required this.products,
    required this.status,
    required this.orderInfo,
    required this.paymentMethod,
    this.paymentAmount = 0,
    required this.note,
  }) : rating = Rating.zero() {
    if (orderTimeStamp == null) {
      _orderTimeStamp = Jiffy().format(Values.formatRawDate);
    }

    if (finishTimeStamp != null) {
      _finishTimeStamp = finishTimeStamp.format(Values.formatRawDate);
    }
  }

  Order.fromMap(Map<String, dynamic> data)
      :
        // deliveryInfo = DeliveryInfo.fromMap(data['delivery_info']),
        id = data['id'],
        orderInfo = OrderInfo.fromMap(data['order_info']),
        status = OrderStatus.values.firstWhere(
          (element) => element.name == data['status'],
        ),
        _orderTimeStamp = data['order_time'],
        _finishTimeStamp = data['finish_time'] ?? '',
        products = List<ProductOrder>.from(
          (data['products'] as List<dynamic>).map(
            (e) => ProductOrder.fromMap(e),
          ),
        ),
        rating = Rating.fromMap(data["rating"]),
        orderingUser = UserApp.fromMap(data['ordering_user']),
        deliveringUser = data['delivering_user'] == null
            ? null
            : UserApp.fromMap(data['delivering_user']),
        paymentMethod = data['payment_method'] ?? '',
        paymentAmount = data['payment_amount'] ?? 0,
        note = data['note'] ?? '';

  String get finishTimeStampF {
    if (finishTimeStamp == null) {
      return "-";
    }
    return finishTimeStamp!.format("E, ddd MMM yyyy");
  }

  String get idMinified {
    return id!.replaceRange(0, 12, '');
  }

  String generateId() {
    if (id != null) {
      return id!;
    }

    final now = Jiffy();
    final random = Random().nextInt(9999);
    final res = '${now.format('yyyyMMddHHmm')}$random';
    id = res;
    return res;
  }

  Jiffy? get orderTimeStamp {
    return _orderTimeStamp == null
        ? null
        : Jiffy(_orderTimeStamp, Values.formatRawDate);
  }

  Jiffy? get finishTimeStamp {
    if (_finishTimeStamp != null && _finishTimeStamp!.isNotEmpty) {
      return Jiffy(_finishTimeStamp, Values.formatRawDate);
    }
    return null;
  }

  void setFinishTimeStamp(Jiffy timeStamp) {
    _finishTimeStamp = timeStamp.format(Values.formatRawDate);
  }

  String get paymentMethodF {
    if (paymentMethod == "CASH") {
      return "Bayar ditempat ${Utils.formatNumberToCurrency(paymentAmount)}";
    }
    return paymentMethod;
  }

  @override
  String toString() {
    return 'Order{id: $id, products: $products, '
        'status: $status, _orderTimeStamp: $_orderTimeStamp, '
        '_finishTimeStamp: $_finishTimeStamp, rating: $rating, '
        'orderingUser: $orderingUser, deliveringUser: $deliveringUser, '
        'orderInfo: $orderInfo, paymentMethod: $paymentMethod, '
        'paymentAmount: $paymentAmount, note: $note}';
  }

  Map<String, dynamic> toMap() {
    var productMaps = <Map<String, dynamic>>[];
    for (ProductOrder element in products) {
      productMaps.add(element.toMap());
    }
    return {
      'id': id,
      'products': productMaps,
      // 'delivery_info': deliveryInfo.toMap(),
      'order_info': orderInfo.toMap(),
      'status': status.name,
      'order_time': _orderTimeStamp,
      'finish_time': _finishTimeStamp,
      'rating': rating.toMap(),
      'ordering_user': orderingUser.toMap(minify: true),
      'delivering_user':
          deliveringUser != null ? deliveringUser!.toMap() : null,
      'payment_method': paymentMethod,
      'payment_amount': paymentAmount,
      'note': note,
    };
  }
}
