import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class CardOrderDetailItemProductWidget extends StatefulWidget {
  const CardOrderDetailItemProductWidget({
    super.key,
    required this.productOrder,
    this.onChangeCheck,
  });

  final ProductOrder productOrder;

  final Function(bool value)? onChangeCheck;

  @override
  State<CardOrderDetailItemProductWidget> createState() =>
      _CardOrderDetailItemProductState();
}

class _CardOrderDetailItemProductState
    extends State<CardOrderDetailItemProductWidget> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BaseSize.radiusMd),
      clipBehavior: Clip.hardEdge,
      color: BaseColor.cardBackground1,
      child: InkWell(
        onTap: () {
          setState(() {
            checked = !checked;
          });
          widget.onChangeCheck?.call(checked);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: BaseSize.h12,
            horizontal: BaseSize.w12,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: checked ? BaseSize.w12 : 0,
                color: BaseColor.primary3,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: BaseSize.w48,
                width: BaseSize.w48,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: BaseColor.accent,
                  borderRadius: BorderRadius.circular(BaseSize.radiusMd),
                ),
                child: CustomImage(
                  imageUrl: widget.productOrder.product.image,
                ),
              ),
              Gap.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.productOrder.product.name,
                      style: BaseTypography.bodySmall.toBold,
                    ),
                    Text(
                      "${widget.productOrder.product.price.formatNumberToCurrency()} | "
                      "${widget.productOrder.product.weight.toKilogram()}",
                      style: BaseTypography.bodySmall,
                    ),
                  ],
                ),
              ),
              Text(
                "x${widget.productOrder.quantity.toInt()}",
                style: BaseTypography.bodyMedium.toBold,
              ),
              Gap.w12,
            ],
          ),
        ),
      ),
    );
  }
}
