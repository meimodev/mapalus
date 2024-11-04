import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/services/services.dart';

class MainHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppRepo>(AppRepo());
    Get.put<LocalStorageService>(LocalStorageService());
    Get.put<UserRepo>(
      UserRepo(
        appRepo: Get.find<AppRepo>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
    );
    Get.put<OrderRepo>(OrderRepo());
    Get.put<ProductRepo>(ProductRepo());
    Get.put<PartnerRepo>(PartnerRepo());
    Get.put<MainHomeController>(MainHomeController());

    //child controllers can be set to lazy load
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => PromoController());
  }
}
