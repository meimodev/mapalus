import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          padding: EdgeInsets.all(Insets.small.sp * 1.75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.isAvailable
                  ? Text(
                      "",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Palette.cardForeground,
                            fontSize: 11.sp,
                          ),
                    )
                  : Row(
                      children: [
                        SvgPicture.asset(
                          'assets/vectors/min.svg',
                          height: 15.sp,
                          width: 15.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: Insets.small.w * .5),
                        Text(
                          "Tidak Tersedia",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                    fontSize: 11.sp,
                                  ),
                        ),
                      ],
                    ),
              SizedBox(height: Insets.small.h * 1.5),
              Expanded(
                child: Container(
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
                    child: SvgPicture.asset(
                      'assets/images/mapalus.svg',
                      width: 30.w,
                      color: Palette.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Insets.small.h * 1.5),
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