import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.onPressed,
    required this.product,
    this.width,
  });

  final Product product;
  final Function(Product product) onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: BaseColor.white,
      borderRadius: BorderRadius.circular(BaseSize.radiusSm),
      child: InkWell(
        onTap: () => onPressed(product),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: BaseSize.customWidth(200),
          ),
          child: IntrinsicWidth(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: BaseColor.secondaryText,
                    borderRadius: BorderRadius.circular(BaseSize.radiusSm),
                  ),
                  height: BaseSize.customWidth(120),
                  // width: BaseSize.customWidth(160),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: BaseSize.h4,
                        left: BaseSize.w4,
                        right: BaseSize.w4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  product.customPrice
                                      ? const IconProductStatus(text: "\$")
                                      : const SizedBox(),
                                  Gap.w4,
                                  product.status.available
                                      ? const IconProductStatus(
                                          text: "!",
                                          textColor: BaseColor.negative,
                                        )
                                      : const SizedBox(),
                                  Gap.w4,
                                ],
                              ),
                            ),
                            product.category.isNotEmpty
                                ? ChipCategory(title: product.category)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: BaseSize.w12,
                    vertical: BaseSize.h12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.name,
                        style: BaseTypography.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${product.price.formatNumberToCurrency()} / ${product.unit}",
                        style: BaseTypography.bodyMedium.w300,
                        overflow: TextOverflow.ellipsis,

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
