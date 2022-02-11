import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/app/widgets/card_cart_item.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Palette.accent,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15.w),
                ),
              ),
              child: ListView.builder(
                itemCount: 6,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => const CardCartItem(),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Insets.medium.w * 2,
                  right: Insets.medium.w * 2,
                  top: Insets.medium.h,
                  bottom: Insets.small.h,
                ),
                child: Column(
                  children: [
                    _buildRowItem(context, "Jumlah produk", "999.999 Produk"),
                    _buildRowItem(context, "Jumlah berat", "999.999 Gram"),
                    _buildRowItem(context, "Total harga", "Rp. 999.999.999"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.medium.w,
                  vertical: Insets.small.h,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(9.sp),
                  clipBehavior: Clip.hardEdge,
                  color: Palette.primary,
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.location);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.medium.w,
                        vertical: Insets.small.h,
                      ),
                      child: Center(
                        child: Text(
                          'Atur Pengantaran',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildRowItem(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ),
        Row(
          children: [
            const Text(":"),
            SizedBox(width: 6.w),
            SizedBox(
              width: 120.w,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}