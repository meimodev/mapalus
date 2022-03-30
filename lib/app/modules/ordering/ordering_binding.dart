import 'package:get/get.dart';
import 'package:mapalus/app/modules/ordering/ordering_controller.dart';

class OrderingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderingController>(OrderingController());
  }
}