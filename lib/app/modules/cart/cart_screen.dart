// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/card_cart_item.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/theme.dart';

import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        children: [
          const CardNavigation(title: 'Keranjang Belanja', isInverted: true),
          Expanded(
            child: Container(
                color: Palette.accent,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.productOrders.value.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Obx(
                    () => CardCartItem(
                      index: index,
                      productOrder: controller.productOrders.value[index],
                      onPressedDelete: controller.onPressedItemDelete,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Insets.medium.h * 2,
                  right: Insets.medium.h * 2,
                  top: Insets.small.h,
                ),
                child: Obx(
                  () => Column(
                    children: [
                      _buildRowItem(
                        context,
                        "Jumlah produk",
                        controller.count.value,
                      ),
                      _buildRowItem(
                        context,
                        "Jumlah berat",
                        controller.weight.value,
                      ),
                      _buildRowItem(
                        context,
                        "Total harga",
                        controller.price.value,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.medium.w,
                  vertical: Insets.small.h,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(9.sp),
                  clipBehavior: Clip.hardEdge,
                  color: Palette.primary,
                  elevation: 4,
                  child: InkWell(
                    onTap: controller.onPressedSetDelivery,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.medium.w,
                        vertical: Insets.small.h,
                      ),
                      child: Center(
                        child: Text(
                          'Atur Pengantaran',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildRowItem(
    BuildContext context,
    String title,
    String value,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
          ),
          Text(
            value,
            // textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      );
}