import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/theme.dart';

class OrderingScreen extends StatelessWidget {
  const OrderingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Insets.small.w * 2.4),
                  child: SvgPicture.asset(
                    'assets/vectors/order-received.svg',
                    height: 120.sp,
                    width: 120.sp,
                  ),
                ),
                SizedBox(height: Insets.medium.h),
                Text(
                  'Pesanan Diterima',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14.sp,
                      ),
                ),
                SizedBox(height: Insets.small.h),
                Text(
                  'Anda akan segera dihubungi \nsaat waktu pengantaran nanti',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                SizedBox(height: Insets.medium.h * 1.5),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: Insets.medium.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(9.sp),
                  color: Palette.primary,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      var nav = Navigator.of(context);
                      nav.pop();
                      nav.pop();
                      nav.pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.medium,
                        vertical: Insets.small.w,
                      ),
                      child: Center(
                        child: Text(
                          'Kembali',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}