import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

import 'widgets.dart';

typedef OnValueSelectedCallbackPaymentTypeDef = void Function(
    PaymentMethod value, String title);

Future<T?> showDialogPaymentWidget<T>({
  required BuildContext context,
  required OnValueSelectedCallbackPaymentTypeDef onValueSelected,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
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
              'Pilih Pembayaran',
              textAlign: TextAlign.center,
              style: BaseTypography.bodyMedium,
            ),
            Gap.h12,
            CardItemSelectPaymentWidget(
              onPressed: () {
                onValueSelected(PaymentMethod.cash, "Bayar di tempat (Tunai)");
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
                onValueSelected(PaymentMethod.transfer, "Transfer Manual");
                Navigator.pop(context);
              },
              title: 'Transfer Manual',
              description: "Transfernya sesuai instruksi admin ya",
              note: "Transfernya akan dikonfirmasi admin kami ya",
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
