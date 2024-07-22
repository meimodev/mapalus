import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/signing/signing_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';

import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class SigningScreen extends GetView<SigningController> {
  const SigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      backgroundColor: BaseColor.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(
            title: '',
            isInverted: true,
          ),
          Expanded(
            child: Container(
              color: BaseColor.accent,
              child: CarouselSlider(
                items: [
                  _buildGraphicHolderCard(
                    context: context,
                    assetName: 'assets/vectors/phone.svg',
                    text: 'Pesan dirumah, harga pasar',
                  ),
                  _buildGraphicHolderCard(
                    context: context,
                    assetName: 'assets/vectors/bike.svg',
                    text: 'Tinggal tunggu, kami antar',
                  ),
                  _buildGraphicHolderCard(
                    context: context,
                    assetName: 'assets/vectors/packet.svg',
                    text: 'Tidak sesuai, kami ganti',
                  ),
                ],
                options: CarouselOptions(
                  pauseAutoPlayOnTouch: true,
                  viewportFraction: 1,
                  height: double.infinity,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          Obx(
            () => CardSigning(
              signingState: controller.signingState.value,
              onPressedRequestOTP: controller.onPressedRequestOTP,
              onPressedConfirmCode: controller.onPressedConfirmCode,
              onPressedCreateUser: controller.onPressedCreateUser,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }

  _buildGraphicHolderCard({
    required BuildContext context,
    required String assetName,
    required String text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.small.w,
                    vertical: Insets.small.h,
                  ),
                  child: SvgPicture.asset(
                    assetName,
                    height: 200.h,
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                        color: BaseColor.editable,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardSigning extends StatelessWidget {
  const CardSigning({
    super.key,
    required this.signingState,
    required this.onPressedRequestOTP,
    required this.onPressedConfirmCode,
    required this.onPressedCreateUser,
    required this.controller,
  });

  final CardSigningState signingState;

  final SigningController controller;

  final VoidCallback onPressedRequestOTP;
  final VoidCallback onPressedConfirmCode;
  final VoidCallback onPressedCreateUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.medium.w,
        vertical: Insets.small.w,
      ),
      decoration: BoxDecoration(
        color: BaseColor.cardForeground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.sp),
        ),
      ),
      child: WillPopScope(
        onWillPop: controller.onPressedBack,
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: controller.isLoading.value
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: Insets.small.h),
                    child:
                        const CircularProgressIndicator(color: BaseColor.primary),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...generateSigningHeader(context),
                      SizedBox(height: Insets.small.h * .5),
                      generateSigningTextField(context),
                      SizedBox(height: Insets.small.h),
                      generateSigningButton(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  generateSigningButton() {
    String buttonText;
    VoidCallback onPressed;

    // print("generateSigningButton() " + signingState.name);
    switch (signingState) {
      case CardSigningState.oneTimePassword:
        buttonText = "Masuk";
        onPressed = onPressedRequestOTP;
        break;
      case CardSigningState.confirmCode:
        buttonText = "Konfirmasi Kode";
        onPressed = onPressedConfirmCode;

        break;
      case CardSigningState.notRegistered:
        // print("generateSigningButton() not registered called");

        buttonText = "Daftar & Masuk";
        onPressed = onPressedCreateUser;

        break;
      default:
        buttonText = "INVALID STATE";
        onPressed = () {};
    }

    return Material(
      color: BaseColor.primary,
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      borderRadius: BorderRadius.circular(9.sp),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(Insets.small.sp),
          child: Center(
            child: Text(buttonText),
          ),
        ),
      ),
    );
  }

  generateSigningTextField(BuildContext context) {
    String labelText = "Nomor Handphone";
    var textInputType = TextInputType.number;
    VoidCallback onPressed;

    switch (signingState) {
      case CardSigningState.oneTimePassword:
        onPressed = onPressedRequestOTP;
        textInputType = TextInputType.phone;
        break;
      case CardSigningState.confirmCode:
        labelText = "Kode";
        onPressed = onPressedConfirmCode;
        textInputType = TextInputType.number;
        break;
      case CardSigningState.notRegistered:
        labelText = "Nama Anda";
        onPressed = onPressedCreateUser;
        textInputType = TextInputType.text;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.small.w,
        vertical: 2.w,
      ),
      decoration: BoxDecoration(
        color: BaseColor.editable,
        borderRadius: BorderRadius.circular(9.sp),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller.tecSigning,
            maxLines: 1,
            onSubmitted: (_) => onPressed(),
            autocorrect: false,
            style: TextStyle(
              color: BaseColor.accent,
              fontFamily: fontFamily,
              fontSize: 14.sp,
            ),
            cursorColor: BaseColor.primary,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12.sp,
              ),
              isDense: true,
              border: InputBorder.none,
              labelText: labelText,
            ),
          ),
          Obx(
            () => AnimatedSwitcher(
              duration: 400.milliseconds,
              child: controller.errorText.isNotEmpty
                  ? Text(
                      controller.errorText.value,
                      style: TextStyle(
                            color: BaseColor.negative,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                          ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  generateSigningHeader(BuildContext context) {
    String? message = controller.message;
    String phone = controller.phone;
    bool isTitleHeadVisible = false;
    bool isAlignMiddle = false;

    switch (signingState) {
      case CardSigningState.oneTimePassword:
        isAlignMiddle = true;
        isTitleHeadVisible = false;
        break;
      case CardSigningState.confirmCode:
        isTitleHeadVisible = true;
        message = null;
        break;
      case CardSigningState.notRegistered:
        isTitleHeadVisible = true;
        message = null;
        break;
    }

    return [
      Text(
        'Nomor Handphone',
        style: TextStyle(
              fontSize: 12.sp,
              color: isTitleHeadVisible ? Colors.grey : Colors.transparent,
            ),
      ),
      Text(
        message ?? phone,
        textAlign: isAlignMiddle ? TextAlign.center : TextAlign.start,
        style: TextStyle(
              fontSize: 14.sp,
            ),
      ),
    ];
  }
}
