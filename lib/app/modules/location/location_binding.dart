import 'package:get/get.dart';
import 'package:mapalus/app/modules/location/location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocationController>(LocationController());
  }
}