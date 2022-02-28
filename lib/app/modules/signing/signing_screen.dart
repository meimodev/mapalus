import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/theme.dart';

class SigningScreen extends StatelessWidget {
  const SigningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      backgroundColor: Palette.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Palette.accent,
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
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
          ),
          const CardSigning(),
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
                    height: 260.h,
                  ),
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Palette.editable,
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

class CardSigning extends StatefulWidget {
  const CardSigning({Key? key}) : super(key: key);

  @override
  _CardSigningState createState() => _CardSigningState();
}

class _CardSigningState extends State<CardSigning> {
  CardSigningState signingState = CardSigningState.oneTimePassword;

  generateSigningButton() {
    String _buttonText;
    Null Function() _onPressed;

    switch (signingState) {
      case CardSigningState.oneTimePassword:
        _buttonText = "Masuk";
        _onPressed = () {
          setState(() {
            signingState = CardSigningState.confirmCode;
          });
        };
        break;
      case CardSigningState.confirmCode:
        _buttonText = "Konfirmasi Kode";
        _onPressed = () {
          setState(() {
            signingState = CardSigningState.notRegistered;
          });
        };

        break;
      default:
        _onPressed = () {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.home, (route) => false);
          Get.offNamed(Routes.home);
        };
        _buttonText = "Daftar & Masuk";
    }

    return Material(
      color: Palette.primary,
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      borderRadius: BorderRadius.circular(9.sp),
      child: InkWell(
        onTap: _onPressed,
        child: Padding(
          padding: EdgeInsets.all(Insets.small.sp),
          child: Center(
            child: Text(_buttonText),
          ),
        ),
      ),
    );
  }

  generateSigningTextField() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.medium.w,
        vertical: Insets.medium.w,
      ),
      decoration: BoxDecoration(
        color: Palette.cardForeground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...signingState != CardSigningState.notRegistered
              ? [
                  SizedBox(
                    height: 39.sp,
                  )
                ]
              : [
                  Text(
                    'Nomor Handphone',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    '0812 1234 1234',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 14.sp,
                        ),
                  ),
                ],
          SizedBox(height: Insets.small.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Insets.small.w,
              vertical: 3.h,
            ),
            decoration: BoxDecoration(
              color: Palette.editable,
              borderRadius: BorderRadius.circular(9.sp),
            ),
            child: TextField(
              maxLines: 1,
              autocorrect: false,
              style: TextStyle(
                color: Palette.accent,
                fontFamily: fontFamily,
                fontSize: 14.sp,
              ),
              cursorColor: Palette.primary,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.sp,
                ),
                isDense: true,
                border: InputBorder.none,
                hintText: "Nomor Handphone",
              ),
            ),
          ),
          SizedBox(height: Insets.small.h),
          generateSigningButton(),
        ],
      ),
    );
  }
}