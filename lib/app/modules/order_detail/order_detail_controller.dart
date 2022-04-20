import 'dart:math';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/shared/values.dart';

class OrderDetailController extends GetxController {
  OrderRepo orderRepo = Get.find();
  HomeController homeController = Get.find();

  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;
  RxString id = ''.obs;

  RxString orderTime = ''.obs;
  RxString deliveryTime = ''.obs;

  RxString productTotal = ''.obs;
  RxString productCount = ''.obs;
  RxString deliveryTotal = ''.obs;
  RxString deliveryCount = ''.obs;
  RxString totalPrice = ''.obs;

  RxString orderStatus = ''.obs;
  Rx<Rating> orderRating = Rating.zero().obs;

  late Order _order;
  bool shouldCheckNewlyCreatedOrder = false;

  @override
  void onClose() {
    if (shouldCheckNewlyCreatedOrder) {
      homeController.checkNewlyCreatedOrder();
    }
    super.onClose();
  }

  @override
  void onInit() {
    Order order = Get.arguments as Order;
    _order = order;
    productOrders.value = order.products;
    id.value = order.id!;

    var _orderTimeStamp = order.orderTimeStamp;
    orderTime.value = _orderTimeStamp == null
        ? '-'
        : _orderTimeStamp.format(Values.formatRawDate);

    var _finishTimeStamp = order.finishTimeStamp;
    deliveryTime.value = _finishTimeStamp == null
        ? '-'
        : _finishTimeStamp.format(Values.formatRawDate);

    productCount.value = order.orderInfo.productCountF;
    productTotal.value = order.orderInfo.productPriceF;
    deliveryCount.value = order.orderInfo.deliveryWeightF;
    deliveryTotal.value = order.orderInfo.deliveryPriceF;
    totalPrice.value = order.orderInfo.totalPrice;

    orderStatus.value = order.status.name;

    super.onInit();
  }

  Future<void> onPressedRate(String message, double rate) async {
    //make call to firestore service to update order rating
    var rating = Rating(
      Random().nextInt(99999),
      rate.ceil(),
      message,
      Jiffy(),
    );
    await orderRepo.rateOrder(_order, rating);
    orderRating.value = rating;
    shouldCheckNewlyCreatedOrder = true;
    Get.back();
  }
}