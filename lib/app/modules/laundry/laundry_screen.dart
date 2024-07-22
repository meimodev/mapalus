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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Laundry Screen")
          ],
        ),
      ),
    );
  }
}
