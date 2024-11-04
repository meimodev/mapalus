import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardCartPeak extends StatelessWidget {
  const CardCartPeak({
    super.key,
    this.onPressed,
    required this.productOrders,
  });

  final VoidCallback? onPressed;
  final List<ProductOrder> productOrders;

  @override
  Widget build(BuildContext context) {
    final List<double> totalPrices = productOrders
        .map<double>((e) => e.product.price * e.quantity)
        .toList()
      ..add(0);

    final double totalPrice =
        totalPrices.reduce((value, element) => value + element);

    final int totalProduct = productOrders.length;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: productOrders.isEmpty
          ? const SizedBox()
          : Material(
              clipBehavior: Clip.hardEdge,
              color: BaseColor.accent,
              borderRadius: BorderRadius.circular(BaseSize.radiusLg),
              child: InkWell(
                onTap: () {
                  if (onPressed != null) {
                    onPressed!();
                    return;
                  }
                  Get.toNamed(Routes.cart);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    right: BaseSize.w24,
                    left: BaseSize.w24,
                    top: BaseSize.w12,
                    bottom: BaseSize.w12,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Ionicons.cart_outline,
                          color: BaseColor.primary3,
                          size: 20,
                        ),
                        Gap.w12,
                        Expanded(
                          child: Text(
                            totalPrice.formatNumberToCurrency(),
                            style: BaseTypography.bodyMedium.toBold.toWhite,
                          ),
                        ),
                        Gap.w12,
                        Container(
                          color: BaseColor.primary3,
                          width: 2,
                        ),
                        Gap.w12,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              totalProduct.toString(),
                              style: BaseTypography.bodyMedium.toWhite,
                            ),
                            Gap.w4,
                            // const Icon(
                            //   Ionicons.file_tray_stacked_outline,
                            //   color: BaseColor.white,
                            //   size: 20,
                            // ),
                            Text(
                              "Produk",
                              style: BaseTypography.bodySmall.toWhite,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
