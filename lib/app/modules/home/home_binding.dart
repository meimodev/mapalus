import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/repo/user_repo.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserRepo>(UserRepo());
    Get.put<HomeController>(HomeController());
  }
}