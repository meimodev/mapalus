// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/card_cart_item.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

import 'cart_controller.dart';
import 'widgets/widgets.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const CardNavigation(
            title: 'Keranjang Belanja',
            isInverted: true,
          ),
          Expanded(
            child: Container(
              color: BaseColor.accent,
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.productOrders.value.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: BaseSize.w12,
                    vertical: BaseSize.h12,
                  ),
                  separatorBuilder: (context, index) => Gap.h12,
                  itemBuilder: (context, index) => CardCartItem(
                    index: index,
                    productOrder: controller.productOrders.value[index],
                    onPressedDelete: controller.onPressedItemDelete,
                    onChangedQuantity: controller.onChangedQuantity,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: BaseSize.w24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap.h12,
                CardNoteWidget(
                  note: controller.note.value,
                  onChangedNote: controller.onChangedNote,
                ),
                Gap.h12,
                Obx(
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
                Gap.h12,
                Material(
                  borderRadius: BorderRadius.circular(9.sp),
                  clipBehavior: Clip.hardEdge,
                  color: BaseColor.primary3,
                  elevation: 4,
                  child: InkWell(
                    onTap: controller.onPressedSetDelivery,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: BaseSize.w24,
                        vertical: BaseSize.h12,
                      ),
                      child: Center(
                        child: Text(
                          'Atur Pengantaran',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap.h24,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowItem(
    BuildContext context,
    String title,
    String value,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            value,
            // textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
}
