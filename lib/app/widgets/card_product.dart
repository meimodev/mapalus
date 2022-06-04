import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/custom_image.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/shared/theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.onPressed,
    required this.product,
  }) : super(key: key);

  final Product product;
  final Function(Product product) onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(12.sp),
      ),
      clipBehavior: Clip.hardEdge,
      color: Palette.cardForeground,
      child: InkWell(
        onTap: () {
          onPressed(product);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.small.w,
            vertical: Insets.small.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  product.isAvailable
                      ? SizedBox(
                          height: Insets.small.h,
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              'assets/vectors/min.svg',
                              height: 12.sp,
                              width: 12.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(width: Insets.small.w * .5),
                            Text(
                              "Sedang tidak tersedia",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Palette.accent,
                                    fontSize: 9.sp,
                                  ),
                            ),
                          ],
                        ),
                  product.isCustomPrice
                      ? Row(
                          children: [
                            SvgPicture.asset(
                              'assets/vectors/money.svg',
                              height: 12.sp,
                              width: 12.sp,
                              color: Palette.accent,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(height: Insets.small.h),
              Container(
                height: 120.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: product.isAvailable
                      ? Palette.accent.withOpacity(.85)
                      : Palette.accent.withOpacity(.5),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: .25,
                      blurRadius: 10,
                      color: product.isAvailable
                          ? Palette.primary.withOpacity(.125)
                          : Colors.grey.withOpacity(.125),
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomImage(
                    imageUrl: product.imageUrl,
                  ),
                ),
              ),
              SizedBox(height: Insets.small.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: product.isAvailable
                              ? Palette.textPrimary
                              : Colors.grey,
                        ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${product.priceF} / ${product.unit}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 11.sp,
                          color: product.isAvailable
                              ? Palette.textPrimary
                              : Colors.grey,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}