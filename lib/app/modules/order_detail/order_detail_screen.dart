import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/theme.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

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
                color: Palette.accent,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: CardNavigation(
                title: 'Rincian Pesanan #12345', isInverted: true),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Insets.medium.h * 4,
            child: Container(
              padding: EdgeInsets.all(Insets.small.sp),
              margin: EdgeInsets.symmetric(horizontal: Insets.medium.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.sp),
                color: Palette.cardForeground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildRowItem(
                          context,
                          "Jumlah produk",
                          "999.999 Produk",
                        ),
                        _buildRowItem(
                          context,
                          "Jumlah berat",
                          "999.999 Gram",
                        ),
                        _buildRowItem(
                          context,
                          "Total harga",
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
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Insets.small.h,
                          horizontal: Insets.medium.w,
                        ),
                        child: Center(
                          child: Text('Buat Pesanan'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildRowItem(BuildContext context, String title, String value,
      {bool highLight = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 90.w,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: highLight ? FontWeight.w600 : FontWeight.w300,
                ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(":"),
            SizedBox(width: 6.w),
            SizedBox(
              width: 90.w,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: highLight ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}