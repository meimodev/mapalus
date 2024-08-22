// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

// import 'widgets/widgets.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> result = List.generate(
      11,
      (index) => Product(
        name: "Product  $index",
        unit: ProductUnit.kilogram,
        price: 5000,
      ),
    );

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
                    const Expanded(
                      child: CardSearchBar(
                        onChanged: print,
                        onSubmitted: print,
                        autoFocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              Gap.h12,
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: BaseSize.w12,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: result.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: BaseSize.customHeight(245),
                    crossAxisSpacing: BaseSize.w12,
                    mainAxisSpacing: BaseSize.h12,
                  ),
                  itemBuilder: (context, index) => CardProduct(
                    onPressed: print,
                    product: result[index],
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
