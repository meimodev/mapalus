import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/orders/orders_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/shared/routes.dart';
// import 'package:mapalus/app/widgets/card_order.dart';

import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  //TODO improve this shitty list implementation with infinite scrolling

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(title: 'Riwayat Pesanan'),
          SizedBox(height: BaseSize.h12),
          Expanded(
            child: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: BaseColor.primary3,
                        ),
                      )
                    : Column(
                        children: [
                          _BuildOrderStateChipsLayout(
                            onChangedActiveIndex:
                                controller.onChangeFilterActiveIndex,
                          ),
                          Expanded(
                            child: Obx(
                              () => AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: controller.orders.isNotEmpty
                                    ? ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: controller.orders.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          OrderApp order =
                                              controller.orders[index];
                                          return CardOrder(
                                            order: order,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.orderDetail,
                                                arguments: order,
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : _buildNoOrderLayout(context),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoOrderLayout(BuildContext context) {
    return Center(
      child: Text(
        "Tidak ada pesanan -_-'",
        style: TextStyle(
          color: BaseColor.accent,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class _BuildOrderStateChipsLayout extends StatefulWidget {
  const _BuildOrderStateChipsLayout({
    required this.onChangedActiveIndex,
  });

  final Function(OrderStatus?) onChangedActiveIndex;

  @override
  State<_BuildOrderStateChipsLayout> createState() =>
      _BuildOrderStateChipsLayoutState();
}

class _BuildOrderStateChipsLayoutState
    extends State<_BuildOrderStateChipsLayout> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: BaseSize.w24),
        CustomChip(
          text: "diterima",
          active: activeIndex == 1,
          onPressed: () {
            setState(() {
              activeIndex = activeIndex == 1 ? 0 : 1;
            });
            if (activeIndex == 0) {
              widget.onChangedActiveIndex(null);
              return;
            }
            widget.onChangedActiveIndex(OrderStatus.accepted);
          },
        ),
        const SizedBox(width: 6),
        CustomChip(
          text: "ditolak",
          active: activeIndex == 2,
          onPressed: () {
            setState(() {
              activeIndex = activeIndex == 2 ? 0 : 2;
            });
            if (activeIndex == 0) {
              widget.onChangedActiveIndex(null);
              return;
            }
            widget.onChangedActiveIndex(OrderStatus.rejected);
          },
        ),
        const SizedBox(width: 6),
        CustomChip(
          text: "diantar",
          active: activeIndex == 3,
          onPressed: () {
            setState(() {
              activeIndex = activeIndex == 3 ? 0 : 3;
            });
            if (activeIndex == 0) {
              widget.onChangedActiveIndex(null);
              return;
            }
            widget.onChangedActiveIndex(OrderStatus.delivered);
          },
        ),
        const SizedBox(width: 6),
        CustomChip(
          text: "selesai",
          active: activeIndex == 4,
          onPressed: () {
            setState(() {
              activeIndex = activeIndex == 4 ? 0 : 4;
            });
            if (activeIndex == 0) {
              widget.onChangedActiveIndex(null);
              return;
            }
            widget.onChangedActiveIndex(OrderStatus.finished);
          },
        ),
      ],
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.onPressed,
    required this.text,
    this.active = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: active ? BaseColor.primary3 : BaseColor.cardBackground1,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: BaseColor.primary3,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12 * .75,
            vertical: BaseSize.h12 * .5,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? BaseColor.cardBackground1 : BaseColor.primary3,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
