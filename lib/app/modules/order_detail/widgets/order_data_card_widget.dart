// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

import 'main_action_layout_widget.dart';
import 'widgets.dart';

class OrderDataCardWidget extends StatelessWidget {
  const OrderDataCardWidget({
    super.key,
    required this.orderApp,
    required this.onPressedCancel,
    required this.onPressedConfirm,
    required this.onPressedViewMap,
  });

  final OrderApp orderApp;

  final VoidCallback onPressedViewMap;

  final VoidCallback onPressedCancel;
  final VoidCallback onPressedConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: BaseSize.w12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w12,
        vertical: BaseSize.h12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BaseSize.radiusMd),
        color: BaseColor.cardBackground1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              DeliveryInfoLayoutWidget(
                orderApp: orderApp,
                onPressedViewMap: onPressedViewMap,
              ),
              PaymentInfoLayoutWidget(
                paymentMethod: orderApp.payment.method.name.toUpperCase(),
              ),
              Gap.h12,
              orderApp.note.isNotEmpty
                  ? NoteCardWidget(note: orderApp.note)
                  : const SizedBox(),
              Gap.h12,
              _buildRowItem(
                context,
                "Produk",
                "${orderApp.products.length} Produk",
                (orderApp.payment.amount - (orderApp.delivery?.price ?? 0))
                    .formatNumberToCurrency(),
              ),
              orderApp.delivery == null
                  ? const SizedBox()
                  : _buildRowItem(
                      context,
                      "Pengantaran",
                      orderApp.delivery!.weight.toKilogram(),
                      orderApp.delivery!.price.formatNumberToCurrency(),
                    ),
              _buildRowItem(
                context,
                "Total Pembayaran",
                '',
                orderApp.payment.amount.formatNumberToCurrency(),
                highLight: true,
              ),
            ],
          ),
          Gap.h24,
          MainActionLayoutWidget(
            orderApp: orderApp,
            onPressedCancel: onPressedCancel,
            onPressedConfirm: onPressedConfirm,
          ),
        ],
      ),
    );
  }

  Widget _buildRowItem(
    BuildContext context,
    String title,
    String sub,
    String value, {
    bool highLight = false,
  }) =>
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: BaseTypography.titleLarge.w500,
                ),
                highLight
                    ? const SizedBox()
                    : Text(
                        sub,
                        style: BaseTypography.bodySmall.toSecondary,
                      ),
              ],
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              textAlign: TextAlign.end,
              style: BaseTypography.titleLarge.toSecondary,
            ),
          ),
        ],
      );
}
