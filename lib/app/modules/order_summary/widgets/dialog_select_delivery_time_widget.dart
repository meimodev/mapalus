import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/loading_wrapper.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

import 'widgets.dart';

typedef OnValueSelectedCallbackDeliveryTimeTypeDef = void Function(
    DeliveryTime value, String title);

Future<T?> showDialogDeliveryTimeWidget<T>({
  required BuildContext context,
  required OnValueSelectedCallbackDeliveryTimeTypeDef onValueSelected,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) => DialogSelectDeliveryTimeWidget(
      onValueSelected: onValueSelected,
    ),
  );
}

class DialogSelectDeliveryTimeWidget extends StatefulWidget {
  const DialogSelectDeliveryTimeWidget({
    super.key,
    required this.onValueSelected,
  });

  final OnValueSelectedCallbackDeliveryTimeTypeDef onValueSelected;

  @override
  State<DialogSelectDeliveryTimeWidget> createState() =>
      _DialogSelectDeliveryTimeWidgetState();
}

class _DialogSelectDeliveryTimeWidgetState
    extends State<DialogSelectDeliveryTimeWidget>
    with SingleTickerProviderStateMixin {
  List<DeliveryTime> times = <DeliveryTime>[];
  bool loading = true;
  final AppRepo appRepo = Get.find<AppRepo>();

  @override
  void initState() {
    super.initState();
    // Get delivery time from app config
    populateTimes();
  }

  void populateTimes() async {
    setState(() {
      loading = true;
    });
    times = await appRepo.getDeliveryTimes();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      showDragHandle: false,
      builder: (context) => LoadingWrapper(
        loading: loading,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w24,
            vertical: BaseSize.w24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Waktu Pengantaran',
                textAlign: TextAlign.center,
                style: BaseTypography.bodyMedium,
              ),
              Gap.h12,
              ListView.separated(
                shrinkWrap: true,
                itemCount: times.length,
                separatorBuilder: (context, index) => Gap.h12,
                itemBuilder: (context, index) =>
                    CardItemSelectDeliveryTimeWidget(
                  onPressed: widget.onValueSelected,
                  deliveryTime: times[index],
                ),
              ),
              Gap.h12,
            ],
          ),
        ),
      ),
      onClosing: () {},
    );
  }
}
