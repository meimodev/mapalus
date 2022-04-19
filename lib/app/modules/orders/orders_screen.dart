import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/card_order.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/data/models/data_mock.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/theme.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final Order mockOrder = Order(
    orderingUser: UserApp(phone: '1234', name: 'ssss'),
    deliveryInfo: DeliveryInfo.fromJSON(DataMock.deliveries[0]),
    products: [
      ProductOrder(
        quantity: 2,
        totalPrice: 10000,
        product: Product.fromMap(DataMock.products[0]),
      )
    ],
    status: OrderStatus.values[Random().nextInt(OrderStatus.values.length)],
    orderInfo: OrderInfo(
      deliveryDistance: 2,
      productCount: 1,
      productPrice: 10000,
      deliveryWeight: 2000,
      deliveryPrice: 40000,
      deliveryCoordinate: const LatLng(123, 123),
    ),
  );

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
                  order: mockOrder,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.orderDetail);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}