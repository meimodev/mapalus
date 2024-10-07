import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/location/location_controller.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus/app/widgets/google_map_wrapper.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            left: 0,
            child: GoogleMapWrapper(
              onCameraIdle: controller.onCameraIdle,
              onMapCreated: controller.onMapCreated,
              defaultPosition: controller.origin ?? const LatLng(0, 0),
              // onMoveCamera: controller.onMoveCamera,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CardNavigation(
                  title: 'Pilih Lokasi',
                  onPressedBack: () => Navigator.pop(context),
                  isInverted: true,
                  isCircular: true,
                ),
                Expanded(
                  child: Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: controller.dragging.value
                          ? const SizedBox()
                          : LoadingWrapper(
                              loading: controller.loading.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: BaseSize.customWidth(100),
                                    child: ButtonMain(
                                      title: "Pilih",
                                      onPressed:
                                          controller.onPressedSelectLocation,
                                    ),
                                  ),
                                  Gap.h12,
                                  Icon(
                                    Icons.location_on,
                                    color: BaseColor.primary3,
                                    size: 40.sp,
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
        ],
      ),
    );
  }
}
