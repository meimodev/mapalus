import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';


class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: Insets.medium,
          right: Insets.medium,
        ),
        child: Column(
          children: [
            Text("Promo Screen")
          ],
        ),
      ),
    );
  }
}


