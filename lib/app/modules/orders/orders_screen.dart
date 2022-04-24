import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/orders/orders_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/theme.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({Key? key}) : super(key: key);

  //TODO improve this shitty list implementation with infinite scrolling

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(title: 'Riwayat Pesanan'),
          Expanded(
            child: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Palette.primary,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.medium.w,
                        ),
                        child: Obx(
                          () => ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              Order order = controller.orders.elementAt(index);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Insets.small.h * .5,
                                ),
                                child: CardOrder(
                                  order: order,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.orderDetail,
                                      arguments: order,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}