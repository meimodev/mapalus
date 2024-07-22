import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/ordering/ordering_controller.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderingScreen extends GetView<OrderingController> {
  const OrderingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: WillPopScope(
        onWillPop: () {
          controller.onPressedBack();
          return Future.value(false);
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
                                  EdgeInsets.only(left: Insets.small.w * 2.4),
                              child: SvgPicture.asset(
                                'assets/vectors/order-received.svg',
                                height: 120.sp,
                                width: 120.sp,
                              ),
                            ),
                            SizedBox(height: Insets.medium.h),
                            Text(
                              'Pesanan Diterima',
                              style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                            ),
                            SizedBox(height: Insets.small.h),
                            Text(
                              'Anda akan segera dihubungi \nsaat waktu pengantaran nanti',
                              style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            SizedBox(height: Insets.medium.h * 1.5),
                          ],
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: Insets.medium.h,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.isLoading.value
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Insets.medium.w,
                          ),
                          child: Column(
                            children: [
                              _buildButton(
                                text: "Lihat Pesanan",
                                onPressed: controller.onPressedSeeOrder,
                              ),
                              SizedBox(height: Insets.small.h),
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
        color: isSecondary ? Colors.grey : BaseColor.primary,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isSecondary ? Insets.small.w * .75 : Insets.small.w,
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
          SizedBox(height: Insets.medium.h),
          const CircularProgressIndicator(color: BaseColor.primary),
        ],
      ),
    );
  }
}