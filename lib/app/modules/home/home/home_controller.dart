import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class HomeController extends GetxController {
  final appRepo = Get.find<AppRepo>();
  final userRepo = Get.find<UserRepo>();

  UserApp? user;

  RxBool loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    _loading(true);

    userRepo.userAppStream.listen((event) async {
      _loading(true);
      user = event;
      await Future.delayed(const Duration(milliseconds: 400));
      _loading(false);
      if (user != null) {
        await userRepo.updateUserMetaData(user!);
      }
    });
    user = await userRepo.getSignedUser();
    _loading(false);
  }

  void notifyUserHasChanged() async {
    _loading(true);
    user = await userRepo.getSignedUser();
    await Future.delayed(const Duration(milliseconds: 400));
    _loading(false);
    if (user != null) {
      await userRepo.updateUserMetaData(user!);
    }
  }

  void onPressedSignOut() async {
    await userRepo.signOut();
  }

  Future<void> _loading(bool value) async {
    if (loading.value == value) return;
    await Future.delayed(const Duration(milliseconds: 400));
    loading.value = value;
  }
}
