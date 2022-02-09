import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/app/widgets/badge_notification.dart';
import 'package:mapalus/shared/theme.dart';

class CardOrdersPeak extends StatelessWidget {
  const CardOrdersPeak({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 200.w,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Material(
              color: Palette.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18.sp),
                topLeft: Radius.circular(18.sp),
                topRight: Radius.circular(18.sp),
              ),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: onPressed,
                child: Padding(
                  padding: EdgeInsets.all(Insets.small.sp),
                  child: Row(
                    children: [
                      SizedBox(width: 3.w),
                      SvgPicture.asset(
                        "assets/vectors/bag.svg",
                        color: Palette.textPrimary,
                        height: 18.sp,
                        width: 18.sp,
                      ),
                      SizedBox(width: Insets.small.w * .75),
                      Text(
                        'Pesanan anda',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Palette.textPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                      ),
                      SizedBox(width: 3.w),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 9.h,
            child: const BadgeNotification(text: '99'),
          ),
        ],
      ),
    );
  }
}