import 'package:get/get.dart';
import 'package:mapalus/data/services/firebase_services.dart';
import 'package:mapalus/shared/routes.dart';

class HomeController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void onPressedLogo() {
    Get.toNamed(Routes.accountSetting);
  }

  void onPressedLatestOrder() {
    Get.toNamed(Routes.orders);
  }

  void onPressedCart() {
    Get.toNamed(Routes.cart);
  }
}