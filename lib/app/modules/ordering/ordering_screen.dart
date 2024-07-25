import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/ordering/ordering_controller.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderingScreen extends GetView<OrderingController> {
  const OrderingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) {
          controller.onPressedBack();
        },
        child: Stack(
          children: [
            // Center(
            //   child: Obx(() => _buildLoading(context)),
            // ),
            Center(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.isLoading.value
                      ? _buildLoading(context)
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: BaseSize.w12 * 2.4),
                              child: SvgPicture.asset(
                                'assets/vectors/order-received.svg',
                                height: 120.sp,
                                width: 120.sp,
                              ),
                            ),
                            SizedBox(height: BaseSize.h24),
                            Text(
                              'Pesanan Diterima',
                              style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                            ),
                            SizedBox(height: BaseSize.h12),
                            Text(
                              'Anda akan segera dihubungi \nsaat waktu pengantaran nanti',
                              style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            SizedBox(height: BaseSize.h24 * 1.5),
                          ],
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: BaseSize.h24,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.isLoading.value
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: BaseSize.w24,
                          ),
                          child: Column(
                            children: [
                              _buildButton(
                                text: "Lihat Pesanan",
                                onPressed: controller.onPressedSeeOrder,
                              ),
                              SizedBox(height: BaseSize.h12),
                              _buildButton(
                                text: "Kembali",
                                isSecondary: true,
                                onPressed: controller.onPressedReturn,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildButton({
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return SizedBox(
      width: isSecondary ? 190.w : double.infinity,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(9.sp),
        color: isSecondary ? Colors.grey : BaseColor.primary3,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isSecondary ? BaseSize.w12 * .75 : BaseSize.w12,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                      fontSize: isSecondary ? 10.sp : 14.sp,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildLoading(BuildContext context) {
    return Visibility(
      visible: controller.isLoading.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sedang Melakukan Pemesanan',
            style: TextStyle(
                  fontSize: 14.sp,
                ),
          ),
          SizedBox(height: BaseSize.h24),
          const CircularProgressIndicator(color: BaseColor.primary3),
        ],
      ),
    );
  }
}