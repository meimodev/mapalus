import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class GroceryScreen extends GetView<GroceryController> {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      backgroundColor: BaseColor.accent,
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "MAPALUS",
            style: BaseTypography.displayLarge.bold.toPrimary,
          ),
          Gap.h12,
          Text(
            "Yahhhhhh -_-",
            textAlign: TextAlign.center,
            style: BaseTypography.displaySmall.toCardBackground1,
          ),
          Gap.h12,
          Text(
            "Jasa ini sedang dalam pengembangan",
            textAlign: TextAlign.center,
            style: BaseTypography.displaySmall.toCardBackground1,
          ),
          Gap.h48,
          Text(
            "Kami akan kembali dengan layanan yang lebih baik lagi",
            textAlign: TextAlign.center,
            style: BaseTypography.displaySmall.toCardBackground1.toBold,
          ),
          Gap.h48,
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back"),
          )
        ],
      ),
    );

    // return ScreenWrapper(
    //   child: Stack(
    //     children: [
    //       CustomScrollView(
    //         // physics: const BouncingScrollPhysics(),
    //         controller: controller.scrollControllerMain,
    //         slivers: [
    //           _buildListAppBar(
    //             context: context,
    //             isSearching: controller.isSearchingProduct.value,
    //           ),
    //           SliverPadding(padding: EdgeInsets.all(Insets.small.sp)),
    //           _buildMainLoading(context),
    //           _buildListLoading(),
    //           SliverPadding(
    //               padding:
    //                   EdgeInsets.symmetric(vertical: Insets.medium.sp * 3)),
    //         ],
    //       ),
    //       Positioned(
    //         bottom: 110.h,
    //         right: 12.w,
    //         child: Obx(
    //           () => AnimatedSwitcher(
    //             duration: 300.milliseconds,
    //             child: controller.isCardOrderVisible.value
    //                 ? CardOrdersPeak(
    //                     onPressed: controller.onPressedLatestOrder,
    //                   )
    //                 : const SizedBox(),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 20.h,
    //         left: 0.w,
    //         right: 0.w,
    //         child: Obx(
    //           () => AnimatedSwitcher(
    //             duration: 300.milliseconds,
    //             child: controller.isCardCartVisible.value
    //                 ? Center(
    //                     child: Obx(
    //                       () => CardCartPeak(
    //                         // productOrders: controller.productOrders.value,
    //                         onPressed: controller.onPressedCart,
    //                         totalPrice: controller.totalPrice.value,
    //                         cartOverview: controller.cartOverview.value,
    //                       ),
    //                     ),
    //                   )
    //                 : const SizedBox(),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

// _buildMainLoading(BuildContext context) {
//   return SliverToBoxAdapter(
//     child: Obx(
//       () => AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: controller.canLoadingMain.isTrue
//             ? SizedBox(
//                 height: 500.h,
//                 child: const Center(
//                   child: CircularProgressIndicator(
//                     color: BaseColor.primary,
//                   ),
//                 ),
//               )
//             : _buildListProduct(context),
//       ),
//     ),
//   );
// }
//
// _buildListProduct(BuildContext context) {
//   return Column(
//     children: [
//       ListView.builder(
//         addAutomaticKeepAlives: true,
//         shrinkWrap: true,
//         itemBuilder: (_, index) => _buildProductCard(
//           index,
//           controller.displayProducts.value,
//         ),
//         primary: false,
//         itemCount: controller.displayProducts.length,
//         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         //   // maxCrossAxisExtent: 170.w,
//         //   crossAxisCount: 2,
//         //   crossAxisSpacing: 6.w,
//         //   mainAxisSpacing: 6.w,
//         //   mainAxisExtent: 250.h,
//         // ),
//       ),
//       _buildListFooter(context),
//     ],
//   );
// }
//
// _buildListFooter(BuildContext context) {
//   return Obx(
//     () => AnimatedSwitcher(
//       duration: const Duration(milliseconds: 400),
//       child: controller.isNoMoreProductsToDisplay.isTrue
//           ? Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: Insets.medium.h),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/images/mapalus.svg",
//                       width: 45.w,
//                       height: 45.h,
//                       colorFilter: const ColorFilter.mode(
//                         BaseColor.primary,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(height: Insets.small.h * .5),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SvgPicture.asset(
//                           "assets/images/logo_meimo.svg",
//                           width: 30.w,
//                         ),
//                         SizedBox(width: 3.w),
//                         Text(
//                           '©2022',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : const SizedBox(),
//     ),
//   );
// }
//
// _buildListLoading() {
//   return SliverToBoxAdapter(
//     child: Obx(
//       () => AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: controller.canLoadingProducts.isTrue
//             ? Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     top: Insets.large.h * 1.5,
//                     bottom: Insets.large.h * 2,
//                   ),
//                   child: const CircularProgressIndicator(
//                     color: BaseColor.primary,
//                   ),
//                 ),
//               )
//             : const SizedBox(),
//       ),
//     ),
//   );
// }
//
// _buildProductCard(int index, List<Product> products) {
//   return
//       // Padding(
//       // padding: EdgeInsets.only(
//       //   left: index % 2 == 0 ? Insets.medium.w : 0,
//       //   right: index % 2 == 0 ? 0 : Insets.medium.w,
//       // ),
//       // child:
//       CardProduct(
//     product: products[index],
//     onPressed: (product) {
//       Get.dialog(
//         DialogItemDetail(
//           product: product,
//           onPressedAddToCart: controller.onPressedAddToCart,
//         ),
//       );
//     },
//     // ),
//   );
// }
//
// _buildListAppBar({required context, isSearching = false}) {
//   return SliverAppBar(
//     title: Obx(
//       () => CardSearchBar(
//         controller: controller.tecSearch,
//         onSubmitted: controller.onSubmittedSearchText,
//         onTap: controller.onTapSearchText,
//         onLogoPressed: controller.onPressedLogo,
//         onChanged: controller.onChangedSearchText,
//         notificationBadgeCount: controller.unfinishedOrderCount.value,
//       ),
//     ),
//     collapsedHeight: 75.h,
//     expandedHeight: isSearching ? 75.h : 300.h,
//     forceElevated: true,
//     toolbarHeight: 75.h,
//     floating: true,
//     pinned: true,
//     snap: false,
//     backgroundColor: BaseColor.cardForeground,
//     elevation: 5,
//     shape: ContinuousRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         bottom: Radius.circular(Insets.large.sp),
//       ),
//     ),
//     flexibleSpace: isSearching
//         ? null
//         : FlexibleSpaceBar(
//             collapseMode: CollapseMode.parallax,
//             background: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: Insets.medium.w,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: 60.h),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         "Harga Pasar",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 36.sp,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                       Text(
//                         "Antar di rumah",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 36.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: Insets.small.h),
//                   Obx(
//                     () => _BuildCardCategories(
//                       onPressedCategories: controller.onPressedCategories,
//                       categories: controller.categories.value,
//                     ),
//                   ),
//                   SizedBox(height: Insets.small.h),
//                 ],
//               ),
//             ),
//           ),
//   );
// }
}

// class _BuildCardCategories extends StatelessWidget {
//   const _BuildCardCategories({
//     required this.onPressedCategories,
//     required this.categories,
//   });
//
//   final Function(Category) onPressedCategories;
//   final List<Category> categories;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           for (var category in categories)
//             CardCategory(
//               imageUrl: category.imageUrl,
//               asset: category.asset,
//               name: category.name,
//               onPressed: () {
//                 onPressedCategories(category);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
