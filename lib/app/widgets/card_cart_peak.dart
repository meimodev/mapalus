import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardCartPeak extends StatelessWidget {
  const CardCartPeak({
    super.key,
    required this.onPressed,
    // required this.productOrders,
    required this.totalPrice,
    required this.totalProduct,
  });

  final VoidCallback onPressed;
  final double totalPrice;
  final int totalProduct;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: BaseColor.accent,
      borderRadius: BorderRadius.circular(BaseSize.radiusLg),
      child: InkWell(
        onTap: onPressed,
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
                      "$totalProduct",
                      style: BaseTypography.bodyMedium.toWhite,
                    ),
                    Gap.w12,
                    const Icon(
                      Ionicons.file_tray_stacked_outline,
                      color: BaseColor.white,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
