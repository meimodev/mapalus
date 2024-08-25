import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class OrderingController extends GetxController {
  final orderRepo = Get.find<OrderRepo>();

  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;
    if (args == null) {
      throw Exception("Required orderApp data");
    }

    final order = OrderApp.fromJson(args as Map<String, dynamic>);

    await orderRepo.createOrder(
      PostOrderRequest(
        order: order
      ),
    );

    dev.log(order.toString());

    orderRepo.clearLocalProductOrders();
    orderRepo.clearLocalNote();

    isLoading.value = false;
  }

  void onPressedSeeOrder() {
    Get.back();
  }
}
