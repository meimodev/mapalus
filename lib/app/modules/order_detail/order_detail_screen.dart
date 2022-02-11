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
            bottom: Insets.medium.h,
            child: Column(
              children: [
                const CardNavigation(
                  title: 'Rincian Pesanan #12345',
                  isInverted: true,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Insets.medium.w * .5,
                    ),
                    child: ListView.builder(
                      itemCount: 10,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => CardOrderDetailItem(
                        productName: 'Product ${index + 1}',
                        productPrice: 'Rp, 999.999.999',
                        index: (index + 1).toString(),
                        productWeight: '999.999 gram',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Insets.medium.w * .5,
                  ),
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
                          bottom: Insets.medium.h,
                          left: Insets.medium.w * .5,
                          right: Insets.medium.w * .5,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: _buildDeliveryStateCard(
                                    context: context,
                                    title: 'Dipesan',
                                    timeStamp: '22/02/2022 18:23',
                                  ),
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: _buildDeliveryStateCard(
                                    context: context,
                                    title: 'Diantar',
                                    timeStamp: '22/02/2022 19:00 = 20:00',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Insets.medium.h),
                            _buildRowItem(
                              context,
                              "Produk",
                              '999 Produk',
                              "Rp. 999.999.999",
                            ),
                            SizedBox(height: 6.h),
                            _buildRowItem(
                              context,
                              "Pengantaran",
                              '999.999 Kg',
                              "Rp. 100.000",
                            ),
                            SizedBox(height: 6.h),
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
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Insets.small.h,
                              horizontal: Insets.medium.w,
                            ),
                            child: Center(
                              child: Text(
                                'Selesaikan',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
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
  }) =>
      Row(
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
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                highLight
                    ? const SizedBox()
                    : Text(
                        sub,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 10.sp,
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
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      );

  _buildDeliveryStateCard({
    required BuildContext context,
    required String title,
    required String timeStamp,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.sp),
          color: Palette.accent,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 9.sp,
                    color: Palette.editable,
                  ),
            ),
            Text(
              timeStamp,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 9.sp,
                    color: Palette.editable,
                  ),
            ),
          ],
        ),
      );
}

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
        color: Palette.cardForeground,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
            child: Center(
              child: Text(
                index,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    _buildWeightAndPriceCard(context, productName),
                    SizedBox(width: 6.w),
                    _buildWeightAndPriceCard(context, productPrice),
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
          color: Palette.editable,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
              ),
        ),
      );
}