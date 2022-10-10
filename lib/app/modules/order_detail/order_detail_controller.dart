import 'dart:developer' as dev;

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:url_launcher/url_launcher.dart';

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
  RxString deliveryCoordinate = "".obs;
  RxString totalPrice = ''.obs;
  RxString finishTimeStamp = "".obs;

  RxString orderStatus = ''.obs;
  Rx<Rating> orderRating = Rating.zero().obs;
  var paymentMethod = ''.obs;
  var paymentAmount = 0.obs;

  late Order _order;
  bool shouldCheckNewlyCreatedOrder = false;

  RxBool canLoading = true.obs;

  @override
  void onClose() {
    if (shouldCheckNewlyCreatedOrder) {
      homeController.checkNewlyCreatedOrder();
    }
    super.onClose();
  }

  @override
  void onReady() {
    canLoading.value = true;

    Order order = Get.arguments as Order;
    var params = Get.parameters;
    if (params.isNotEmpty) {
      _loadFreshOrder(order.id!);
      super.onReady();
      return;
    }

    _initInterfaceWithData(order);

    super.onReady();
  }

  _loadFreshOrder(String orderId) async {
    Order? t = await orderRepo.readOrder(orderId);
    Order order = t!;
    _initInterfaceWithData(order);
  }

  _initInterfaceWithData(Order order) {
    _order = order;
    productOrders.value = order.products;
    id.value = order.idMinified;

    var orderTimeStamp = order.orderTimeStamp;
    orderTime.value = orderTimeStamp!.format("EEEE, dd MMMM HH:mm");

    productCount.value = order.orderInfo.productCountF;
    productTotal.value = order.orderInfo.productPriceF;
    deliveryCount.value = order.orderInfo.deliveryWeightF;
    deliveryTotal.value = order.orderInfo.deliveryPriceF;
    deliveryCoordinate.value = order.orderInfo.deliveryCoordinateF;
    deliveryTime.value = order.orderInfo.deliveryTimeF(shorted: true);
    totalPrice.value = order.orderInfo.totalPriceF;
    finishTimeStamp.value = order.finishTimeStampF;

    orderRating.value = order.rating;

    orderStatus.value = order.status.name;

    paymentMethod.value = order.paymentMethodF;

    paymentAmount.value = order.paymentAmount;

    dev.log(order.toString());

    canLoading.value = false;
  }

  Future<void> onPressedRate(String message, double rate) async {
    canLoading.value = true;
    Future.delayed(800.milliseconds);
    var rating = Rating(
      rate.ceil(),
      message,
      Jiffy(),
    );
    await orderRepo.rateOrder(_order, rating);

    shouldCheckNewlyCreatedOrder = true;

    await Future.delayed(800.milliseconds);

    orderRating.value = rating;
    orderStatus.value = OrderStatus.finished.name;

    canLoading.value = false;

    Get.back();
  }

  onPressedViewMaps() {
    var latitude = _order.orderInfo.deliveryCoordinate.latitude;
    var longitude = _order.orderInfo.deliveryCoordinate.longitude;
    var url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // ignore: deprecated_member_use
    launch(url);
  }
}
