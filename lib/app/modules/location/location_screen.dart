import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/location/location_controller.dart';
import 'package:mapalus/app/widgets/card_delivery_fee.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/google_map_wrapper.dart';
import 'package:mapalus/app/widgets/payment_method_selection_card.dart';
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
                onMapCreated: controller.onMapCreated,
              ),
            ),
            // Center(
            //   child: Container(
            //     width: 3,
            //     height: 3,
            //     color: Colors.red,
            //   ),
            // ),
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
                                                elevation: 5,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.sp),
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.sp,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      SizedBox(height: Insets.small.h),
                                      Icon(
                                        Icons.location_on,
                                        color: Palette.primary,
                                        size: 40.sp,
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
                              child: _buildBody(context),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: Insets.small.h,
              child: CardNavigation(
                title: '',
                onPressedBack: () async {
                  if (await controller.onPressedBackButton()) {
                    Navigator.pop(context);
                  }
                },
                isInverted: true,
                isCircular: true,
              ),
            ),
            Positioned(
              top: 28.h,
              left: 8.w,
              right: 8.w,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: controller.isLocationNoteEnabled.isTrue
                      ? SizedBox(
                          width: 180.w,
                          child: _BuildCurrentLocationErrorNote(
                            onTap: controller.onPressedLocationErrorNote,
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: Insets.medium.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.sp),
          color: Palette.cardForeground,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: controller.isLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.large.h),
                  child: const CircularProgressIndicator(
                    color: Palette.primary,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(
                            () => _BuildDeliveryFeeSelector(
                              deliveries: controller.deliveries,
                              weight: controller.weight.value,
                              distance: controller.distance.value,
                              onPressedDeliveryTime:
                                  controller.onPressedChangeDeliveryTime,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Insets.small.w,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Insets.small.w,
                                      right: Insets.small.w * .5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Lokasi',
                                            ),
                                            SizedBox(width: 6.w),
                                            SvgPicture.asset(
                                              'assets/vectors/check.svg',
                                              width: 15.sp,
                                              height: 15.sp,
                                              color: Palette.accent,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Lokasi pengantaran telah dipilih",
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Material(
                                  child: InkWell(
                                    onTap: controller.onPressedChangeLocation,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Insets.small.h),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Insets.small.w,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Insets.small.w,
                                      right: Insets.small.w * .5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Pembayaran',
                                            ),
                                            Obx(
                                              () => controller
                                                      .paymentMethodSubTittle
                                                      .isNotEmpty
                                                  ? Row(
                                                      children: [
                                                        SizedBox(width: 6.w),
                                                        SvgPicture.asset(
                                                          'assets/vectors/check.svg',
                                                          width: 15.sp,
                                                          height: 15.sp,
                                                          color: Palette.accent,
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                            ),
                                          ],
                                        ),
                                        controller.paymentMethodSubTittle.value
                                                .isEmpty
                                            ? const SizedBox()
                                            : Text(
                                                controller
                                                    .paymentMethodSubTittle
                                                    .value,
                                                style: TextStyle(
                                                  fontSize: 9.sp,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Material(
                                  child: InkWell(
                                    onTap: () =>
                                        _showPaymentMethodBottomSheet(context),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Insets.small.h,
                                        horizontal: Insets.small.w,
                                      ),
                                      child: Text(
                                        'Ubah Pembayaran',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontSize: 10.sp,
                                              color: Palette.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Insets.small.h),
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
                        ],
                      ),
                    ),
                    Material(
                      color: controller.paymentMethodSubTittle.isEmpty
                          ? Palette.accent.withAlpha(50)
                          : Palette.primary,
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(9.sp),
                      child: InkWell(
                        onTap: () {
                          if (controller.paymentMethodSubTittle.isEmpty) {
                            _showPaymentMethodBottomSheet(context);
                            return;
                          }
                          controller.onPressedMakeOrder();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Insets.small.h,
                            horizontal: Insets.medium.w,
                          ),
                          child: Obx(
                            () => Center(
                              child: controller.paymentMethodSubTittle.isEmpty
                                  ? const Text("Pilih Pembayaran")
                                  : const Text('Buat Pesanan'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );

  _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _BuildPaymentMethodBottomSheet(
        totalPrice: controller.orderInfo.value.totalPrice.toInt(),
        moneyAmount: controller.paymentMoneyAmount,
        selectedPaymentIndex: controller.paymentSelectedIndex,
        onPressedPaymentMethodButton: (
          int selectedPaymentIndex,
          String message,
          int? amount,
        ) {
          controller.paymentMethodSubTittle.value = message;
          controller.paymentMoneyAmount = amount;
          controller.paymentSelectedIndex = selectedPaymentIndex;
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _BuildPaymentMethodBottomSheet extends StatefulWidget {
  const _BuildPaymentMethodBottomSheet({
    Key? key,
    required this.onPressedPaymentMethodButton,
    required this.totalPrice,
    this.selectedPaymentIndex,
    this.moneyAmount,
  }) : super(key: key);

  final void Function(
    int selectedPaymentIndex,
    String message,
    int? moneyAmount,
  ) onPressedPaymentMethodButton;
  final int totalPrice;
  final int? selectedPaymentIndex;
  final int? moneyAmount;

  @override
  State<_BuildPaymentMethodBottomSheet> createState() =>
      _BuildPaymentMethodBottomSheetState();
}

class _BuildPaymentMethodBottomSheetState
    extends State<_BuildPaymentMethodBottomSheet> {
  String moneyAmountText = "";
  TextEditingController tecMoneyAmount = TextEditingController();
  String moneyAmountErrorText = "";

  int selectedIndex = 0;

  @override
  void dispose() {
    tecMoneyAmount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedPaymentIndex ?? 0;
    if (widget.moneyAmount != null) {
      tecMoneyAmount.text = widget.moneyAmount!.toString();
    }
  }

  void onSubmitPaymentBottomSheetSelectionCard() {
    if (selectedIndex == 0) {
      setState(() {
        moneyAmountErrorText = "";
      });
      final amountText = tecMoneyAmount.text;
      if (amountText.isEmpty) {
        setState(() {
          moneyAmountErrorText = "Jumlah uang tidak boleh kosong";
        });
      }
      if (amountText.startsWith("0")) {
        setState(() {
          moneyAmountErrorText = "Awalan angka dimulai dari 1 - 9";
        });
      }
      final amount = int.tryParse(amountText);
      if (amount == null) {
        //set error text for moneyAmount text field
        setState(() {
          moneyAmountErrorText = "Hanya gunakan angka 0 - 9";
        });
        return;
      }

      if (amount < widget.totalPrice) {
        setState(() {
          moneyAmountErrorText = "Jumlah uang tidak mencukupi total pembayaran";
        });
        return;
      }
      widget.onPressedPaymentMethodButton(
          0,
          "Bayar ditempat (COD) ${Utils.formatNumberToCurrency(amount)}",
          amount);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => Padding(
        padding: EdgeInsets.all(Insets.medium.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  PaymentMethodSelectionCard(
                    title: 'Bayar di tempat',
                    subTitle: "Cash on Delivery (COD)",
                    onPressed: () {
                      setState(() {
                        selectedIndex == 0;
                      });
                    },
                    activate: selectedIndex == 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: Insets.small.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Insets.small.w,
                              vertical: Insets.small.h * .5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Palette.positive.withAlpha(50),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: Colors.grey,
                              ),
                              children: const [
                                TextSpan(text: "Silahkan masukkan"),
                                TextSpan(
                                  text: " jumlah uang ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimary,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        "yang akan dibayar, untuk mempercepat proses pembayaran di tempat"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Insets.small.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.small.w,
                                vertical: 2.w,
                              ),
                              decoration: BoxDecoration(
                                color: Palette.editable,
                                borderRadius: BorderRadius.circular(9.sp),
                              ),
                              child: SizedBox(
                                width: 150.w,
                                child: TextField(
                                  controller: tecMoneyAmount,
                                  maxLines: 1,
                                  onSubmitted: (_) =>
                                      onSubmitPaymentBottomSheetSelectionCard(),
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Palette.accent,
                                    fontFamily: fontFamily,
                                    fontSize: 12.sp,
                                  ),
                                  cursorColor: Palette.primary,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 12.sp,
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.textPrimary,
                                    ),
                                    isDense: true,
                                    border: InputBorder.none,
                                    labelText: "Jumlah uang",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Insets.small.w),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Total Pembayaran",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      Utils.formatNumberToCurrency(
                                          widget.totalPrice),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Palette.textPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedSwitcher(
                          duration: 400.milliseconds,
                          child: moneyAmountErrorText.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: Insets.small.w,
                                    right: Insets.small.w,
                                    top: Insets.small.h * .25,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      moneyAmountErrorText,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Palette.negative,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  PaymentMethodSelectionCard(
                    title: "Gopay",
                    subTitle: "Coming soon",
                    onPressed: () {},
                    available: false,
                  ),
                  PaymentMethodSelectionCard(
                    title: "Shopee Pay",
                    subTitle: "Coming soon",
                    onPressed: () {},
                    available: false,
                  ),
                  PaymentMethodSelectionCard(
                    title: "BCA Virtual Account",
                    subTitle: "Coming soon",
                    onPressed: () {},
                    available: false,
                  ),
                  PaymentMethodSelectionCard(
                    title: "Transfer bank BRI",
                    subTitle: "Coming soon",
                    onPressed: () {},
                    available: false,
                  ),
                  PaymentMethodSelectionCard(
                    title: "Transfer bank BNI",
                    subTitle: "Coming soon",
                    onPressed: () {},
                    available: false,
                  ),
                  PaymentMethodSelectionCard(
                    title: "Transfer bank BCA",
                    subTitle: "Coming soon",
                    onPressed: () {},
                    available: false,
                  ),
                ],
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(Insets.small.w),
              color: Palette.primary,
              child: InkWell(
                onTap: onSubmitPaymentBottomSheetSelectionCard,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.small.h),
                  child: const Center(child: Text("Pilih Pembayaran")),
                ),
              ),
            )
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

    //select the initial selection for delivery time
    for (int i = 0; i < widget.deliveries.length; i++) {
      DeliveryInfo deliveryInfo = widget.deliveries[i];
      if (deliveryInfo.isAvailable) {
        widget.onPressedDeliveryTime(
          deliveryInfo,
          Utils.formatCurrencyToNumber(
            deliveryInfo.price(
              distance: widget.distance,
              weight: widget.weight,
            ),
          ),
        );
        setState(() {
          activeIndex = deliveryInfo.id;
        });
        break;
      }
    }
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
              deliveryInfo: delivery,
              isActive: activeIndex == delivery.id,
              price: delivery.price(
                distance: widget.distance,
                weight: widget.weight,
              ),
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
          // sub: orderInfo.deliveryWeightF,
          sub: '',
          value: orderInfo.deliveryPriceF,
        ),
        SizedBox(height: 3.h),
        _buildOrderInfoRowItem(
          context: context,
          title: "Total Pembayaran",
          sub: '',
          value: orderInfo.totalPriceF,
          highLight: true,
        ),
      ],
    );
  }

  _buildOrderInfoRowItem({
    required context,
    required title,
    required String sub,
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
                  : sub.isEmpty
                      ? const SizedBox()
                      : Text(
                          sub,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
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

class _BuildCurrentLocationErrorNote extends StatelessWidget {
  const _BuildCurrentLocationErrorNote({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.accent.withOpacity(.75),
      borderRadius: BorderRadius.circular(Insets.medium),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.medium.w * .5,
            vertical: Insets.small.h * .5,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Palette.primary,
              ),
              SizedBox(width: 3.w),
              Text(
                "Lokasi Tidak diaktifkan",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Palette.primary,
                      fontSize: 12.sp,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
