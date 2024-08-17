import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/app/widgets/loading_wrapper.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

import 'widgets/widgets.dart';

class OrderSummaryScreen extends GetView<OrderSummaryController> {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(
            title: 'Ringkasan Pesanan',
            isInverted: false,
          ),
          Expanded(
            child: Container(
              color: BaseColor.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: BaseSize.w24,
                  vertical: BaseSize.h12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => LoadingWrapper(
                        loading: controller.selectionLoading.value,
                        child: Column(
                          children: [
                            Gap.h24,
                            CardOrderSummaryItemWidget(
                              title: "Lokasi Pengantaran",
                              value: controller.deliveryLocation?.place ?? '',
                              onPressed: () async {
                                // await Get.toNamed(Routes.location);
                                controller.onSelectedDeliveryLocation();
                              },
                            ),
                            Gap.h12,
                            CardOrderSummaryItemWidget(
                              title: "Waktu Pengantaran",
                              onPressed: () async {
                                await showDialogDeliveryTimeWidget(
                                  context: context,
                                  onValueSelected:
                                      controller.onSelectedDeliveryTime,
                                );
                              },
                              value: controller.deliveryTimeText ?? '',
                            ),
                            Gap.h12,
                            CardOrderSummaryItemWidget(
                              title: "Pembayaran",
                              onPressed: () async {
                                await showDialogPaymentWidget(
                                  context: context,
                                  onValueSelected: controller.onSelectedPayment,
                                );
                              },
                              value: controller.paymentMethodText ?? "",
                            ),
                            Gap.h12,
                            CardOrderSummaryItemWidget(
                              title: "Voucher",
                              onPressed: () async {
                                await showDialogVoucherWidget(
                                  context: context,
                                  onValueSelected: controller.onSelectedVoucher,
                                );
                              },
                              value: controller.voucher?.code ?? "",
                            ),
                            Gap.h24,
                            OrderSummaryCounterItemWidget(
                              title: 'Produk',
                              value: controller.products.isEmpty
                                  ? ''
                                  : controller.getTotalPrices
                                      .formatNumberToCurrency(),
                              subTitle: "${controller.products.length} Produk",
                            ),
                            Gap.h4,
                            OrderSummaryCounterItemWidget(
                              title: 'Pengiriman',
                              value: controller.getDeliveryFee
                                  .formatNumberToCurrency(),
                            ),
                            Gap.h4,
                            controller.voucher == null
                                ? const SizedBox()
                                : OrderSummaryCounterItemWidget(
                                    toPrimary: true,
                                    title: 'Diskon',
                                    value: controller.getDiscountedValue
                                        .formatNumberToCurrency(),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Gap.h12,
                    Obx(
                      () => LoadingWrapper(
                        loading: controller.selectionLoading.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              color: BaseColor.primaryText,
                              height: 2,
                            ),
                            Gap.h8,
                            controller.voucher == null
                                ? const SizedBox()
                                : Text(
                                    "Rp. 100.000.000",
                                    style: BaseTypography.caption.copyWith(
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                            OrderSummaryCounterItemWidget(
                              toBold: true,
                              title: 'Total Pembayaran',
                              value: controller.getFinalTotal
                                  .formatNumberToCurrency(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap.h48,
                    Obx(
                      () => ButtonMain(
                        title: "Buat Pesanan",
                        onPressed: () {},
                        enable: controller.enableMainButton.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
