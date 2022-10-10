import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/data/services/notification_service.dart';
import 'package:mapalus/shared/routes.dart';

class OrderingController extends GetxController {
  OrderRepo orderRepo = Get.find<OrderRepo>();
  UserRepo userRepo = Get.find<UserRepo>();
  HomeController homeController = Get.find<HomeController>();

  RxBool isLoading = true.obs;

  Order? _orderToPush;

  @override
  void onReady() async {
    super.onReady();

    UserApp? user = await userRepo.readSignedInUser();

    final args = Get.arguments as Map<String, dynamic>;
    final productOrders =
        args['product_orders'] as List<ProductOrder>;
    final orderInfo = args['order_info'] as OrderInfo;
    final paymentMethod =  args['payment_method'] as String;
    final paymentAmount = args['payment_amount'] as int;

    await Future.delayed(const Duration(milliseconds: 2000));

    Order order = await orderRepo.createOrder(
      products: productOrders,
      user: user!,
      orderInfo: orderInfo,
      paymentAmount: paymentAmount,
      paymentMethod: paymentMethod,
    );
    var now = Jiffy();
    NotificationService.instance.sendNotification(
      title: "NEW ORDER ! on ${now.format("EEEE, dd MMM HH:mm")}",
      message: "#${order.idMinified}, "
          "${order.orderInfo.productCountF}, "
          "${order.orderInfo.totalPriceF}, "
          "Diantar ${order.orderInfo.deliveryTime}",
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
