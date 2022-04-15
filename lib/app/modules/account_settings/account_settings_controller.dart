import 'package:get/get.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/routes.dart';

class AccountSettingsController extends GetxController {
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxInt orderCount = 0.obs;

  UserRepo userRepo = Get.find();

  @override
  void onInit() {
    if (userRepo.signedUser != null) {
      userName.value = userRepo.signedUser!.name;
      userPhone.value = userRepo.signedUser!.phone;
    }
    userRepo.onSuccessSigning = (user) {
      userName.value = user.name;
      userPhone.value = user.phone;
    };
    userRepo.onSigningOut = () {
      userName.value = '';
      userPhone.value = '';
    };
    super.onInit();
  }

  onPressedEditAccountInfo() {}

  onPressedOrders() {
    Get.toNamed(Routes.orders);
  }

  onPressedSignOut() async {
    await userRepo.signOut();
  }

  onPressedSignIn() {
    Get.toNamed(
      Routes.signing,
      arguments: "",
    );
  }
}