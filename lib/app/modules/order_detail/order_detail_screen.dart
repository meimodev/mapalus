import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/order_detail/order_detail_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order_detail_item.dart';
import 'package:mapalus/app/widgets/dialog_rating.dart';
import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

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
                    title:
                        'Rincian Pesanan #${controller.order.value.idMinified}',
                    isInverted: true,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: controller.isLoading.isTrue
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
                itemCount: controller.order.value.products.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  ProductOrder po =
                      controller.order.value.products.elementAt(index);
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
                  top: Insets.small.sp,
                  bottom: Insets.small.sp,
                  left: Insets.medium.w,
                  right: Insets.medium.w,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => _buildDeliveryStateCard(
                            context: context,
                            title: 'Dipesan',
                            timeStamp: controller.order.value.orderTimeStamp
                                .format(pattern:'EEE, dd MMMM HH:mm'),
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
                    controller.order.value.paymentMethod.isNotEmpty
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
                    controller.order.value.note.isNotEmpty
                        ? _BuildNoteCard(note: controller.order.value.note)
                        : const SizedBox(),
                    SizedBox(height: Insets.small.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Produk",
                        controller.order.value.orderInfo.productCountF,
                        controller.order.value.orderInfo.productPriceF,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Pengantaran",
                        null,
                        controller.order.value.orderInfo.deliveryPriceF,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Total Pembayaran",
                        null,
                        controller.order.value.orderInfo.totalPriceF,
                        highLight: true,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => _buildRatingLayout(
                  context,
                  orderStatus: controller.order.value.status,
                  rating: controller.order.value.rating,
                ),
              ),
              controller.order.value.status == OrderStatus.placed ||
                      controller.order.value.status == OrderStatus.accepted
                  ? _buildCancelOrderButton(
                      context,
                      controller.order.value,
                      controller.onPressedCancel,
                    )
                  : const SizedBox(),
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
              "Pengantaran",
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              controller.order.value.orderInfo.deliveryTime,
              style: TextStyle(
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
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              controller.order.value.paymentMethodF,
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            controller.order.value.paymentMethodF == "CASHLESS"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Konfirmasi dengan admin untuk transfer manual",
                        style: TextStyle(
                          fontSize: 7.sp,
                          color: Palette.textPrimary,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Insets.small.h * .5),
                          Text(
                            "BRI (Della Geovana Rey)",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                          ),
                          SelectableText(
                            "145801007894509",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: Insets.small.h * .5),
                          Text(
                            "Dana (Della Geovana Rey)",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                          ),
                          SelectableText(
                            "082293383305",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  _buildRatingLayout(
    BuildContext context, {
    required OrderStatus orderStatus,
    required Rating? rating,
  }) {
    switch (orderStatus) {
      case OrderStatus.placed:
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
      case OrderStatus.accepted:
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: Insets.small.sp,
            horizontal: Insets.medium.w,
          ),
          child: Column(
            children: [
              const Text(
                'Yay! Pesanan sudah diterima ☺',
              ),
              Text(
                'mohon menunggu pengantaran ya',
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        );
      case OrderStatus.rejected:
        return _BuildRejectedLayout(order: controller.order.value);

      case OrderStatus.delivered:
        return Material(
          color: Palette.primary,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(9.sp),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => DialogRating(
                  onPressedRate: (message, rate) {
                    controller
                        .onPressedRate(message, rate)
                        .then((value) => Navigator.pop(context));
                  },
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
                  'Nilai layanan',
                ),
              ),
            ),
          ),
        );
      case OrderStatus.finished:
        return _BuildRatedLayout(order: controller.order.value);
    }
  }

  _buildRowItem(
    BuildContext context,
    String title,
    String? sub,
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
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                highLight
                    ? const SizedBox()
                    : sub == null
                        ? const SizedBox()
                        : Text(
                            sub,
                            style: TextStyle(
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
              style: TextStyle(
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
              style: TextStyle(
                fontSize: 9.sp,
                color: Palette.editable,
              ),
            ),
            Text(
              timeStamp,
              style: TextStyle(
                fontSize: 9.sp,
                color: Palette.editable,
              ),
            ),
          ],
        ),
      );

  _buildCancelOrderButton(
    BuildContext context,
    OrderApp value,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: Insets.medium.sp * 4,
        right: Insets.medium.sp * 4,
        bottom: Insets.small.sp,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade400,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(Insets.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Palette.negative.withOpacity(.5),
                  size: 21.sp,
                ),
                const SizedBox(width: 3),
                Text(
                  "Batalkan Pesanan",
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildRejectedLayout extends StatelessWidget {
  const _BuildRejectedLayout({Key? key, required this.order}) : super(key: key);

  final OrderApp order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Insets.medium.h,
      ),
      child: Column(
        children: [
          Text(
            'Pesanan telah dibatalkan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Palette.negative,
            ),
          ),
          Text(
            order.confirmTimeStamp?.format(pattern:"EEE, dd MMMM yyyy") ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Palette.negative,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildRatedLayout extends StatelessWidget {
  const _BuildRatedLayout({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderApp order;

  @override
  Widget build(BuildContext context) {
    final rating = order.rating ?? Rating.zero();
    return Container(
      margin: EdgeInsets.only(
        bottom: Insets.medium.h,
        top: Insets.small.h * .5,
      ),
      child: Column(
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
              colorFilter: const ColorFilter.mode(
                Palette.primary,
                BlendMode.srcIn,
              ),
            ),
            updateOnDrag: false,
            ignoreGestures: true,
            unratedColor: Palette.accent,
          ),
          SizedBox(height: Insets.small.h * .5),
          Text(
            'Dinilai ${order.finishTimeStamp?.format(pattern:"dd MMMM yyyy") ?? '-'}',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: Insets.small.h * .5),
          Text(
            " \"${rating.message}\" ",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildNoteCard extends StatelessWidget {
  const _BuildNoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: Palette.editable,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.small.sp,
        vertical: Insets.small.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.edit_note_rounded, size: 15.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: ReadMoreText(
              '$note  ',
              trimLines: 1,
              colorClickableText: Palette.primary,
              trimMode: TrimMode.Line,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.sp,
              ),
              delimiter: "  . . .  ",
              delimiterStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
