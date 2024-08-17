import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardOrderSummaryItemWidget extends StatelessWidget {
  const CardOrderSummaryItemWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.value = '',
  });

  final String title;
  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(BaseSize.radiusSm),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: BaseColor.cardBackground1,
                width: BaseSize.customHeight(3),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: BaseTypography.bodyMedium.w400,
                        ),
                        Gap.w4,
                        value.isEmpty
                            ? const SizedBox()
                            : Icon(
                                Ionicons.checkmark_circle_outline,
                                size: BaseSize.w20,
                                color: BaseColor.primary3,
                              ),
                      ],
                    ),
                    value.isEmpty
                        ? const SizedBox()
                        : Text(
                            value,
                            style: BaseTypography.captionSmall.toSecondary,
                          ),
                  ],
                ),
              ),
              Gap.w12,
              Flexible(
                child: Text(
                  'Ubah $title',
                  textAlign: TextAlign.end,
                  style: BaseTypography.bodySmall.toPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
