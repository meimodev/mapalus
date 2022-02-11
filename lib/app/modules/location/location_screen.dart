import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/card_delivery_fee.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/theme.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Palette.primary,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(9.sp),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.medium.w,
                        vertical: Insets.small.h,
                      ),
                      child: Text(
                        'Pilih Lokasi',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 14.sp,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Insets.small.h),
                SvgPicture.asset(
                  'assets/vectors/pin.svg',
                  width: 30.sp,
                  height: 45.sp,
                  color: Palette.accent,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Insets.medium.h,
            child: Container(
              padding: EdgeInsets.all(Insets.small.sp),
              margin: EdgeInsets.symmetric(horizontal: Insets.medium.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.sp),
                color: Palette.cardForeground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Waktu Pengantaran',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 12.sp,
                        ),
                  ),
                  SizedBox(height: Insets.small.h),
                  CardDeliveryFee(
                    onPressed: () {},
                    deliveryTime: 'Sekarang',
                    price: 'Rp. 100.000',
                  ),
                  SizedBox(height: Insets.small.h),
                  CardDeliveryFee(
                    onPressed: () {},
                    deliveryTime: 'Jam 7 - 8 Pagi',
                    price: 'Rp. 100.000',
                  ),
                  SizedBox(height: Insets.small.h),
                  CardDeliveryFee(
                    onPressed: () {},
                    deliveryTime: 'Jam 10 - 11 Siang',
                    price: 'Rp. 100.000',
                    isActive: true,
                  ),
                  SizedBox(height: Insets.small.h),
                  CardDeliveryFee(
                    onPressed: () {},
                    deliveryTime: 'Jam 2 - 3 Sore',
                    price: 'Rp. 100.000',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: Insets.medium.h,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Insets.medium.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.sp),
                color: Palette.cardForeground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Insets.medium.h,
                      bottom: Insets.small.h,
                      left: Insets.medium.w,
                      right: Insets.medium.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildRowItem(
                          context,
                          "Produk",
                          '999 Produk',
                          "Rp. 999.999.999",
                        ),
                        SizedBox(height: 3.h),
                        _buildRowItem(
                          context,
                          "Pengantaran",
                          '999.999 Kg',
                          "Rp. 100.000",
                        ),
                        SizedBox(height: 3.h),
                        _buildRowItem(
                          context,
                          "Total Pembayaran",
                          '',
                          "Rp. 999.999.999",
                          highLight: true,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Palette.primary,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(9.sp),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.ordering);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Insets.small.h,
                          horizontal: Insets.medium.w,
                        ),
                        child: const Center(
                          child: Text('Buat Pesanan'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildRowItem(
    BuildContext context,
    String title,
    String sub,
    String value, {
    bool highLight = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              highLight
                  ? const SizedBox()
                  : Text(
                      sub,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                    ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}