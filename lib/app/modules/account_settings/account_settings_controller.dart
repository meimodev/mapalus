import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/repo/app_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/routes.dart';

class AccountSettingsController extends GetxController {
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxInt orderCount = 0.obs;
  RxString currentVersion = ''.obs;

  HomeController homeController = Get.find();

  AppRepo appRepo = Get.find();
  UserRepo userRepo = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();

    if (userRepo.signedUser != null) {
      userName.value = userRepo.signedUser!.name;
      userPhone.value = userRepo.signedUser!.phone;
    }

    userRepo.onSignedUser = (user) {
      userName.value = user.name;
      userPhone.value = user.phone;
    };
    userRepo.onSigningOut = () {
      userName.value = '';
      userPhone.value = '';
    };

    final count = int.parse(Get.arguments.toString());
    orderCount.value = count;

    initVersion();
  }

  initVersion() async {
    currentVersion.value = await appRepo.getCurrentVersion();
  }

  onPressedEditAccountInfo() {}

  onPressedOrders() {
    Get.toNamed(Routes.orders);
  }

  onPressedSignOut() async {
    await userRepo.signOut();
    homeController.isCardCartVisible.value = false;
    homeController.isCardOrderVisible.value = false;
    homeController.unfinishedOrderCount.value = 0;
  }

  onPressedSignIn() {
    Get.toNamed(
      Routes.signing,
      arguments: "",
    );
  }
}