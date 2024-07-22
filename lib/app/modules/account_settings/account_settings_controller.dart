import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';

class AccountSettingsController extends GetxController {
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxInt orderCount = 0.obs;
  RxString currentVersion = ''.obs;

  GroceryController homeController = Get.find();

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

  onPressedDeleteAccount(String phone) async {
    try {
      var isDeleted = await userRepo.deleteUser(phone);
      if (isDeleted) {
        Get.back();
        Get.snackbar('', 'user $phone Berhasil dihapus');
      }
      await userRepo.signOut();
    } catch (e) {
      var isNeedReSign = e.toString().contains('sign to confirm');
      if (isNeedReSign) {
        Get.toNamed(Routes.signing,
            arguments: "Masuk untuk konfirmasi penghapusan akun");
        await userRepo.signOut();
      }
    }
  }
}
