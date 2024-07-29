import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardPartner extends StatelessWidget {
  const CardPartner({
    super.key,
    required this.onPressed,
    required this.partner,
  });

  final Partner partner;
  final Function(Partner partner) onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: BaseColor.white,
      borderRadius: BorderRadius.circular(BaseSize.radiusSm),
      child: InkWell(
        onTap: () => onPressed(partner),
        child: SizedBox(
          width: BaseSize.customWidth(120),
          child: Column(
            children: [
              Gap.h12,
              Container(
                decoration: const BoxDecoration(
                  color: BaseColor.secondaryText,
                  shape: BoxShape.circle,
                ),
                height: BaseSize.customHeight(120),
                // width: BaseSize.customWidth(160),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: BaseSize.w12,
                  vertical: BaseSize.h12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      partner.name,
                      style: BaseTypography.bodyMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${partner.location?.place}",
                      textAlign: TextAlign.center,
                      style: BaseTypography.bodyMedium.w300,
                      overflow: TextOverflow.ellipsis,
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
