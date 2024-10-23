import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

import 'widgets/widgets.dart';

class OrderSummaryScreen extends GetView<OrderSummaryController> {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      backgroundColor: BaseColor.white,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(
            title: 'Ringkasan Pesanan',
            isInverted: false,
          ),
          Expanded(
            child: Obx(
              () => LoadingWrapper(
                loading: controller.selectionLoading.value,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: BaseSize.w24,
                    vertical: BaseSize.h12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap.h24,
                          CardOrderSummaryItemWidget(
                            title: "Lokasi Pengantaran",
                            value: controller.deliveryLocation?.place ?? '',
                            onPressed: () async {
                              //pass the currently selected location if that is not available fallback to partner.location

                              Location? args;
                              if (controller.user?.partnerId != null) {
                                final partner =
                                    await controller.partnerRepo.getPartners(
                                  GetPartnerRequest(
                                    partnerId: controller
                                        .products.first.product.partnerId,
                                  ),
                                );
                                args = partner!.location;
                              }

                              if (controller.deliveryLocation != null) {
                                args = controller.deliveryLocation!;
                              }

                              final location = await Get.toNamed(
                                Routes.location,
                                arguments: args?.toJson(),
                              );

                              if (location != null) {
                                controller.onSelectedDeliveryLocation(
                                    location as Location);
                              }
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
                            value: controller.voucher?.code ?? "",
                            onPressed: () async {
                              await showDialogVoucherWidget(
                                context: context,
                                onValueSelected: controller.onSelectedVoucher,
                              );
                            },
                          ),
                          Gap.h24,
                          OrderSummaryCounterItemWidget(
                            title: 'Produk',
                            value: controller.products.isEmpty
                                ? ''
                                : controller.getProductPrices
                                    .formatNumberToCurrency(),
                            subTitle: "${controller.products.length} Produk",
                          ),
                          Gap.h4,
                          controller.deliveryLocation == null
                              ? const SizedBox()
                              : OrderSummaryCounterItemWidget(
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
                                  value:
                                      "- ${controller.getDiscountedValue.formatNumberToCurrency()}",
                                ),
                        ],
                      ),
                      Gap.h12,
                      Column(
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
                                  (controller.getTotal +
                                          controller.getDiscountedValue)
                                      .formatNumberToCurrency(),
                                  style: BaseTypography.caption.copyWith(
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                          OrderSummaryCounterItemWidget(
                            toBold: true,
                            title: 'Total Pembayaran',
                            value: controller.getTotal.formatNumberToCurrency(),
                          ),
                        ],
                      ),
                      Gap.h48,
                      ButtonMain(
                        title: "Buat Pesanan",
                        onPressed: () => controller.onPressedMakeOrder(),
                        enable: controller.enableMainButton.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
