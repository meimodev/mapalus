import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class AccountSettingsController extends GetxController {
  final appRepo = Get.find<AppRepo>();
  final userRepo = Get.find<UserRepo>();

  String currentVersion = '';
  UserApp? user;

  RxBool loading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    loading.value = true;
    currentVersion = await appRepo.getCurrentVersion();
    user = await userRepo.getSignedUser();
    loading.value = false;
  }

  initVersion() async {}

  onPressedEditAccountInfo() {}

  onPressedOrders() {
    Get.toNamed(Routes.orders);
  }

  onPressedSignOut() async {
    await userRepo.signOut();
    // homeController.isCardCartVisible.value = false;
    // homeController.isCardOrderVisible.value = false;
    // homeController.unfinishedOrderCount.value = 0;
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
