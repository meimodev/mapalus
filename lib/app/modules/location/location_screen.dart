import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/location/location_controller.dart';
import 'package:mapalus/app/widgets/card_delivery_fee.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/google_map_wrapper.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:mapalus/shared/utils.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: WillPopScope(
        onWillPop: controller.onPressedBackButton,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              left: 0,
              child: GoogleMapWrapper(
                onCameraIdle: controller.onCameraIdle,
              ),
            ),
            Center(
              child: Container(
                width: 3,
                height: 3,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // const Expanded(child: SizedBox()),
                        Obx(
                          () => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: controller.isLocationSelectionVisible.value
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedSwitcher(
                                        duration: 200.milliseconds,
                                        child: controller
                                                .isLocationSelectionButtonVisible
                                                .value
                                            ? Material(
                                                color: Palette.primary,
                                                clipBehavior: Clip.hardEdge,
                                                borderRadius:
                                                    BorderRadius.circular(9.sp),
                                                child: InkWell(
                                                  onTap: controller
                                                      .onPressedSelectLocation,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          Insets.medium.w,
                                                      vertical: Insets.small.h,
                                                    ),
                                                    child: Text(
                                                      'Pilih Lokasi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          ?.copyWith(
                                                            fontSize: 14.sp,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      SizedBox(height: Insets.small.h),
                                      SvgPicture.asset(
                                        'assets/vectors/pin.svg',
                                        width: 30.sp,
                                        height: 45.sp,
                                        color: Palette.accent,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: controller.isLocationSelectionVisible.value
                      ? const SizedBox()
                      : Stack(
                          children: [
                            Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  color: Colors.black.withOpacity(.80),
                                )),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: Insets.medium.h,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Insets.medium.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.sp),
                                  color: Palette.cardForeground,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Obx(
                                      () => _BuildDeliveryFeeSelector(
                                        deliveries: controller.deliveries,
                                        weight: controller.weight.value,
                                        distance: controller.distance.value,
                                        onPressedDeliveryTime: controller
                                            .onPressedChangeDeliveryTime,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Insets.small.w,
                                        vertical: Insets.small.h,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.symmetric(
                                          horizontal: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: Insets.small.w,
                                                    right: Insets.small.w * .5,
                                                  ),
                                                  child: Text(
                                                    'Lokasi Terpilih',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        ?.copyWith(
                                                          color: Palette
                                                              .textPrimary,
                                                        ),
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  'assets/vectors/check.svg',
                                                  width: 24.sp,
                                                  height: 24.sp,
                                                  color: Palette.accent,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Material(
                                            child: InkWell(
                                              onTap: controller
                                                  .onPressedChangeLocation,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: Insets.small.h,
                                                  horizontal: Insets.small.w,
                                                ),
                                                child: Text(
                                                  'Ubah Lokasi',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(
                                                        fontSize: 10.sp,
                                                        color: Palette.primary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: Insets.small.h,
                                        left: Insets.medium.w,
                                        right: Insets.medium.w,
                                      ),
                                      child: Obx(
                                        () => _BuildOrderInfo(
                                          orderInfo: controller.orderInfo.value,
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Palette.primary,
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(9.sp),
                                      child: InkWell(
                                        onTap: controller.onPressedMakeOrder,
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
                ),
              ),
            ),
            const Positioned(
              left: 0,
              top: 0,
              child: CardNavigation(
                title: '',
                isInverted: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildDeliveryFeeSelector extends StatefulWidget {
  const _BuildDeliveryFeeSelector({
    Key? key,
    required this.deliveries,
    required this.distance,
    required this.weight,
    required this.onPressedDeliveryTime,
  }) : super(key: key);

  final List<DeliveryInfo> deliveries;
  final double distance;
  final double weight;
  final Function(DeliveryInfo deliveryInfo, double price) onPressedDeliveryTime;

  @override
  State<_BuildDeliveryFeeSelector> createState() =>
      _BuildDeliveryFeeSelectorState();
}

class _BuildDeliveryFeeSelectorState extends State<_BuildDeliveryFeeSelector> {
  String activeIndex = "NOW";

  @override
  void initState() {
    super.initState();
    // print('buld deluvery selector');
    // print(widget.deliveries[0]);
    // print(widget.weight);
    // print(widget.distance);
    widget.onPressedDeliveryTime(
      widget.deliveries[0],
      Utils.formatCurrencyToNumber(
        widget.deliveries[0].price(
          distance: widget.distance,
          weight: widget.weight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Insets.small.sp),
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
          for (DeliveryInfo delivery in widget.deliveries) ...[
            SizedBox(height: Insets.small.h),
            CardDeliveryFee(
              deliveryTime: delivery.title,
              price: delivery.price(
                distance: widget.distance,
                weight: widget.weight,
              ),
              isTomorrow: !delivery.available,
              isActive: activeIndex == delivery.id,
              onPressed: () {
                setState(() {
                  activeIndex = delivery.id;
                });
                widget.onPressedDeliveryTime(
                  delivery,
                  Utils.formatCurrencyToNumber(
                    delivery.price(
                      distance: widget.distance,
                      weight: widget.weight,
                    ),
                  ),
                );
              },
            ),
          ]
          // SizedBox(height: Insets.small.h),
          // CardDeliveryFee(
          //   deliveryTime: 'Sekarang',
          //   price: 'Rp. 100.000',
          //   isActive: activeIndex == 0,
          //   onPressed: () {
          //     setState(() {
          //       activeIndex = 0;
          //     });
          //   },
          // ),
          // SizedBox(height: Insets.small.h),
          // CardDeliveryFee(
          //   deliveryTime: 'Jam 7 - 8 Pagi',
          //   price: 'Rp. 100.000',
          //   isActive: activeIndex == 1,
          //   onPressed: () {
          //     setState(() {
          //       activeIndex = 1;
          //     });
          //   },
          // ),
          // SizedBox(height: Insets.small.h),
          // CardDeliveryFee(
          //   deliveryTime: 'Jam 10 - 11 Siang',
          //   price: 'Rp. 100.000',
          //   isActive: activeIndex == 2,
          //   onPressed: () {
          //     setState(() {
          //       activeIndex = 2;
          //     });
          //   },
          // ),
          // SizedBox(height: Insets.small.h),
          // CardDeliveryFee(
          //   deliveryTime: 'Jam 2 - 3 Sore',
          //   price: 'Rp. 100.000',
          //   isActive: activeIndex == 3,
          //   isTomorrow: true,
          //   onPressed: () {
          //     setState(() {
          //       activeIndex = 3;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}

class _BuildOrderInfo extends StatelessWidget {
  const _BuildOrderInfo({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  final OrderInfo orderInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildOrderInfoRowItem(
          context: context,
          title: "Produk",
          sub: orderInfo.productCountF,
          value: orderInfo.productPriceF,
        ),
        SizedBox(height: 3.h),
        _buildOrderInfoRowItem(
          context: context,
          title: "Pengantaran",
          sub: orderInfo.deliveryWeightF,
          value: orderInfo.deliveryPriceF,
        ),
        SizedBox(height: 3.h),
        _buildOrderInfoRowItem(
          context: context,
          title: "Total Pembayaran",
          sub: '',
          value: orderInfo.totalPrice,
          highLight: true,
        ),
      ],
    );
  }

  _buildOrderInfoRowItem({
    required context,
    required title,
    required sub,
    required value,
    highLight = false,
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
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
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