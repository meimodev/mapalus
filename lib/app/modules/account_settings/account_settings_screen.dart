import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/theme.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CardNavigation(title: 'Tentang Akun'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Insets.medium.h),
                  Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.accent,
                    ),
                  ),
                  SizedBox(height: Insets.small.h),
                  const Text('Jhon Manembo'),
                  const Text('+62 812 1234 1234'),
                ],
              ),
              SizedBox(height: Insets.medium.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
                child: Column(
                  children: [
                    _buildItemRow(
                      assetLocation: 'assets/vectors/edit.svg',
                      text: 'Sunting Informasi Akun',
                      context: context,
                      onPressed: () {},
                    ),
                    _buildItemRow(
                      assetLocation: 'assets/vectors/bag.svg',
                      text: 'Pesanan Anda',
                      context: context,
                      onPressed: () {},
                    ),
                    _buildItemRow(
                      assetLocation: 'assets/vectors/exit.svg',
                      text: 'Keluar',
                      context: context,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: Insets.small.h),
              Container(
                height: 2.h,
                width: 100.w,
                margin: EdgeInsets.symmetric(
                  horizontal: Insets.medium.w,
                ),
                color: Palette.accent,
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: Insets.small.h),
                  Text(
                    'mapalus v.1.2.441',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp,
                        ),
                  ),
                  Text(
                    'www.meimodev.com',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        'with ♥ 2022 ',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp,
                            ),
                      ),
                      SvgPicture.asset(
                        'assets/images/logo_meimo.svg',
                        width: 15.sp,
                        height: 15.sp,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow({
    required String assetLocation,
    required String text,
    required BuildContext context,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 45.h,
          child: Row(
            children: [
              SizedBox(
                width: 30.sp,
                child: SvgPicture.asset(
                  assetLocation,
                  width: 18.sp,
                  height: 18.sp,
                ),
              ),
              SizedBox(width: Insets.small.w * .5),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14.sp,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}