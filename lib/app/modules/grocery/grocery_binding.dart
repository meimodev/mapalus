import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';

class GroceryBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<AppRepo>(AppRepo());
    // Get.put<UserRepo>(UserRepo());
    // Get.put<OrderRepo>(OrderRepoImpl());
    // Get.put<ProductRepo>(ProductRepo());
    Get.put<GroceryController>(GroceryController());
  }
}
