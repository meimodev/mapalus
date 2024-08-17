import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

import 'widgets.dart';

typedef OnValueSelectedCallbackVoucherTypeDef = void Function(Voucher value);

Future<T?> showDialogVoucherWidget<T>({
  required BuildContext context,
  required OnValueSelectedCallbackVoucherTypeDef onValueSelected,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    builder: (context) => AnimatedPadding(
      duration: const Duration(milliseconds: 400),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DialogSelectVoucherWidget(
        onValueSelected: onValueSelected,
      ),
    ),
  );
}

class DialogSelectVoucherWidget extends StatefulWidget {
  const DialogSelectVoucherWidget({
    super.key,
    required this.onValueSelected,
  });

  final OnValueSelectedCallbackVoucherTypeDef onValueSelected;

  @override
  State<DialogSelectVoucherWidget> createState() =>
      _DialogSelectVoucherWidget();
}

class _DialogSelectVoucherWidget extends State<DialogSelectVoucherWidget> {
  List<Voucher> times = <Voucher>[];

  @override
  void initState() {
    super.initState();
    times = List.generate(
      3,
      (index) => Voucher(
        id: 'id$index',
        discount: index.toDouble(),
        code: '$index-$index',
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
              'Voucher',
              textAlign: TextAlign.center,
              style: BaseTypography.bodyMedium,
            ),
            Gap.h12,
            InputWidget.text(
              hint: "Kode Voucher",
              errorText: "Invalid Code",
              onChanged: (_) {},
            ),
            Gap.h24,
            ButtonMain(
              title: "Pakai Voucher",
              onPressed: (){},
            ),
            Gap.h12,
          ],
        ),
      ),
      onClosing: () {},
    );
  }
}
