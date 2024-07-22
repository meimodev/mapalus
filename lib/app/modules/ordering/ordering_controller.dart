
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';
import 'dart:developer' as dev;

class OrderingController extends GetxController {
  OrderRepo orderRepo = Get.find<OrderRepo>();
  UserRepo userRepo = Get.find<UserRepo>();
  GroceryController homeController = Get.find<GroceryController>();

  RxBool isLoading = true.obs;

  OrderApp? _orderToPush;

  @override
  void onReady() async {
    super.onReady();

    UserApp? user = await userRepo.readSignedInUser();

    final args = Get.arguments as Map<String, dynamic>;
    final productOrders = args['product_orders'] as List<ProductOrder>;
    final orderInfo = args['order_info'] as OrderInfo;
    final paymentMethod = args['payment_method'] as String;
    final paymentAmount = args['payment_amount'] as int;
    final note = args['note'].toString();

    await Future.delayed(const Duration(milliseconds: 2000));

    final order = await orderRepo.createOrder(
      products: productOrders,
      user: user!,
      orderInfo: orderInfo,
      paymentAmount: paymentAmount,
      paymentMethod: paymentMethod,
      note: note,
    );

    NotificationService.instance.sendNotification(
      title: "Pesanan Baru ! on ${order.orderTimeStamp.format(pattern:"EEEE, dd MMM HH:mm")}",
      message: "#${order.idMinified} | ${order.orderingUser.name} - ${order.orderingUser.phone} | "
          "${order.orderInfo.productCountF}, "
          "${order.orderInfo.totalPriceF}, "
          "Antar ${order.orderInfo.deliveryTime}",
    );
    _orderToPush = order;

    dev.log(order.toString());

    isLoading.value = false;
  }

  onPressedBack() {
    if (isLoading.isFalse) {
      _backToHome();
    } else {
      Get.back();
    }
  }

  onPressedReturn() {
    _backToHome();
  }

  _backToHome() {
    Get.until(ModalRoute.withName(Routes.home));
    homeController.orderCleanUp();
  }

  void onPressedSeeOrder() {
    Get.until(ModalRoute.withName(Routes.home));
    homeController.orderCleanUp();
    Get.toNamed(Routes.orderDetail, arguments: _orderToPush);
  }
}
