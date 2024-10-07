import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/payment/payment_controller.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

///Not using this screen yet
class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      // backgroundColor: BaseColor.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardNavigation(
            title: 'Metode Pembayaran',
            isInverted: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: BaseSize.w24),
              shrinkWrap: true,
              children: [
                const Text("Bayar di tempat"),
                const Text("Cash on Delivery"),
                const Text("Gopay"),
                const Text("Shopee Pay"),
                const Text("BCA Virtual Account"),
                const Text("Transfer bank BRI"),
                const Text("Transfer bank BNI"),
                SizedBox(width: BaseSize.w12),
                const Text("Money Amount to prepare for changes"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(BaseSize.w24),
            child: Material(
              borderRadius: BorderRadius.circular(BaseSize.w12),
              color: BaseColor.primary3,
              child: InkWell(
                onTap: () {},
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(BaseSize.w12),
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
