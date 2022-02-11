import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order_detail_item.dart';
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogRating();
                              },
                            );
                          },
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

class DialogRating extends StatelessWidget {
  const DialogRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 420.h,
        width: 300.w,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Palette.cardForeground,
          borderRadius: BorderRadius.circular(9.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Masukkan & Penilaian anda\nakan sangat membantu layanan ini',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 14.sp,
                  ),
            ),
            SizedBox(height: Insets.medium.h),
            Container(
              height: 210.h,
              margin: EdgeInsets.symmetric(horizontal: Insets.small.w),
              padding: EdgeInsets.symmetric(
                horizontal: 9.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.sp),
                color: Palette.editable,
              ),
              child: TextField(
                maxLines: 100,
                textAlign: TextAlign.start,
                enableSuggestions: false,
                scrollPhysics: const BouncingScrollPhysics(),
                autocorrect: false,
                style: TextStyle(
                  color: Palette.accent,
                  fontFamily: fontFamily,
                  fontSize: 14.sp,
                ),
                cursorColor: Palette.primary,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.sp,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Layanan ini akan lebih baik jika ...",
                ),
              ),
            ),
            SizedBox(height: Insets.small.h),
            SizedBox(
              width: 50.w,
              height: 50.h,
              child: Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  glowColor: Palette.editable.withOpacity(.25),
                  itemSize: 27.sp,
                  itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                  onRatingUpdate: (rating) {},
                  itemBuilder: (BuildContext context, int index) =>
                      SvgPicture.asset(
                    'assets/vectors/star.svg',
                    color: Palette.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: Insets.small.h),
            Material(
              color: Palette.primary,
              borderRadius: BorderRadius.circular(9.sp),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.small.w,
                    vertical: Insets.small.h,
                  ),
                  child: Center(
                    child: Text(
                      'Nilai',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}