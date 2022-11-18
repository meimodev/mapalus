import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/orders/orders_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order.dart';

import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';

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
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: controller.isNoOrderLayoutVisible.isTrue
                              ? _buildNoOrderLayout(context)
                              : Obx(
                                  () => ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.orders.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          OrderApp order =
                                          controller.orders.elementAt(index);
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
          ),
        ],
      ),
    );
  }

  _buildNoOrderLayout(BuildContext context) {
    return Center(
      child: Text(
        'Sedang tidak memiliki pesanan -_-',
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Palette.accent,
              fontSize: 14.sp,
            ),
      ),
    );
  }
}
