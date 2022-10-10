import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/modules/order_detail/order_detail_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order_detail_item.dart';
import 'package:mapalus/app/widgets/dialog_rating.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/rating.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
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
              color: Palette.accent,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: Insets.medium.h,
            child: Column(
              children: [
                Obx(
                  () => CardNavigation(
                    title: 'Rincian Pesanan #${controller.id.value}',
                    isInverted: true,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: controller.canLoading.isTrue
                          ? _buildLoadingLayout(context)
                          : _buildMainLayout(context),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildMainLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: Insets.medium.w * .5,
            ),
            child: Obx(
              () => ListView.builder(
                itemCount: controller.productOrders.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  ProductOrder po = controller.productOrders.elementAt(index);
                  return CardOrderDetailItem(
                    productName: po.product.name,
                    productPrice: po.totalPriceString,
                    index: (index + 1).toString(),
                    productWeight: '${po.quantityString} ${po.product.unit}',
                  );
                },
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
                        Obx(
                          () => _buildDeliveryStateCard(
                            context: context,
                            title: 'Dipesan',
                            timeStamp: controller.orderTime.value,
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        // Expanded(
                        //   flex: 4,
                        //   child: Obx(
                        //     () => _buildDeliveryStateCard(
                        //       context: context,
                        //       title: 'Selesai',
                        //       timeStamp: controller.finishTimeStamp.value,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: Insets.medium.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Insets.small.h * .5,
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Palette.accent,
                        ),
                      )),
                      child: _buildDeliveryInfoLayout(
                        context,
                      ),
                    ),
                    SizedBox(height: Insets.small.h * .5),
                    controller.paymentMethod.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: Insets.small.h * .5,
                            ),
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Palette.accent,
                              ),
                            )),
                            child: _buildPaymentInfoLayout(context),
                          )
                        : const SizedBox(),
                    SizedBox(height: Insets.small.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Produk",
                        controller.productCount.value,
                        controller.productTotal.value,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Pengantaran",
                        controller.deliveryCount.value,
                        controller.deliveryTotal.value,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Total Pembayaran",
                        '',
                        controller.totalPrice.value,
                        highLight: true,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => _buildRatingLayout(
                  context,
                  orderStatus: controller.orderStatus.value,
                  orderRating: controller.orderRating.value,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildLoadingLayout(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Palette.primary,
      ),
    );
  }

  _buildDeliveryInfoLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Waktu Pengantaran",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            Text(
              controller.deliveryTime.value,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 12.sp,
                  ),
            ),

          ],
        ),
        Material(
          color: Palette.primary,
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          borderRadius: BorderRadius.circular(6.sp),
          child: InkWell(
            onTap: controller.onPressedViewMaps,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Insets.small.w * .75,
                vertical: Insets.small.h * .75,
              ),
              child: Center(
                child: Icon(
                  Icons.place,
                  color: Palette.accent,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildPaymentInfoLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pembayaran",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            Text(
              controller.paymentMethod.value,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 12.sp,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  _buildRatingLayout(
    BuildContext context, {
    required String orderStatus,
    required Rating orderRating,
  }) {
    if (orderStatus == OrderStatus.placed.name) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Insets.small.h,
          horizontal: Insets.medium.w,
        ),
        child: const Center(
          child: Text(
            'Menunggu Konfirmasi Partner',
          ),
        ),
      );
    }

    if (orderStatus == OrderStatus.rejected.name) {
      return const _BuildCancelLayout();
    }

    if (orderStatus == OrderStatus.accepted.name) {
      return Material(
        color: Palette.primary,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(9.sp),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => DialogRating(
                onPressedRate: controller.onPressedRate,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Insets.small.h,
              horizontal: Insets.medium.w,
            ),
            child: const Center(
              child: Text(
                'Selesaikan',
              ),
            ),
          ),
        ),
      );
    }

    if (orderStatus == OrderStatus.finished.name) {
      return _BuildRatedLayout(rating: orderRating);
    }
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
          horizontal: Insets.small.w,
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

class _BuildCancelLayout extends StatelessWidget {
  const _BuildCancelLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Insets.medium.h,
      ),
      child: Text(
        'Pesanan telah dibatalkan',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 14.sp,
              color: Palette.negative.withOpacity(.75),
            ),
      ),
    );
  }
}

class _BuildRatedLayout extends StatelessWidget {
  const _BuildRatedLayout({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    final isFinishedByPartner = rating.message.toLowerCase() == "from partner";

    return Container(
      margin: EdgeInsets.only(
        bottom: Insets.medium.h,
        top: Insets.small.h * .5,
      ),
      child: isFinishedByPartner
          ? _buildFinishedByPartnerLayout(context)
          : Column(
              children: [
                RatingBar.builder(
                  initialRating: rating.number.toDouble(),
                  minRating: rating.number.toDouble(),
                  maxRating: rating.number.toDouble(),
                  direction: Axis.horizontal,
                  itemCount: 5,
                  glowColor: Palette.editable.withOpacity(.25),
                  itemSize: 27.sp,
                  itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                  onRatingUpdate: (_) {},
                  itemBuilder: (_, int index) => SvgPicture.asset(
                    'assets/vectors/star.svg',
                    color: Palette.primary,
                  ),
                  updateOnDrag: false,
                  ignoreGestures: true,
                  unratedColor: Palette.accent,
                ),
                SizedBox(height: Insets.small.h * .5),
                Text(
                  'Dinilai ${rating.ratingTimeStamp.format("dd MMMM yyyy HH:mm")}',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                SizedBox(height: Insets.small.h * .5),
                Text(
                  " \"${rating.message}\" ",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ],
            ),
    );
  }

  _buildFinishedByPartnerLayout(BuildContext context) {
    return Column(
      children: [
        Text(
          'pesanan selesai',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
        ),
        Text(
          rating.ratingTimeStamp.format("dd MMMM yyyy HH:mm"),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
              ),
        ),
      ],
    );
  }
}
