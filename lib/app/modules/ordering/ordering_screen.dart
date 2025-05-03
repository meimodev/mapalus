import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/ordering/ordering_controller.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class OrderingScreen extends GetView<OrderingController> {
  const OrderingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTransfer =
        controller.order.payment.method == PaymentMethod.transfer;
    return ScreenWrapper(
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w24,
      ),
      child: Obx(
        () => LoadingWrapper(
          loading: controller.isLoading.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                'assets/vectors/order-received.svg',
                height: BaseSize.customWidth(120),
                width: BaseSize.customWidth(120),
              ),
              Gap.h24,
              Text(
                'Yey! Pesanan anda sudah masuk',
                style: BaseTypography.bodyLarge.toBold,
                textAlign: TextAlign.center,
              ),
              // if transaction using cashless then show payment instruction to confirm with admin WA
              Gap.h12,
              isTransfer
                  ? Column(
                      children: [
                        Text(
                          'Silahkan lakukan transfer sesuai arahan admin ya',
                          style: BaseTypography.bodyMedium.w300,
                          textAlign: TextAlign.center,
                        ),
                        Gap.h24,
                        ButtonWidget(
                          text: "Transfer",
                          textStyle: BaseTypography.bodyLarge.bold,
                          onPressed: controller.onPressedSeeOrder,
                        ),

                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          'Tunggu sebentar yaaaaa',
                          style: BaseTypography.bodyLarge.w300,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Andai akan segera dihubungi partner kami',
                          style: BaseTypography.bodyLarge.w300,
                          textAlign: TextAlign.center,
                        ),
                        Gap.h24,
                        ButtonMain(
                          title: "Lihat Pesanan",
                          onPressed: controller.onPressedSeeOrder,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
