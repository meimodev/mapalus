import 'package:get/get.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/routes.dart';

class HomeController extends GetxController {
  RxBool isCardCartVisible = true.obs;
  RxBool isCardOrderVisible = false.obs;

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  // }

  void onPressedLogo() {
    Get.toNamed(Routes.accountSetting);
  }

  void onPressedLatestOrder() {
    Get.toNamed(Routes.orders);
  }

  void onPressedCart() {
    Get.toNamed(Routes.cart);
  }

  void onPressedAddToCart(ProductOrder productOrder) {
    print(productOrder.toString());
  }
}