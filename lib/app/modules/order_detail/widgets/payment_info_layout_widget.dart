import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class PaymentInfoLayoutWidget extends StatelessWidget {
  const PaymentInfoLayoutWidget({
    super.key,
    required this.paymentMethod,
    required this.onPressedSeeTransferStatus,
  });

  final PaymentMethod paymentMethod;
  final VoidCallback onPressedSeeTransferStatus;

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
                paymentMethod.name.toUpperCase(),
                style: BaseTypography.caption.toBold,
              ),
            ],
          ),
          paymentMethod == PaymentMethod.transfer
              ? ButtonWidget(
            text: "Check Transfer",
            backgroundColor: BaseColor.accent,
            textStyle: BaseTypography.bodySmall.toBold.toPrimary,
            onPressed: onPressedSeeTransferStatus,
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
