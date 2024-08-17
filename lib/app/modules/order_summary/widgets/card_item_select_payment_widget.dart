import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardItemSelectPaymentWidget extends StatelessWidget {
  const CardItemSelectPaymentWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.iconData,
    this.available = true,
    this.note,
  });

  final VoidCallback onPressed;
  final bool available;
  final String title;
  final String description;
  final String? note;

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BaseColor.cardBackground1,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(BaseSize.radiusSm),
      child: InkWell(
        onTap: available ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                size: BaseSize.w24,
                weight: 2,
                color:
                    available ? BaseColor.primaryText : BaseColor.secondaryText,
              ),
              Gap.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: BaseTypography.bodyMedium.toBold.copyWith(
                        color: available
                            ? BaseColor.primaryText
                            : BaseColor.secondaryText,
                      ),
                    ),
                    Text(
                      description,
                      style: BaseTypography.captionSmall.copyWith(
                        color: available
                            ? BaseColor.primaryText
                            : BaseColor.secondaryText,
                      ),
                    ),
                    note == null
                        ? const SizedBox()
                        : Text(
                            note!,
                            style: BaseTypography.captionSmall.copyWith(
                              color: available
                                  ? BaseColor.primary3
                                  : BaseColor.secondaryText,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
