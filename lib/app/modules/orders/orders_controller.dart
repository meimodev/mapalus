import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrdersController extends GetxController {
  OrderRepo orderRepo = Get.find();
  UserRepo userRepo = Get.find();

  RxList<OrderApp> orders = <OrderApp>[].obs;

  RxBool isLoading = false.obs;
  RxBool isNoOrderLayoutVisible = false.obs;

  @override
  void onReady() {
    _populateOrders();
    super.onReady();
  }

  _populateOrders() async {
    isLoading.value = true;
    final userOrders = await orderRepo.readUserOrders(userRepo.signedUser!);
    orders.value = userOrders.reversed.toList();
    if (orders.isEmpty) {
      isNoOrderLayoutVisible.value = true;
    }
    isLoading.value = false;
  }
}