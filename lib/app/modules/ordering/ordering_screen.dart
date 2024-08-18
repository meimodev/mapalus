import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/ordering/ordering_controller.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus/app/widgets/loading_wrapper.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderingScreen extends GetView<OrderingController> {
  const OrderingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                'assets/vectors/order-received.svg',
                height: BaseSize.customWidth(120),
                width: BaseSize.customWidth(120),
              ),
              Gap.h24,
              Text(
                'Pesanan Diterima',
                style: BaseTypography.bodyLarge.toBold,
                textAlign: TextAlign.center,
              ),
              Gap.h12,
              Text(
                'Tunggu sebentar yaaaaa',
                style: BaseTypography.bodyLarge.w300,
                textAlign: TextAlign.center,
              ),
              Text(
                'Admin kami akan segera menghubungi anda',
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
        ),
      ),
    );
  }
}
