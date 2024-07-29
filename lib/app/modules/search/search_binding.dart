import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {

    Get.put<SearchController>(SearchController());
  }
}