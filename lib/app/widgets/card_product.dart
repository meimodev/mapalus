import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/food/widgets/widgets.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/custom_image.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.product,
    this.width,
    this.onPressed,
  });

  final Product product;
  final void Function(ProductOrder productOrder)? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: BaseColor.white,
      borderRadius: BorderRadius.circular(BaseSize.radiusSm),
      child: InkWell(
        onTap: () {
          showBottomSheetProductDetailWidget(
            context,
            product.id,
            (value) {
              if (onPressed != null) {
                onPressed!(value);
              }
            },
          );
        },
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
                  child: Stack(
                    children: [
                      CustomImage(imageUrl: product.image),
                      Positioned(
                        bottom: BaseSize.h8,
                        left: BaseSize.w8,
                        right: BaseSize.w8,
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
                                  product.status!.isAvailable
                                      ? const SizedBox()
                                      : const IconProductStatus(
                                          text: "!",
                                          textColor: BaseColor.negative,
                                        ),
                                  Gap.w4,
                                ],
                              ),
                            ),
                            // product.category.isNotEmpty
                            //     ? ChipCategory(title: product.category)
                            //     : const SizedBox(),
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
                        "${product.price.formatNumberToCurrency()} / ${product.unit!.name}",
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
