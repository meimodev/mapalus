import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/payment/payment_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

///Not using this screen yet
class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      // backgroundColor: PaletteTheme.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(
            title: 'Metode Pembayaran',
            isInverted: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
              shrinkWrap: true,
              children: [
                const Text("Bayar di tempat"),
                const Text("Cash on Delivery"),
                const Text("Gopay"),
                const Text("Shopee Pay"),
                const Text("BCA Virtual Account"),
                const Text("Transfer bank BRI"),
                const Text("Transfer bank BNI"),
                SizedBox(width: Insets.small.h),
                const Text("Money Amount to prepare for changes"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all( Insets.medium.w),
            child: Material(
              borderRadius: BorderRadius.circular(Insets.small.w),
              color: PaletteTheme.primary,
              child: InkWell(
                onTap: (){},
                child: Center(child: Padding(
                  padding: EdgeInsets.all(Insets.small.w),
                  child: const Text("PESAN"),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
