import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class MainHomeController extends GetxController {
  final appRepo = Get.find<AppRepo>();
  // final userRepo = Get.find<UserRepo>();

  DateTime? currentBackPressTime;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void onInit() async {
    super.onInit();

    final latestVersion = await appRepo.checkIfLatestVersion(false);
    if (!latestVersion) {
      Get.offNamed(Routes.updateApp);
      return;
    }
  }

  void navigateTo(int index) {
    pageController.jumpToPage(
      index,
    );
  }
}
