import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/order_detail/order_detail_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order_detail_item.dart';
import 'package:mapalus/app/widgets/dialog_rating.dart';
import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

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
              color: BaseColor.accent,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: BaseSize.h24,
            child: Column(
              children: [
                Obx(
                  () => CardNavigation(
                    title:
                        'Rincian Pesanan #${controller.order.value.id}',
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
              horizontal: BaseSize.w12,
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
                    productPrice: po.totalPrice.formatNumberToCurrency(),
                    index: (index + 1).toString(),
                    productWeight: '${po.quantity} ${po.product.unit}',
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.sp),
            color: BaseColor.cardBackground1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: BaseSize.h12,
                  bottom: BaseSize.h12,
                  left: BaseSize.w24,
                  right: BaseSize.w24,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => _buildDeliveryStateCard(
                            context: context,
                            title: 'Dipesan',
                            timeStamp: controller.order.value.lastUpdate.toString()
                                // .format(pattern: 'EEE, dd MMMM HH:mm'),
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
                    SizedBox(height: BaseSize.h24),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: BaseSize.h12 * .5,
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: BaseColor.accent,
                        ),
                      )),
                      child: _buildDeliveryInfoLayout(
                        context,
                      ),
                    ),
                    SizedBox(height: BaseSize.h6),
                    controller.order.value.payment.id.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: BaseSize.h6,
                            ),
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: BaseColor.accent,
                              ),
                            )),
                            child: _buildPaymentInfoLayout(context),
                          )
                        : const SizedBox(),
                    SizedBox(height: BaseSize.h12),
                    controller.order.value.note.isNotEmpty
                        ? _BuildNoteCard(note: controller.order.value.note)
                        : const SizedBox(),
                    SizedBox(height: BaseSize.h12),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Produk",
                        "controller.order.value.orderInfo.productCountF",
                        "controller.order.value.orderInfo.productPriceF",
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Pengantaran",
                        null,
                        "controller.order.value.orderInfo.deliveryPriceF",
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => _buildRowItem(
                        context,
                        "Total Pembayaran",
                        null,
                        "controller.order.value.orderInfo.totalPriceF",
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
                  rating: controller.rating,
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
        color: BaseColor.primary3,
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
              "controller.order.value.orderInfo.deliveryTime",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        Material(
          color: BaseColor.primary3,
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          borderRadius: BorderRadius.circular(6.sp),
          child: InkWell(
            onTap: controller.onPressedViewMaps,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: BaseSize.w12 * .75,
                vertical: BaseSize.h12 * .75,
              ),
              child: Center(
                child: Icon(
                  Icons.place,
                  color: BaseColor.accent,
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
              "controller.order.value.paymentMethodF",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            controller.order.value.payment.id == "CASHLESS"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Konfirmasi dengan admin untuk transfer manual",
                        style: TextStyle(
                          fontSize: 7.sp,
                          color: BaseColor.primaryText,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: BaseSize.h6),
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
                          SizedBox(height: BaseSize.h6),
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
            vertical: BaseSize.h12,
            horizontal: BaseSize.w24,
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
            vertical: BaseSize.h12,
            horizontal: BaseSize.w24,
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
          color: BaseColor.primary3,
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
                vertical: BaseSize.h12,
                horizontal: BaseSize.w24,
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
        return _BuildRatedLayout(rating: controller.rating!);
      case OrderStatus.canceled:
        // TODO: Handle this case.
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
          horizontal: BaseSize.w12,
          vertical: BaseSize.h6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.sp),
          color: BaseColor.accent,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 9.sp,
                color: BaseColor.editable,
              ),
            ),
            Text(
              timeStamp,
              style: TextStyle(
                fontSize: 9.sp,
                color: BaseColor.editable,
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
        left: BaseSize.w24 * 4,
        right: BaseSize.w24 * 4,
        bottom: BaseSize.h12,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade400,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: BaseSize.w12,
              vertical: BaseSize.h12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: BaseColor.negative.withOpacity(.5),
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
  const _BuildRejectedLayout({required this.order});

  final OrderApp order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: BaseSize.h24,
      ),
      child: Column(
        children: [
          Text(
            'Pesanan telah dibatalkan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: BaseColor.negative,
            ),
          ),
          Text(
            order.lastUpdate.EEEEddMMMyyyy,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: BaseColor.negative,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildRatedLayout extends StatelessWidget {
  const _BuildRatedLayout({
    required this.rating,
  });

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: BaseSize.h24,
        top: BaseSize.h6,
      ),
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: rating.rate.toDouble(),
            minRating: rating.rate.toDouble(),
            maxRating: rating.rate.toDouble(),
            direction: Axis.horizontal,
            itemCount: 5,
            glowColor: BaseColor.editable.withOpacity(.25),
            itemSize: 27.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
            onRatingUpdate: (_) {},
            itemBuilder: (_, int index) => SvgPicture.asset(
              'assets/vectors/star.svg',
              colorFilter: const ColorFilter.mode(
                BaseColor.primary3,
                BlendMode.srcIn,
              ),
            ),
            updateOnDrag: false,
            ignoreGestures: true,
            unratedColor: BaseColor.accent,
          ),
          SizedBox(height: BaseSize.h6),
          Text(
            'Dinilai ${rating.createdAt.toStringFormatted( "dd MMMM yyyy")}',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: BaseSize.h6),
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
    required this.note,
  });

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: BaseColor.editable,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w12,
        vertical: BaseSize.h12,
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
              colorClickableText: BaseColor.primary3,
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
