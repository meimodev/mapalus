import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/custom_image.dart';

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
  double quantity = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      quantity = widget.productOrder.quantity;
    });
  }

  void onChangedValue() {
    if (widget.onChangedQuantity != null) {
      widget.onChangedQuantity!(
        widget.productOrder.copyWith(
          quantity: quantity,
          totalPrice: quantity * widget.productOrder.product.price,
        ),
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
            Container(
              width: BaseSize.customWidth(76),
              height: BaseSize.customWidth(76),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BaseSize.radiusMd),
              ),
              clipBehavior: Clip.hardEdge,
              child: CustomImage(
                imageUrl: widget.productOrder.product.image,
              ),
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
                    "${widget.productOrder.product.unit!.name.isNotEmpty ? " / ${widget.productOrder.product.unit!.name}" : ""}",
                    style: BaseTypography.caption.w500,
                  ),
                  Gap.h6,
                  _BuildAlterQuantityLayout(
                    onPressedAdd: (_) {
                      setState(() {
                        quantity++;
                      });
                      onChangedValue();
                    },
                    onPressedSub: (_) {
                      setState(() {
                        quantity--;
                      });
                      onChangedValue();
                    },
                    value: quantity,
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

  final void Function(double value) onPressedAdd;
  final void Function(double value) onPressedSub;
  final double value;

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
