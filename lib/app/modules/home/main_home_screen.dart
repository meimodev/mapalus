import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus/app/modules/home/widgets/widgets.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/shared/model/screen.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class MainHomeScreen extends GetView<MainHomeController> {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Screen> screens = [
      Screen(
        title: "Home",
        widget: const HomeScreen(),
        activeIconData: Ionicons.home,
        iconData: Ionicons.home_outline,
      ),
      Screen(
        title: "Promo",
        widget: const PromoScreen(),
        activeIconData: Ionicons.pricetag,
        iconData: Ionicons.pricetag_outline,
      ),
      Screen(
        title: "Order",
        widget: const OrderScreen(),
        activeIconData: Ionicons.cart,
        iconData: Ionicons.cart_outline,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: PopScope(
          onPopInvokedWithResult: (_, _) {
            DateTime now = DateTime.now();
            if (controller.currentBackPressTime == null ||
                now.difference(controller.currentBackPressTime!) >
                    const Duration(seconds: 2)) {
              controller.currentBackPressTime = now;
              Fluttertoast.showToast(
                backgroundColor: BaseColor.primary3,
                textColor: BaseColor.accent,
                msg: "Tekan lagi untuk keluar",
              );
              return;
            }
            Navigator.pop(context);
          },
          canPop: false,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  allowImplicitScrolling: false,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  children: screens.map((e) => e.widget).toList(),
                ),
              ),
              BottomNavBar(
                activeIndex: 0,
                onPressed: controller.navigateTo,
                screens: screens,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
