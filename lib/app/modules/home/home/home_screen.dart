import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus/app/modules/home/widgets/widgets.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: BaseSize.w24,
        ),
        child: Column(
          children: [
            Text(
              "Mapalus",
              style: BaseTypography.displayLarge.bold.toPrimary,
            ),
            Gap.h24,
            Obx(
              () => LoadingWrapper(
                loading: controller.loading.value,
                child: CardUserInfoWidget(
                  user: controller.user,
                  onPressed: () async {
                    if (controller.user == null) {
                      await Get.toNamed(Routes.signing);
                      return;
                    }

                    showSimpleConfirmationDialogWidget(
                      context: context,
                      action: "keluar dari akun ini",
                      onPressedPositive: controller.onPressedSignOut,
                    );
                  },
                ),
              ),
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
