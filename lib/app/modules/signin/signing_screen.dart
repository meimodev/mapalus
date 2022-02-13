import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/theme.dart';

class SigningScreen extends StatelessWidget {
  const SigningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey,
              child: CarouselSlider(
                  items: [
                    _buildGraphicHolderCard(context, Text('Slide 1')),
                    _buildGraphicHolderCard(
                        context, Container(color: Colors.red)),
                    _buildGraphicHolderCard(context, Text('Slide 3')),
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

  _buildGraphicHolderCard(BuildContext context, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: child,
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
    late var _onPressed;

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
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (route) => false);
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
          top: Radius.circular(12.sp),
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