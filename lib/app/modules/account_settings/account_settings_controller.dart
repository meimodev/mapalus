import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/routes.dart';

class AccountSettingsController extends GetxController {
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxInt orderCount = 0.obs;
  HomeController homeController = Get.find();

  UserRepo userRepo = Get.find();

  @override
  void onInit() {
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

    final _orderCount = int.parse(Get.arguments.toString());
    orderCount.value = _orderCount;
    super.onInit();
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