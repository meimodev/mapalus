import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String fontFamily = 'Poppins';
final ThemeData appThemeData = ThemeData.light().copyWith(
  primaryColor: Palette.accent,
  scaffoldBackgroundColor: Palette.scaffold,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
      color: Palette.textPrimary,
    ),
    counterStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 9.sp,
      fontWeight: FontWeight.w400,
      color: Palette.textPrimary,
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Palette.primary,
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: fontFamily,
      fontSize: 36.sp,
      fontWeight: FontWeight.w400,
      color: Palette.textPrimary,
    ),
    headline2: TextStyle(
      fontFamily: fontFamily,
      fontSize: 27.sp,
      fontWeight: FontWeight.w500,
      color: Palette.textPrimary,
    ),
    headline3: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Palette.textPrimary,
    ),
    headline4: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Palette.textPrimary,
    ),
    headline5: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Palette.textPrimary,
    ),
    headline6: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Palette.textPrimary,
    ),
    bodyText1: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Palette.textPrimary,
    ),
    bodyText2: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Palette.textPrimary,
    ),
    // bodySmall: TextStyle(
    //   fontFamily: fontFamily,
    //   fontSize: 12.sp,
    //   fontWeight: FontWeight.w400,
    //   color: Palette.textPrimary,
    // ),
    caption: TextStyle(
      fontFamily: fontFamily,
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: Palette.textPrimary,
    ),
  ),
);

class Palette {
  static const Color primary = Color(0xFFFF9800);
  static const Color accent = Color(0xFF2B2E33);

  static const Color cardForeground = Color(0xFFFFFFFF);
  static const Color scaffold = Color(0xFFF8FAFC);

  static const Color positive = Color(0xFF38C672);
  static const Color negative = Color(0xFFC63849);

  static const Color editable = Color(0xFFE7EAF0);

  static const Color notification = Color(0xFFFF0000);

  //textColor
  static const Color textPrimary = accent;
  static const Color textAccent = accent;
}

class Insets {
  static const double small = 12.0;
  static const double medium = 21.0;
  static const double large = 39.0;
}

class Roundness {
  static const double small = 12.0;
  static const double large = 30.0;
}