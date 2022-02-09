import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/app/widgets/badge_notification.dart';
import 'package:mapalus/shared/theme.dart';

class CardCartPeak extends StatelessWidget {
  const CardCartPeak({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 9,
      color: Palette.accent,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(14.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      const SizedBox(
                        width: 45,
                        height: 45,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: 42.sp,
                          height: 42.sp,
                          padding: EdgeInsets.all(9.sp),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.primary,
                          ),
                          child: SvgPicture.asset(
                            "assets/vectors/cart.svg",
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        top: 0,
                        child: BadgeNotification(text: "99"),
                      )
                    ],
                  ),
                  SizedBox(width: 7.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Very Recent Product Name ',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Palette.cardForeground,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp,
                            ),
                      ),
                      Text(
                        '999.000 gram',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Palette.cardForeground,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(width: 7.w),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 1.w,
                    height: 48.h,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Text(
                    'Rp. 99.000.000',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Palette.cardForeground,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}