import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardItemSelectDeliveryTimeWidget extends StatelessWidget {
  const CardItemSelectDeliveryTimeWidget({
    super.key,
    required this.onPressed,
    required this.deliveryTime,
  });

  final void Function(DeliveryTime value, String title) onPressed;
  final DeliveryTime deliveryTime;

  @override
  Widget build(BuildContext context) {
    final bool available = deliveryTime.available && !deliveryTime.end.isPassed;
    final bool now = deliveryTime.id == "NOW";
    final String title = now
        ? "Diantar Sekarang"
        : "Jam ${deliveryTime.start.hour} - ${deliveryTime.end.hour}";
    String description;
    if (!deliveryTime.available) {
      description = "Jam Pengantaran Sedang Tidak Tersedia";
    } else if (deliveryTime.end.isPassed) {
      description = "Jam Pengantaran Sudah Lewat";
    } else {
      description = now
          ? "Langsung diantar saat pesanan selesai"
          : "Perkiraan tiba di tempat anda";
    }

    return Material(
      color: BaseColor.cardBackground1,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(BaseSize.radiusSm),
      child: InkWell(
        onTap: available
            ? () {
                onPressed(deliveryTime, title);
                Navigator.pop(context);
              }
            : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
