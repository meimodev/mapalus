import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

import 'widgets.dart';

typedef OnValueSelectedCallbackDeliveryTimeTypeDef = void Function(
    DeliveryTime value, String title);

Future<T?> showDialogDeliveryTimeWidget<T>({
  required BuildContext context,
  required OnValueSelectedCallbackDeliveryTimeTypeDef onValueSelected,
}) async {
  return showDialog<T>(
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

  @override
  void initState() {
    super.initState();
    // Get delivery time from app config
    times = List.generate(
      3,
      (index) => DeliveryTime(
        id: 'id$index',
        available: index % 2 == 0,
        discount: index.toDouble(),
        start: DateTime.now().add(Duration(hours: index + 1)),
        end: DateTime.now().add(Duration(hours: index + 2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      showDragHandle: false,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BaseSize.w24,
          vertical: BaseSize.w24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Delivery Time',
              textAlign: TextAlign.center,
              style: BaseTypography.bodyMedium,
            ),
            Gap.h12,
            ...times.map(
              (e) => CardItemSelectDeliveryTimeWidget(
                onPressed: widget.onValueSelected,
                deliveryTime: e,
              ),
            ),
          ],
        ),
      ),
      onClosing: () {},
    );
  }
}
