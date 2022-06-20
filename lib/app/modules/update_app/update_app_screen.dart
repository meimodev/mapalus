import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                color: Palette.accent,
              ),
              SizedBox(height: Insets.small.h * .5),
              SizedBox(height: Insets.large.h),
              Text(
                'Silahkan update aplikasi\nuntuk keamanan & stabilitas termutakhir',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(height: Insets.small.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(
                    context,
                    title: 'App Store',
                    icon: Icons.apple,
                    onPressed: () {
                      String url =
                          "https://apps.apple.com/sg/app/bungkus/id1460126004";
                      launchUrlString(
                        url,
                        mode: LaunchMode.externalNonBrowserApplication,
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    title: 'Play Store',
                    icon: Icons.android,
                    onPressed: () {
                      String url =
                          "https://play.google.com/store/apps/details?id=com.meimodev.mapalus";
                      launchUrlString(
                        url,
                        mode: LaunchMode.externalNonBrowserApplication,
                      );
                    },
                  ),
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
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
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