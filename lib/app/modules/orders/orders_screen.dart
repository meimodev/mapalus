import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(title: 'Riwayat Pesanan'),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Insets.medium.w * .5, vertical: 9.h),
                child: CardOrder(
                  order: Order(
                    finishTimeStamp: 'Besok, 10:00 - 11:00',
                    products: [
                      ProductOrder(
                        quantity: 2,
                        totalPrice: 600000,
                        product: Product(
                          id: index,
                          name: "product $index",
                          description: 'description $index',
                          imageUrl: 'image $index',
                          price: 'Rp. 5.000',
                          unit: 'gram',
                          status: ProductStatus.available,
                        ),
                      )
                    ],
                    id: index,
                    orderTimeStamp: '10/01/2021 10:00',
                    status: OrderStatus
                        .values[Random().nextInt(OrderStatus.values.length)],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}