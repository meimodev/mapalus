import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/card_order_info.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/button_widget.dart';

class MainActionLayoutWidget extends StatelessWidget {
  const MainActionLayoutWidget({
    super.key,
    required this.orderApp,
    required this.onPressedCancel,
    required this.onPressedConfirm,
  });

  final OrderApp orderApp;

  final VoidCallback onPressedCancel;

  // final VoidCallback onPressedFinish;
  final VoidCallback onPressedConfirm;

  @override
  Widget build(BuildContext context) {
    switch (orderApp.status) {
      case OrderStatus.placed:
        return CardOrderInfo(
          text:
              "Pesanan anda sudah masuk, silahkan tunggu konfirmasi partner kami ya",
          backgroundColor: BaseColor.accent.withOpacity(.25),
          borderColor: BaseColor.accent,
        );
      case OrderStatus.accepted:
        return CardOrderInfo(
          text: "MANTAPP, Pesanan telah diterima, silahkan tunggu diantar yaaa",
          backgroundColor: BaseColor.positive.withOpacity(.25),
          borderColor: BaseColor.positive,
        );
      case OrderStatus.rejected:
        return CardOrderInfo(
          text: "Maaf yaaa, Pesanan anda telah dibatalkan oleh partner",
          backgroundColor: BaseColor.negative.withOpacity(.25),
          borderColor: BaseColor.negative,
        );
      case OrderStatus.delivered:
        return _BuildDeliveredLayout(
          onPressedConfirm: onPressedConfirm,
        );
      case OrderStatus.finished:
        return _BuildRatedLayout(
          order: orderApp,
          onPressedRate: onPressedConfirm,
        );
      case OrderStatus.canceled:
        return CardOrderInfo(
          text: "OK, Pesanan anda telah berhasil dibatalkan",
          backgroundColor: BaseColor.yellow.withOpacity(.25),
          borderColor: BaseColor.yellow,
        );
    }
  }
}

class _BuildDeliveredLayout extends StatelessWidget {
  const _BuildDeliveredLayout({required this.onPressedConfirm});

  final VoidCallback onPressedConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CardOrderInfo(
          text: "Pesanan telah diantar",
          backgroundColor: BaseColor.positive.withOpacity(.25),
          borderColor: BaseColor.positive,
        ),
        Gap.h12,
        ButtonWidget(
          text: "Konfirmasi Pesanan",
          textStyle: BaseTypography.bodySmall.toBold,
          onPressed: onPressedConfirm,
        ),
      ],
    );
  }
}

class _BuildRatedLayout extends StatelessWidget {
  const _BuildRatedLayout({
    required this.order,
    required this.onPressedRate,
  });

  final OrderApp order;
  final VoidCallback onPressedRate;

  @override
  Widget build(BuildContext context) {
    final rating = order.rating;
    if (rating == null) {
      return CardOrderInfo(
        text: "Order telah selesai, belum ada penilaian",
        backgroundColor: BaseColor.primary3.withOpacity(.25),
        borderColor: BaseColor.primary3,
        child: Padding(
          padding: EdgeInsets.only(
            top: BaseSize.h6,
            bottom: BaseSize.h6,
          ),
          child: ButtonWidget(
            text: "Nilai Pesanan",
            textStyle: BaseTypography.bodySmall.bold,
            onPressed: onPressedRate,
          ),
        ),
      );
    }
    return CardOrderInfo(
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: rating.rate.toDouble(),
            itemCount: 5,
            itemSize: BaseSize.radiusLg,
            itemPadding: EdgeInsets.symmetric(horizontal: BaseSize.w6),
            onRatingUpdate: (_) {},
            itemBuilder: (_, int index) => SvgPicture.asset(
              'assets/vectors/star.svg',
              colorFilter: const ColorFilter.mode(
                BaseColor.primary3,
                BlendMode.srcIn,
              ),
            ),
            updateOnDrag: false,
            ignoreGestures: true,
            unratedColor: BaseColor.accent,
          ),
          Gap.h6,
          Text(
            'Dinilai ${order.lastUpdate.ddMmmmYyyy}',
            style: BaseTypography.bodySmall,
          ),
          rating.message.isNotEmpty ? Gap.h6 : const SizedBox(),
          rating.message.isNotEmpty
              ? Text(
                  rating.message,
                  style: BaseTypography.bodySmall,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
