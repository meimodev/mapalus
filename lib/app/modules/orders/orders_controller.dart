import 'package:get/get.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';

class OrdersController extends GetxController {
  OrderRepo orderRepo = Get.find();
  UserRepo userRepo = Get.find();

  RxList<Order> orders = <Order>[].obs;

  RxBool isLoading = false.obs;
  RxBool isNoOrderLayoutVisible = false.obs;

  @override
  void onReady() {
    _populateOrders();
    super.onReady();
  }

  _populateOrders() async {
    isLoading.value = true;
    orders.value = await orderRepo.readOrders(userRepo.signedUser!);
    if (orders.isEmpty) {
      isNoOrderLayoutVisible.value = true;
    }
    isLoading.value = false;
  }
}