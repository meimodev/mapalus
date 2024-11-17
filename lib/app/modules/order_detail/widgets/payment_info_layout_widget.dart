import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class PaymentInfoLayoutWidget extends StatelessWidget {
  const PaymentInfoLayoutWidget({super.key, required this.paymentMethod});

  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: BaseSize.h12,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: BaseColor.accent,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pembayaran",
                style: BaseTypography.bodySmall,
              ),
              Text(
                paymentMethod,
                style: BaseTypography.caption.toBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
