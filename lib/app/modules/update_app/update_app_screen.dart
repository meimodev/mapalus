import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'dart:io' show Platform;

class UpdateAppScreen extends StatelessWidget {
  const UpdateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: BaseColor.cardBackground1,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/mapalus.svg',
                width: 60.sp,
                height: 60.sp,
                colorFilter: const ColorFilter.mode(
                  BaseColor.accent,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: BaseSize.h12 * .5),
              SizedBox(height: BaseSize.h48),
              Text(
                'Silahkan update aplikasi\nuntuk menggunakan fitur terbaru mapalus ☺',
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(height: BaseSize.h12),
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
      color: BaseColor.primary3,
      borderRadius: BorderRadius.circular(12.w),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: BaseColor.accent,
                size: 21.w,
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style:TextStyle(
                      fontSize: 12.sp,
                      color: BaseColor.accent,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
