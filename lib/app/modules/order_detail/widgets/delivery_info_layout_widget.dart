import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class DeliveryInfoLayoutWidget extends StatelessWidget {
  const DeliveryInfoLayoutWidget({
    super.key,
    required this.orderApp,
    required this.onPressedViewMap,
  });

  final OrderApp orderApp;

  final VoidCallback onPressedViewMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        orderApp.delivery == null
            ? const SizedBox()
            : Text(
                "PESANAN ANTAR - ${orderApp.delivery!.selectedTime.name.translate}",
                style: BaseTypography.titleLarge.bold,
                textAlign: TextAlign.center,
              ),
        Gap.h4,
        Container(
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderApp.delivery == null
                      ? const SizedBox()
                      : Text(
                          "${orderApp.delivery!.selectedTime.start.EEEEddMMM} "
                          "${orderApp.delivery!.selectedTime.start.HHmm}-"
                          "${orderApp.delivery!.selectedTime.end.HHmm}",
                          style: BaseTypography.titleLarge.w300,
                        ),
                  Text(
                    orderApp.orderBy.name,
                    style: BaseTypography.titleLarge.w300,
                  ),
                  SelectableText(
                    orderApp.orderBy.phone,
                    style: BaseTypography.titleLarge.toBold,
                  ),
                ],
              ),
              ButtonWidget(
                padding: EdgeInsets.symmetric(
                  horizontal: BaseSize.w6,
                  vertical: BaseSize.w6,
                ),
                size: BaseSize.customRadius(20),
                icon: Icons.place,
                onPressed: onPressedViewMap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
