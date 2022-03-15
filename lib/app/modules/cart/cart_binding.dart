import 'package:get/get.dart';
import 'cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(CartController());
  }
}