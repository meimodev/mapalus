import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';

class LaundryBinding implements Bindings {
  @override
  void dependencies() {

    Get.put<LaundryController>(LaundryController());
  }
}