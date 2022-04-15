import 'package:get/get.dart';
import 'package:mapalus/app/modules/account_settings/account_settings_controller.dart';

class AccountSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AccountSettingsController>(AccountSettingsController());
  }
}