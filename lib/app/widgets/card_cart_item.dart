import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus/app/widgets/dialog_confirm.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardCartItem extends StatefulWidget {
  const CardCartItem({
    super.key,
    required this.index,
    required this.productOrder,
    required this.onPressedDelete,
    this.onChangedQuantity,
  });

  final int index;
  final ProductOrder productOrder;
  final void Function(ProductOrder value) onPressedDelete;
  final void Function(ProductOrder value)? onChangedQuantity;

  @override
  State<CardCartItem> createState() => _CardCartItemState();
}

class _CardCartItemState extends State<CardCartItem> {
  int value = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.productOrder.quantity;
    });
  }

  void onChangedValue() {
    if (widget.onChangedQuantity != null) {
      print(
          "${widget.productOrder.product.name} changed quantity $value current ${widget.productOrder.quantity}");
      widget.onChangedQuantity!(
        widget.productOrder.copyWith(quantity: value),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w12,
        vertical: BaseSize.w12,
      ),
      decoration: BoxDecoration(
        color: BaseColor.cardBackground1,
        borderRadius: BorderRadius.circular(
          BaseSize.roundnessMedium,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ImageWrapperWidget(
              imageUrl: widget.productOrder.product.image,
            ),
            Gap.w12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.productOrder.product.name,
                    style: BaseTypography.caption.w300,
                  ),
                  Text(
                    "${widget.productOrder.product.price.formatNumberToCurrency()}"
                    "${widget.productOrder.product.unit.isNotEmpty ? " / ${widget.productOrder.product.unit}" : ""}",
                    style: BaseTypography.caption.w500,
                  ),
                  Gap.h6,
                  _BuildAlterQuantityLayout(
                    onPressedAdd: (int value) {
                      setState(() {
                        this.value++;
                      });
                      onChangedValue();
                    },
                    onPressedSub: (int value) {
                      setState(() {
                        this.value--;
                      });
                      onChangedValue();
                    },
                    value: value,
                  ),
                ],
              ),
            ),
            Gap.w12,
            IconButton(
              onPressed: () => widget.onPressedDelete(widget.productOrder),
              icon: Icon(
                Ionicons.trash_outline,
                color: BaseColor.negative,
                size: BaseSize.customRadius(24),
              ),
            ),
            // ButtonDeleteProductOrderWidget(),
          ],
        ),
      ),
    );
  }
}

class _BuildAlterQuantityLayout extends StatelessWidget {
  const _BuildAlterQuantityLayout({
    required this.onPressedAdd,
    required this.onPressedSub,
    required this.value,
  });

  final void Function(int value) onPressedAdd;
  final void Function(int value) onPressedSub;
  final int value;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: BaseSize.w6,
            ),
            width: BaseSize.w72,
            decoration: BoxDecoration(
              color: BaseColor.editable,
              borderRadius: BorderRadius.circular(
                BaseSize.radiusSm,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                 "x${value.toFormatThousand}",
                style: BaseTypography.caption,
              ),
            ),
          ),
          Gap.w12,
          ButtonAltering(
            onPressed: () => onPressedSub(value),
            label: "-",
            enabled: value > 1,
          ),
          Gap.w4,
          ButtonAltering(
            onPressed: () => onPressedAdd(value),
            label: "+",
            enabled: true,
          ),
        ],
      ),
    );
  }
}
