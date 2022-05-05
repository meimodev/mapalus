import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/repo/app_repo.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/data/repo/product_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppRepo>(AppRepo());
    Get.put<UserRepo>(UserRepo());
    Get.put<OrderRepo>(OrderRepo());
    Get.put<ProductRepo>(ProductRepo());
    Get.put<HomeController>(HomeController());
  }
}