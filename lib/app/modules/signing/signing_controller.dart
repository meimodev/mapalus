import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/enums.dart';

class SigningController extends GetxController {
  HomeController homeController = Get.find();
  UserRepo userRepo = Get.find();

  TextEditingController tecSigning = TextEditingController();
  Rx<String> errorText = "".obs;
  String? message;

  String phone = "";
  String name = '';

  Rx<CardSigningState> signingState = CardSigningState.oneTimePassword.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    var args = Get.arguments;
    message = args.toString();
    super.onInit();
  }

  @override
  void onClose() {
    if (phone.isNotEmpty && name.isNotEmpty) {
      homeController.onSignedInUser(UserApp(name: name, phone: phone));
    }
    Get.back();
  }

  onPressedRequestOTP() async {
    String input = tecSigning.text.removeAllWhitespace;
    if (input.isEmpty) {
      errorText.value = "Tidak bisa kosong";
      return;
    }

    if (input.startsWith("+62")) {
      input = input.replaceFirst("+62", "0");
      tecSigning.text = input;
    }

    if (!input.startsWith("0")) {
      errorText.value = "Nomor handphone harus dimulai dengan 0";
      return;
    }

    if (input.length < 12) {
      errorText.value = "Nomor handphone tidak kurang dari 12 angka";
      return;
    }

    if (input.length > 14) {
      errorText.value = "Nomor handphone tidak lebih dari 14 angka";
      return;
    }

    if (!input.isNumericOnly) {
      errorText.value = "Nomor handphone tidak valid";
      return;
    }

    isLoading.value = true;
    phone = input;
    userRepo.requestOTP(
      phone,
      (res) async {
        switch (res.message) {
          case 'PROCEED':
            // userRepo.signInUser(phone);
            Get.back();
            break;
          case 'UNREGISTERED':
            isLoading.value = false;
            tecSigning.clear();
            errorText.value = "";
            signingState.value = CardSigningState.notRegistered;
            break;
          case 'SENT':
            isLoading.value = false;
            tecSigning.clear();
            errorText.value = "";
            signingState.value = CardSigningState.confirmCode;
            break;
          case 'VERIFICATION_FAILED':
            isLoading.value = false;
            errorText.value =
                "Koneksi ke internet bermasalah, cobalah sesaat lagi";
            break;
        }
      },
    );
  }

  onPressedConfirmCode() async {
    String input = tecSigning.text.removeAllWhitespace;
    if (input.isEmpty) {
      errorText.value = "Tidak bisa kosong";
      return;
    }

    if (input.length > 6 || input.length < 6) {
      errorText.value = "Kode terdiri dari 6 angka";
      return;
    }

    if (!input.isNum) {
      errorText.value = "Kode tidak valid";
      return;
    }

    isLoading.value = true;

    userRepo.checkOTPCode(input, (res) async {
      switch (res.message) {
        case 'INVALID_CODE':
          isLoading.value = false;

          errorText.value = "Kode yang dimasukkan tidak tepat";

          return;
        case 'INVALID_ID':
          break;
        case 'EXPIRED':
          isLoading.value = false;
          tecSigning.clear();
          errorText.value =
              "Kode kadaluarsa, silahkan masukkan nomor HP kembali";
          signingState.value = CardSigningState.oneTimePassword;
          return;
        case 'OK':
          if (await userRepo.checkIfRegistered(phone)) {
            Get.back();
            return;
          } else {
            isLoading.value = false;
            tecSigning.clear();
            errorText.value = "";
            signingState.value = CardSigningState.notRegistered;
          }
          return;
      }
    });
  }

  onPressedCreateUser() async {
    String input = tecSigning.text;
    if (input.isEmpty) {
      errorText.value = "Tidak bisa kosong";
      return;
    }

    if (input.startsWith(" ")) {
      errorText.value = "Harus dimulai dengan huruf";
      return;
    }

    if (input.length < 3) {
      errorText.value = "Nama tidak kurang dari 3 huruf";
      return;
    }

    if (input.length > 30) {
      errorText.value = "Nama tidak lebih dari 30 huruf";
      return;
    }

    String mod = input.replaceAll(" ", "xxxxx");
    if (!mod.isAlphabetOnly) {
      errorText.value = "Nama hanya terdiri dari A - z";
      return;
    }

    name = input;
    await userRepo.registerUser(phone, name);

    tecSigning.clear();
    errorText.value = "";
    Get.back();
  }

  Future<bool> onPressedBack() {
    if (signingState.value == CardSigningState.confirmCode) {
      signingState.value = CardSigningState.oneTimePassword;
      return Future.value(false);
    }
    return Future.value(true);
  }
}