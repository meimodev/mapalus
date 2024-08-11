import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/app/widgets/widgets.dart';
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
          CustomScrollView(
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
                    print(partner.toString());
                  },
                ),
                separatorBuilder: (BuildContext context, int index) => Gap.w8,
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
                  onPressed: (Product product) {
                    print(product.toString());
                  },
                ),
                separatorBuilder: (BuildContext context, int index) => Gap.w8,
              ),
            ],
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
