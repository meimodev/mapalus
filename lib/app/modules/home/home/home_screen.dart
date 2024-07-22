import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus/app/modules/home/widgets/widgets.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            Text(
              "Mapalus",
              style: BaseTypography.bodyMedium,
            ),
            Gap.h24,
            CardDeliveryAddress(
              address: 'Jln Gunung Agung, Rinegetan. Jakarta pusat',
              onPressed: () {},
            ),
            Gap.h24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardMenu(
                  title: "Food",
                  icon: const Icon(Ionicons.fast_food_outline),
                  onPressed: () => Get.toNamed(Routes.food),
                ),
                CardMenu(
                  title: "Groceries",
                  icon: const Icon(Ionicons.fish_outline),
                  onPressed: () => Get.toNamed(Routes.grocery),
                ),
                CardMenu(
                  title: "Laundry",
                  icon: const Icon(Ionicons.shirt_outline),
                  onPressed: () => Get.toNamed(Routes.laundry),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


