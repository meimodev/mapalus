import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class OrdersController extends GetxController {
  OrderRepo orderRepo = Get.find();
  UserRepo userRepo = Get.find();

  RxList<OrderApp> orders = <OrderApp>[].obs;
  List<OrderApp> tempOrders = <OrderApp>[];

  RxBool isLoading = false.obs;

  @override
  void onReady() {
    _populateOrders();
    super.onReady();
  }

  void _populateOrders() async {
    isLoading.value = true;
    // final userOrders = await orderRepo.readUserOrders(userRepo.signedUser!);
    // orders.value = userOrders.reversed.toList();
    tempOrders.addAll(orders);

    isLoading.value = false;
  }

  void onChangeFilterActiveIndex(OrderStatus? status) {
    if (status == null) {
      if (tempOrders.length != orders.length) {
        orders.value = tempOrders;
      }
      return;
    }
    if (tempOrders.length != orders.length) {
      orders.value = tempOrders;
    }
    orders.value = orders.where((element) => element.status == status).toList();
  }
}
