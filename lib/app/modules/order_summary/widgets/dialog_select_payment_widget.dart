import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

import 'widgets.dart';

typedef OnValueSelectedCallbackPaymentTypeDef = void Function(
    PaymentMethod value);

Future<T?> showDialogPaymentWidget<T>({
  required BuildContext context,
  required OnValueSelectedCallbackPaymentTypeDef onValueSelected,
}) async {
  return showDialog<T>(
    context: context,
    builder: (context) =>
        DialogSelectPaymentWidget(onValueSelected: onValueSelected),
  );
}

class DialogSelectPaymentWidget extends StatelessWidget {
  const DialogSelectPaymentWidget({
    super.key,
    required this.onValueSelected,
  });

  final OnValueSelectedCallbackPaymentTypeDef onValueSelected;

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
              'Choose Payment',
              textAlign: TextAlign.center,
              style: BaseTypography.bodyMedium,
            ),
            Gap.h12,
            CardItemSelectPaymentWidget(
              onPressed: () {
                onValueSelected(PaymentMethod.cash);
                Navigator.pop(context);
              },
              title: 'Bayar di tempat (Tunai)',
              description: "Cash on Delivery",
              note:
                  "Untuk mempermudah transaksi tolong sediakan uang pas ya kak",
              iconData: Icons.payments_outlined,
            ),
            Gap.h12,
            CardItemSelectPaymentWidget(
              onPressed: () {
                onValueSelected(PaymentMethod.transfer);
                Navigator.pop(context);
              },
              title: 'Transfer Manual',
              description: "Silahkan Lakukan Transfer di rekening berikut",
              note: "Karena Prosesnya manual tunggu admin kami kontak yaa ",
              iconData: Icons.payment_outlined,
            ),
            Gap.h12,
            CardItemSelectPaymentWidget(
              onPressed: () {},
              title: 'Virtual Account',
              available: false,
              description: "Coming Soon boss",
              iconData: Icons.payment_outlined,
            ),
            Gap.h12,
            CardItemSelectPaymentWidget(
              onPressed: () {},
              title: 'E-wallet',
              available: false,
              description: "Coming Soon boss",
              iconData: Icons.payment_outlined,
            ),
            Gap.h12,
          ],
        ),
      ),
      onClosing: () {},
    );
  }
}
