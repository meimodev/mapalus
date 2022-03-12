import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
      clipBehavior: Clip.hardEdge,
      elevation: 9,
      color: Palette.accent,
      borderRadius: BorderRadius.circular(30.sp),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 210.w,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Insets.small.w,
              horizontal: Insets.small.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   backgroundColor: Palette.primary,
                //   child: Padding(
                //     padding: EdgeInsets.all(9.sp),
                //     child: SvgPicture.asset(
                //       "assets/vectors/cart.svg",
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(9.sp),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.primary,
                  ),
                  child: SvgPicture.asset(
                    "assets/vectors/cart.svg",
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                SizedBox(width: Insets.small.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rp. 999.000.000',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Palette.cardForeground,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                    ),
                    Text(
                      '999 produk, 999.000 gram',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}