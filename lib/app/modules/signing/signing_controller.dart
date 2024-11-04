import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

enum SigningState {
  verifyNumber,
  otp,
  unregistered,
}

class SigningController extends GetxController {
  final appRepo = Get.find<AppRepo>();
  final userRepo = Get.find<UserRepo>();
  final partnerRepo = Get.find<PartnerRepo>();

  String errorText = "";

  String phone = "";

  RxBool loading = false.obs;

  SigningState signingState = SigningState.verifyNumber;

  final tecPin = TextEditingController();
  final tecName = TextEditingController();

  @override
  void dispose() {
    tecPin.dispose();
    tecName.dispose();
    super.dispose();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    // await _loading(true);

    initSigningCallback();

    // await _loading(false);
  }

  initSigningCallback() {
    userRepo.onSuccessSigning = (user) async {
      Get.back(result: true);
    };

    userRepo.onUnregisteredUser = (user) async {
      await _loading(true);
      signingState = SigningState.unregistered;
      await _loading(false);
    };
  }

  Future<void> onPressedSignIn() async {
    await _loading(true);
    Validator.resetErrorCounter();

    errorText = Validator(
      value: phone,
      name: "Nomor Handphone",
    ).notEmptyOrZero().mustStartsWith("0").validate();

    if (Validator.hasError()) {
      await _loading(false);
      return;
    }

    await userRepo.requestOTP(
      phone,
      (result) async {
        if (result.error) {
          errorText = result.message;
          tecPin.text = "";
          await _loading(false);
          return;
        }
        if (result.message.contains("MANUAL_VERIFICATION")) {
          signingState = SigningState.otp;
          errorText = "";
          await _loading(false);
        }
      },
    );
  }

  void onChangedPhone(String value) {
    phone = value;
  }

  void onCompletedPin(String otp) async {
    await _loading(true);
    await userRepo.verifyOTP(
      otp,
      (result) async {
        if (result.error) {
          errorText = result.message;
          tecPin.text = "";
          await _loading(false);
          return;
        }
      },
    );
  }

  void onPressedRegister() async {
    await _loading(true);

    Validator.resetErrorCounter();

    final String name = tecName.text.trim();
    errorText = Validator(
      value: name,
      name: "Nama",
    ).notEmptyOrZero().notLessThan(3).validate();

    if (Validator.hasError()) {
      await _loading(false);
      return;
    }

    await userRepo.registerUser(name: name.capitalizeByWord);
    await _loading(false);
  }

  Future<void> _loading(bool value) async {
    if (loading.value == value) return;
    await Future.delayed(const Duration(milliseconds: 300));
    loading.value = value;
  }
}
