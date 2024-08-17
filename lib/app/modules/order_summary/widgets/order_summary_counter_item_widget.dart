import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class OrderSummaryCounterItemWidget extends StatelessWidget {
  const OrderSummaryCounterItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.subTitle,
    this.toPrimary = false,
    this.toBold = false,
  });

  final String title;
  final String? subTitle;
  final String value;
  final bool toPrimary;
  final bool toBold;

  @override
  Widget build(BuildContext context) {
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
                style: BaseTypography.bodyMedium.copyWith(
                  fontWeight: toBold ? FontWeight.bold : FontWeight.w400,
                  color: toPrimary ? BaseColor.primary3 : BaseColor.primaryText,
                ),
              ),
              subTitle != null
                  ? Text(
                subTitle!,
                style: BaseTypography.captionSmall.copyWith(
                  fontWeight: toBold ? FontWeight.bold : FontWeight.w400,
                  color: toPrimary
                      ? BaseColor.primary3
                      : BaseColor.secondaryText,
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: BaseTypography.bodyMedium.copyWith(
              fontWeight: toBold ? FontWeight.bold : FontWeight.w400,
              color: toPrimary ? BaseColor.primary3 : BaseColor.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}
