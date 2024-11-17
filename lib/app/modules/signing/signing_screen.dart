import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/signing/signing_controller.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class SigningScreen extends GetView<SigningController> {
  const SigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      backgroundColor: BaseColor.accent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: BaseSize.w24,
              vertical: BaseSize.h24,
            ),
            decoration: BoxDecoration(
              color: BaseColor.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(BaseSize.radiusMd),
              ),
            ),
            child: Obx(
              () => LoadingWrapper(
                addedWidget: Text(
                  "Tunggu sebentar yaa, Loading mungkin agak lama",
                  style: BaseTypography.bodyMedium,
                ),
                loading: controller.loading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    controller.signingState != SigningState.verifyNumber
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputWidget.text(
                                label: "Cukup masuk dengan nomor HP aktif",
                                hint: "Nomor Hand Phone",
                                currentInputValue: controller.phone,
                                textInputType: TextInputType.phone,
                                backgroundColor: BaseColor.editable,
                                borderColor: BaseColor.accent,
                                errorText: controller.errorText,
                                onChanged: controller.onChangedPhone,
                              ),
                              Gap.h24,
                              ButtonWidget(
                                text: "Masuk",
                                onPressed: controller.onPressedSignIn,
                              ),
                            ],
                          ),
                    controller.signingState != SigningState.otp
                        ? const SizedBox()
                        : PinPickerWidget(
                            controller: controller.tecPin,
                            label: 'OTP telah terkirim di ${controller.phone}',
                            errorText: controller.errorText,
                            onCompletedPin: controller.onCompletedPin,
                          ),
                    controller.signingState != SigningState.unregistered
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputWidget.text(
                                label:
                                    "Masukkan nama untuk mempermudah pengantaran",
                                hint: "Nama",
                                controller: controller.tecName,
                                backgroundColor: BaseColor.editable,
                                borderColor: BaseColor.accent,
                                errorText: controller.errorText,
                              ),
                              Gap.h24,
                              ButtonWidget(
                                text: "Daftar & Masuk",
                                backgroundColor: BaseColor.accent,
                                textColor: BaseColor.primary3,
                                onPressed: controller.onPressedRegister,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
