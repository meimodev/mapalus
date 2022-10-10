import 'package:get/get.dart';
import 'package:mapalus/app/modules/payment/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentController>(PaymentController());
  }

}