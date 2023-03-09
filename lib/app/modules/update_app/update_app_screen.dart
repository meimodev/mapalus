import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'dart:io' show Platform;

class UpdateAppScreen extends StatelessWidget {
  const UpdateAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Palette.cardForeground,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/mapalus.svg',
                width: 60.sp,
                height: 60.sp,
                colorFilter: const ColorFilter.mode(
                  Palette.accent,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: Insets.small.h * .5),
              SizedBox(height: Insets.large.h),
              Text(
                'Silahkan update aplikasi\nuntuk menggunakan fitur terbaru mapalus ☺',
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(height: Insets.small.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Platform.isIOS
                      ? _buildButton(
                          context,
                          title: 'App Store',
                          icon: Icons.apple,
                          onPressed: () {
                            String url =
                                "https://apps.apple.com/us/app/mapalus/id1626796752";
                            // ignore: deprecated_member_use
                            launch(url);
                          },
                        )
                      : const SizedBox(),
                  Platform.isAndroid
                      ? _buildButton(
                          context,
                          title: 'Play Store',
                          icon: Icons.android,
                          onPressed: () {
                            String url =
                                "https://play.google.com/store/apps/details?id=com.meimodev.mapalus";
                            // ignore: deprecated_member_use
                            launch(url);
                          },
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required String title,
    required IconData icon,
  }) {
    return Material(
      color: Palette.primary,
      borderRadius: BorderRadius.circular(12.w),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.small.w,
            vertical: Insets.small.h,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Palette.accent,
                size: 21.w,
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style:TextStyle(
                      fontSize: 12.sp,
                      color: Palette.accent,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
