import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardPartnerWidget extends StatelessWidget {
  const CardPartnerWidget({
    super.key,
    required this.onPressed,
    required this.partner,
  });

  final VoidCallback onPressed;
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(
        BaseSize.roundnessMedium,
      ),
      color: BaseColor.accent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: BaseSize.w32,
                  height: BaseSize.w32,
                  decoration: const BoxDecoration(
                    color: BaseColor.primary3,
                    shape: BoxShape.circle,
                  ),
                ),
                Gap.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        partner.name,
                        style: BaseTypography.bodySmall.toBold.toPrimary,
                      ),
                      Text(
                        partner.location?.place ?? "Somewhere around",
                        style: BaseTypography.labelSmall.toPrimary,
                      ),
                    ],
                  ),
                ),
                Gap.w12,
                const Icon(
                  Icons.chevron_right_outlined,
                  color: BaseColor.primary3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
