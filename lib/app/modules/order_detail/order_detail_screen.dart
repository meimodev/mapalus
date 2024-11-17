import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/order_detail/order_detail_controller.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

import 'widgets/widgets.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: BaseColor.accent,
      child: Obx(
        () => LoadingWrapper(
          loading: controller.loading.value,
          child: Column(
            children: [
              NavigationBarCardWidget(
                order: controller.order,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Gap.h12,
                        itemCount: controller.order.products.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: BaseSize.w12,
                          vertical: BaseSize.h12,
                        ),
                        itemBuilder: (context, index) =>
                            CardOrderDetailItemProductWidget(
                          productOrder: controller.order.products[index],
                        ),
                      ),
                    ),
                    Gap.h24,
                    OrderDataCardWidget(
                      orderApp: controller.order,
                      onPressedViewMap: controller.onPressedViewMaps,
                      onPressedCancel: () {},
                      onPressedConfirm: () async {
                        final result = await showBottomSheetRate(
                          context: context,
                        );
                        if (result != null) {
                          controller.onRateOrder(result);
                        }
                      },
                    ),
                    Gap.h24,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
