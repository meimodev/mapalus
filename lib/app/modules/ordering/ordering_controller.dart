import 'dart:developer' as dev;

import 'package:get/get.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class OrderingController extends GetxController {
  final orderRepo = Get.find<OrderRepo>();
  final appRepo = Get.find<AppRepo>();
  final partnerRepo = Get.find<PartnerRepo>();

  RxBool isLoading = true.obs;

  OrderApp? order;

  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;
    if (args == null) {
      throw Exception("Required orderApp data");
    }

    order = OrderApp.fromJson(args as Map<String, dynamic>);

    await orderRepo.createOrder(
      PostOrderRequest(order: order!),
    );

    dev.log("[ORDERING CONTROLLER] sent order $order");

    final partner = await partnerRepo.getPartners(
      GetPartnerRequest(
        partnerId: order!.partnerId,
      ),
    );

    await appRepo.sendNotification(
      PostNotificationRequest(
        title: "PESANAN BARU",
        body: "Rp. ${order!.payment.amount} - "
            "${order!.products.length} Produk - "
            "Antar ${order!.delivery!.selectedTime.name.translate}",
        destination: partner!.fcmToken,
      ),
    );

    orderRepo.clearLocalProductOrders();
    orderRepo.clearLocalNote();

    isLoading.value = false;
  }

  void onPressedSeeOrder() {
    Get.offNamedUntil(
      Routes.orderDetail,
      (route) => (route as GetPageRoute).routeName == Routes.home,
      arguments: order!.toJson(),
    );
  }
}
