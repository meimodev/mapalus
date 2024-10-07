import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class MainHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppRepo>(AppRepo());
    Get.put<UserRepo>(UserRepo());
    Get.put<OrderRepo>(OrderRepoImpl());
    Get.put<ProductRepo>(ProductRepo());
    Get.put<PartnerRepo>(PartnerRepo());
    Get.put<MainHomeController>(MainHomeController());
  }
}
