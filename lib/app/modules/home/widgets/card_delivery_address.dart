import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardDeliveryAddress extends StatelessWidget {
  const CardDeliveryAddress({
    super.key,
    required this.address,
    required this.onPressed,
  });

  final String address;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(BaseSize.roundnessSmall),
        side: const BorderSide(color: BaseColor.accent),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Alamat Pengiriman",
                      style: BaseTypography.titleLarge,
                    ),
                    Text(
                      address,
                      overflow: TextOverflow.ellipsis,
                      style: BaseTypography.titleLarge.copyWith(
                        color: BaseColor.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Gap.w12,
              const Icon(
                Ionicons.map_outline,
                color: BaseColor.primary3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
