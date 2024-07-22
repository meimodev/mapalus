import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';

class FoodBinding implements Bindings {
  @override
  void dependencies() {

    Get.put<FoodController>(FoodController());
  }
}