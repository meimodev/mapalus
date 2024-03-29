import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardOrderDetailItem extends StatelessWidget {
  const CardOrderDetailItem({
    Key? key,
    required this.index,
    required this.productName,
    required this.productPrice,
    required this.productWeight,
  }) : super(key: key);

  final String index;
  final String productName;
  final String productPrice;
  final String productWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: Insets.small.h,
      ),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: PaletteTheme.cardForeground,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
            child: Center(
              child: Text(
                index,
                style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    _buildWeightAndPriceCard(context, productPrice),
                    SizedBox(width: 6.w),
                    _buildWeightAndPriceCard(context, productWeight),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildWeightAndPriceCard(
    BuildContext context,
    String text,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 3.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.sp),
          color: PaletteTheme.editable,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
              ),
        ),
      );
}