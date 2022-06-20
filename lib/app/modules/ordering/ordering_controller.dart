import 'package:flutter/foundation.dart';
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

    Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
    List<ProductOrder> productOrders =
        args['product_orders'] as List<ProductOrder>;
    OrderInfo orderInfo = args['order_info'] as OrderInfo;

    try {
      Order order = await orderRepo.createOrder(
        products: productOrders,
        user: user!,
        orderInfo: orderInfo,
      );
      var now = Jiffy();
      NotificationService.instance.sendNotification(
        title: "NEW ORDER ! on ${now.format("EEEE, dd MMM HH:mm")}",
        message: "#${order.id}, "
            "${order.orderInfo.productCountF}, "
            "${order.orderInfo.totalPrice}, "
            "DIantar ${order.orderInfo.deliveryTime}",
      );
      _orderToPush = order;
      if (kDebugMode) {
        print(order.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print('error occurred while creating order $e');
      }
    }

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
    // Get.offNamedUntil(Routes.home, (_) => Get.currentRoute == Routes.home);
    // homeController.seeRecentOrder();
    homeController.orderCleanUp();
    Get.toNamed(Routes.orderDetail, arguments: _orderToPush);
  }
}