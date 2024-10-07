import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "MAPALUS",
            textAlign: TextAlign.center,
            style: BaseTypography.displayLarge.bold.toPrimary,
          ),
          Text(
            "Halaman promonya lagi kita garap bosku",
            textAlign: TextAlign.center,
            style: BaseTypography.bodySmall,
          ),
          Gap.h48,
          Text(
            "Sabar yaaa",
            textAlign: TextAlign.center,
            style: BaseTypography.bodyMedium,
          )
        ],
      ),
    );
  }
}
