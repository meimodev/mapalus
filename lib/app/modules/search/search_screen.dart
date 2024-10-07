// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

// import 'widgets/widgets.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: BaseSize.w12,
                  vertical: BaseSize.h12,
                ),
                color: BaseColor.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const BackButtonIcon(),
                    ),
                    Gap.w12,
                    Expanded(
                      child: CardSearchBar(
                        onChanged: controller.onChangedSearchText,
                        onSubmitted: controller.onSubmittedSearchText,
                        autoFocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              Gap.h12,
              Expanded(
                child: Obx(
                  () => LoadingWrapper(
                    loading: controller.loading.value,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: BaseSize.w12,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.products.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: BaseSize.customHeight(245),
                        crossAxisSpacing: BaseSize.w12,
                        mainAxisSpacing: BaseSize.h12,
                      ),
                      itemBuilder: (context, index) => CardProduct(
                        onPressed: print,
                        product: controller.products[index],
                      ),
                    ),
                  ),
                ),
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
