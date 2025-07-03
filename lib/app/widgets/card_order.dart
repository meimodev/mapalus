import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardOrder extends StatelessWidget {
  const CardOrder({
    super.key,
    required this.order,
    required this.onPressed,
  });

  final OrderApp order;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(9.sp),
      color: BaseColor.cardBackground1,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w6,
            vertical: BaseSize.w6,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'dipesan',
                        style: BaseTypography.captionSmall.toBold,
                      ),
                      Text(
                        order.createdAt.EddMMMHHmm,
                        style: BaseTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                Gap.w8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.products.length} produk',
                        style: BaseTypography.captionSmall,
                      ),
                      Text(
                        order.payment.amount.formatNumberToCurrency(),
                        style: BaseTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                Gap.w3,
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: BaseSize.customWidth(100),
                  ),
                  child: _buildCardOrderStatus(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardOrderStatus() {
    switch (order.status) {
      case OrderStatus.placed:
        return const _BuildCardOrderStatus(
          title: "Menunggu Konfirmasi",
          textColor: BaseColor.primary3,
          underlineColor: BaseColor.primary3,
        );
      case OrderStatus.accepted:
        return _BuildCardOrderStatus(
          title: "Sedang Diproses",
          // subTitle: order.lastUpdate.EddMMMHHmm,
          underlineColor: BaseColor.accent,
        );
      case OrderStatus.rejected:
        return _BuildCardOrderStatus(
          title: "Ditolak",
          subTitle: order.lastUpdate.EddMMMHHmm,
          textColor: BaseColor.negative,
          underlineColor: BaseColor.negative,
        );
      case OrderStatus.delivered:
        return _BuildCardOrderStatus(
          title: "Diantar",
          subTitle: order.lastUpdate.EddMMMHHmm,
          textColor: BaseColor.positive,
          underlineColor: BaseColor.positive,
        );
      case OrderStatus.finished:
        return _BuildCardOrderStatus(
          title: "Selesai",
          subTitle: order.lastUpdate.EddMMMHHmm,
          underlineColor: BaseColor.primaryText,
        );
      case OrderStatus.canceled:
        return _BuildCardOrderStatus(
          title: "Dibatalkan",
          textColor: BaseColor.negative,
          subTitle: order.lastUpdate.EddMMMHHmm,
          underlineColor: BaseColor.negative,
        );
    }
  }
}

class _BuildCardOrderStatus extends StatelessWidget {
  const _BuildCardOrderStatus({
    this.underlineColor,
    this.textColor,
    required this.title,
    this.subTitle,
  });

  final Color? underlineColor;
  final Color? textColor;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: BaseTypography.captionSmall.toBold.copyWith(
            color: textColor ?? BaseColor.primaryText,
          ),
        ),
        subTitle != null
            ? Text(subTitle!, style: BaseTypography.bodySmall)
            : const SizedBox(),
        Gap.h4,
        underlineColor != null
            ? Container(
                height: 1,
                color: underlineColor!,
              )
            : const SizedBox(),
      ],
    );
  }
}
