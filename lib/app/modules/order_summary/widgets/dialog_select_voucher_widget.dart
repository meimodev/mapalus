import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

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
        onValueSelected: (value) {
          onValueSelected(value);
          Navigator.pop(context);
        },
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
  String errorText = "";
  String voucher = '';

  void onPressedCheckVoucher() {
    // validate voucher in backend
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
            InputWidget.text(
              hint: "Kode Voucher",
              errorText: errorText,
              maxLines: 1,
              onChanged: (String value) => voucher = value,
            ),
            Gap.h24,
            ButtonMain(
              title: "Gunakan Voucher",
              onPressed: onPressedCheckVoucher,
            ),
            Gap.h12,
          ],
        ),
      ),
      onClosing: () {},
    );
  }
}
