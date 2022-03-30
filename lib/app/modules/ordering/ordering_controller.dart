import 'package:get/get.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/user.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/routes.dart';

class OrderingController extends GetxController {
  OrderRepo orderRepo = OrderRepo();
  UserRepo userRepo = Get.find<UserRepo>();

  RxBool isLoading = true.obs;

  @override
  void onReady() async {
    super.onReady();

    User? _signedInUser = await userRepo.readSignedInUser();

    Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
    DeliveryInfo _deliveryInfo = args['delivery_info'] as DeliveryInfo;
    List<ProductOrder> _productOrders =
        args['product_orders'] as List<ProductOrder>;

    Order order = await orderRepo.createOrder(
      deliveryInfo: _deliveryInfo,
      products: _productOrders,
      user: _signedInUser!,
    );

    print(order.toString());
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
    Get.offNamedUntil(Routes.home, (route) => false);
  }
}