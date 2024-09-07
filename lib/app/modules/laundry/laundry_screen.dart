import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class LaundryScreen extends GetView<LaundryController> {
  const LaundryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BaseSize.w12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "MAPALUS",
              style: BaseTypography.displayLarge.bold.toPrimary,
            ),
            Gap.h12,
            Text(
              "Karena laundry punya orang, makanya tim mapalus perlu waktu untuk belajar dlu ya bro",
              textAlign: TextAlign.center,
              style: BaseTypography.displaySmall,
            ),
            Gap.h24,
            Text(
              "Tunggu layanan antar jemput laundry langsung dari aplikasi ya guys yaaaaa",
              textAlign: TextAlign.center,
              style: BaseTypography.displaySmall,
            ),
            Gap.h48,
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}
