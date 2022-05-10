import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/app/widgets/card_category.dart';
import 'package:mapalus/app/widgets/card_order_peak.dart';
import 'package:mapalus/app/widgets/card_product.dart';
import 'package:mapalus/app/widgets/card_cart_peak.dart';
import 'package:mapalus/app/widgets/dialog_item_detail.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/app/widgets/card_search_bar.dart';
import 'package:mapalus/data/models/category.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollControllerMain,
            slivers: [
              _buildListAppBar(
                context: context,
                isSearching: controller.isSearchingProduct.value,
              ),
              SliverPadding(padding: EdgeInsets.all(Insets.small.sp)),
              _buildListProduct(),
              _buildListLoading(),
              _buildListFooter(context),
              SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: Insets.medium.sp * 3)),
            ],
          ),
          Positioned(
            bottom: 110.h,
            right: 12.w,
            child: Obx(
              () => AnimatedSwitcher(
                duration: 300.milliseconds,
                child: controller.isCardOrderVisible.value
                    ? CardOrdersPeak(
                        onPressed: controller.onPressedLatestOrder,
                      )
                    : const SizedBox(),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 0.w,
            right: 0.w,
            child: Obx(
              () => AnimatedSwitcher(
                duration: 300.milliseconds,
                child: controller.isCardCartVisible.value
                    ? Center(
                        child: Obx(
                          () => CardCartPeak(
                            // productOrders: controller.productOrders.value,
                            onPressed: controller.onPressedCart,
                            totalPrice: controller.totalPrice.value,
                            cartOverview: controller.cartOverview.value,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index, List<Product> products) {
    return Padding(
      padding: EdgeInsets.only(
        left: index % 2 == 0 ? Insets.medium.w : 0,
        right: index % 2 == 0 ? 0 : Insets.medium.w,
      ),
      child: CardProduct(
        product: products[index],
        onPressed: (product) {
          Get.dialog(
            DialogItemDetail(
              product: product,
              onPressedAddToCart: controller.onPressedAddToCart,
            ),
          );
        },
      ),
    );
  }

  _buildListFooter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: controller.isNoMoreProductsToDisplay.isTrue
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Insets.medium.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/mapalus.svg",
                          color: Palette.primary,
                          width: 45.w,
                          height: 45.h,
                        ),
                        SizedBox(height: Insets.small.h * .5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/images/logo_meimo.svg",
                              width: 30.w,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              '©2022',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  _buildListLoading() {
    return SliverToBoxAdapter(
      child: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: controller.isLoadingProducts.isTrue
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Insets.large.h * 1.5,
                      bottom: Insets.large.h * 2,
                    ),
                    child: const CircularProgressIndicator(
                      color: Palette.primary,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  _buildListProduct() {
    return SliverToBoxAdapter(
      child: Obx(
        () => GridView.builder(
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          itemBuilder: (_, index) => _buildProductCard(
            index,
            controller.displayProducts.value,
          ),
          primary: false,
          itemCount: controller.displayProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // maxCrossAxisExtent: 170.w,
            crossAxisCount: 2,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 6.w,
            mainAxisExtent: 250.h,
          ),
        ),
      ),
    );
  }

  _buildListAppBar({required context, isSearching = false}) {
    return SliverAppBar(
      title: Obx(
        () => CardSearchBar(
          controller: controller.tecSearch,
          onSubmitted: controller.onSubmittedSearchText,
          onTap: controller.onTapSearchText,
          onLogoPressed: controller.onPressedLogo,
          onChanged: controller.onChangedSearchText,
          notificationBadgeCount: controller.unfinishedOrderCount.value,
        ),
      ),
      collapsedHeight: 75.h,
      expandedHeight: isSearching ? 75.h : 300.h,
      forceElevated: true,
      toolbarHeight: 75.h,
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor: Palette.cardForeground,
      elevation: 5,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Insets.large.sp),
        ),
      ),
      flexibleSpace: isSearching
          ? null
          : FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.medium.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 60.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Harga Pasar",
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        Text(
                          "Antar di rumah",
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(height: Insets.small.h),
                    _BuildCardCategories(
                      onPressedCategories: controller.onPressedCategories,
                      categories: controller.categories,
                    ),
                    SizedBox(height: Insets.small.h),
                  ],
                ),
              ),
            ),
    );
  }
}

class _BuildCardCategories extends StatelessWidget {
  const _BuildCardCategories({
    Key? key,
    required this.onPressedCategories,
    required this.categories,
  }) : super(key: key);

  final Function(Category) onPressedCategories;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var category in categories)
            CardCategory(
              imageUrl: category.imageUrl,
              name: category.name,
              onPressed: () {
                onPressedCategories(category);
              },
            ),
        ],
      ),
    );
  }
}