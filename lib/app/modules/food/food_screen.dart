// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/app/widgets/loading_wrapper.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

import 'widgets/widgets.dart';

class FoodScreen extends GetView<FoodController> {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Obx(
            () => LoadingWrapper(
              loading: controller.loading.value,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const FoodScreenAppBar(),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: BaseSize.h12,
                    ),
                  ),
                  SliverListViewSeparated<Partner>(
                    title: 'Best Partners in town',
                    list: controller.partners,
                    itemBuilder: (BuildContext context, item, int index) =>
                        CardPartner(
                      partner: item,
                      onPressed: (Partner partner) {
                        Get.toNamed(Routes.search, arguments: partner.id);
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Gap.w8,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: BaseSize.h24,
                    ),
                  ),
                  SliverListViewSeparated<Product>(
                    title: 'Legendary Products',
                    list: controller.products,
                    itemBuilder: (BuildContext context, item, int index) =>
                        CardProduct(
                      product: item,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Gap.w8,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: BaseSize.h36,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: BaseSize.h24,
            left: BaseSize.w24,
            right: BaseSize.w24,
            child: Obx(
              () => CardCartPeak(
                productOrders: controller.productOrders.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
