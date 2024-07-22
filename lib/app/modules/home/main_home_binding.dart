import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class MainHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppRepo>(AppRepo());
    Get.put<UserRepo>(UserRepo());
    Get.put<OrderRepo>(OrderRepo());
    Get.put<ProductRepo>(ProductRepo());
    Get.put<MainHomeController>(MainHomeController());
  }
}