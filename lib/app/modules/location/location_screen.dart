import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/location/location_controller.dart';
import 'package:mapalus/app/widgets/card_delivery_fee.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/google_map_wrapper.dart';
import 'package:mapalus/app/widgets/payment_method_selection_card.dart';

import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      // child: WillPopScope(
      //   onWillPop: controller.onPressedBackButton,
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
              defaultPosition: controller.defaultPosition,
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
                                              color: BaseColor.primary3,
                                              clipBehavior: Clip.hardEdge,
                                              elevation: 5,
                                              borderRadius:
                                                  BorderRadius.circular(16.sp),
                                              child: InkWell(
                                                onTap: controller
                                                    .onPressedSelectLocation,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: BaseSize.w24,
                                                    vertical: BaseSize.h12,
                                                  ),
                                                  child: Text(
                                                    'Pilih Lokasi',
                                                    style: TextStyle(
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
                                    Gap.h12,
                                    Icon(
                                      Icons.location_on,
                                      color: BaseColor.primary3,
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
                            bottom: BaseSize.h24,
                            child: _buildBody(context),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: BaseSize.h12,
            child: CardNavigation(
              title: '',
              onPressedBack: () async {
                if (await controller.onPressedBackButton()) {
                  // ignore: use_build_context_synchronously
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
    );
  }

  _buildBody(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: BaseSize.w24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.sp),
          color: BaseColor.cardBackground1,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: controller.isLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: BaseSize.h48),
                  child: const CircularProgressIndicator(
                    color: BaseColor.primary3,
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
                              horizontal: BaseSize.w12,
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
                                      left: BaseSize.w12,
                                      right: BaseSize.w12 * .5,
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
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                BaseColor.accent,
                                                BlendMode.srcIn,
                                              ),
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
                                        vertical: BaseSize.h12,
                                        horizontal: BaseSize.w12,
                                      ),
                                      child: Text(
                                        'Ubah Lokasi',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: BaseColor.primary3,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap.h12,
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: BaseSize.w12,
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
                                      left: BaseSize.w12,
                                      right: BaseSize.w12 * .5,
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
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                            BaseColor.accent,
                                                            BlendMode.srcIn,
                                                          ),
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
                                        vertical: BaseSize.h12,
                                        horizontal: BaseSize.w12,
                                      ),
                                      child: Text(
                                        'Ubah Pembayaran',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: BaseColor.primary3,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap.h12,
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: BaseSize.h12,
                              left: BaseSize.h24,
                              right: BaseSize.h24,
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
                          ? BaseColor.accent.withAlpha(50)
                          : BaseColor.primary3,
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
                            vertical: BaseSize.h12,
                            horizontal: BaseSize.w24,
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
    required this.onPressedPaymentMethodButton,
    required this.totalPrice,
    this.selectedPaymentIndex,
    this.moneyAmount,
  });

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
      final moneyAmount = widget.moneyAmount!.toString();
      if (moneyAmount == "0") {
        tecMoneyAmount.text = "";
        return;
      }
      tecMoneyAmount.text = moneyAmount;
    }
  }

  void onSubmitPaymentBottomSheetSelectionCard() {
    if (selectedIndex == 0) {
      setState(() {
        moneyAmountErrorText = "";
      });

      final amountText = tecMoneyAmount.text;
      if (amountText.isEmpty || amountText == "0") {
        widget.onPressedPaymentMethodButton(
          0,
          "Bayar ditempat ${(0).formatNumberToCurrency()}",
          0,
        );
        return;
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
        "Bayar ditempat ${amount.formatNumberToCurrency()}",
        amount,
      );
      return;
    }
    if (selectedIndex == 1) {
      widget.onPressedPaymentMethodButton(
        1,
        "Transfer Manual",
        0,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => Padding(
        padding: EdgeInsets.all(BaseSize.w24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  widget.totalPrice.formatNumberToCurrency(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: BaseColor.primary3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap.h12,
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  PaymentMethodSelectionCard(
                    title: 'Bayar di tempat',
                    subTitle: "Cash on Delivery",
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    activate: selectedIndex == 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Gap.h12,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: BaseSize.w12,
                              vertical: BaseSize.h12 * .5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: BaseColor.primary3.withOpacity(.25),
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
                                    color: BaseColor.primary3,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        "yang akan dibayar, untuk mempermudah proses penukaran uang kembalian"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: BaseSize.h12 * .5),
                        Container(
                          decoration: BoxDecoration(
                            color: BaseColor.editable,
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
                                color: BaseColor.primary3,
                                fontFamily: fontFamily,
                                fontSize: 10.sp,
                              ),
                              cursorColor: BaseColor.primary3,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 10.sp,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w300,
                                  color: BaseColor.primary3,
                                ),
                                isDense: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: .25,
                                    color: BaseColor.accent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: .25,
                                    color: BaseColor.accent,
                                  ),
                                ),
                                labelText: "Jumlah uang",
                              ),
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: 400.milliseconds,
                          child: moneyAmountErrorText.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: BaseSize.w12,
                                    right: BaseSize.w12,
                                    top: BaseSize.h12 * .25,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      moneyAmountErrorText,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: BaseColor.negative,
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
                    title: 'Transfer Manual',
                    subTitle:
                        "Silahkan di transfer & lakukan konfirmasi ke admin",
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    activate: selectedIndex == 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: BaseSize.h12 * .5),
                        Text(
                          "BRI (Della Geovana Rey)",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "145801007894509",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: BaseSize.h12 * .5),
                        Text(
                          "Dana (Della Geovana Rey)",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "0822 9338 3305",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
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
              borderRadius: BorderRadius.circular(BaseSize.w12),
              color: BaseColor.primary3,
              child: InkWell(
                onTap: onSubmitPaymentBottomSheetSelectionCard,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: BaseSize.h12),
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
    required this.deliveries,
    required this.distance,
    required this.weight,
    required this.onPressedDeliveryTime,
  });

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
          deliveryInfo
              .price(
                distance: widget.distance,
                weight: widget.weight,
              )
              .formatCurrencyToNumber()
              .toDouble(),
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
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w12,
        vertical: BaseSize.h12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: BaseColor.cardBackground1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Waktu Pengantaran',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
          for (DeliveryInfo delivery in widget.deliveries) ...[
            Gap.h12,
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
                  delivery
                      .price(
                        distance: widget.distance,
                        weight: widget.weight,
                      )
                      .formatCurrencyToNumber()
                      .toDouble(),
                );
              },
            ),
          ]
          // Gap.h12,
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
          // Gap.h12,
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
          // Gap.h12,
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
          // Gap.h12,
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
    required this.orderInfo,
  });

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
                style: TextStyle(
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
                          style: TextStyle(
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
            style: TextStyle(
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
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BaseColor.accent.withOpacity(.75),
      borderRadius: BorderRadius.circular(BaseSize.radiusMd),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w24 * .5,
            vertical: BaseSize.h12 * .5,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: BaseColor.primary3,
              ),
              SizedBox(width: 3.w),
              Text(
                "Lokasi Tidak diaktifkan",
                style: TextStyle(
                  color: BaseColor.primary3,
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
