import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/shared/theme.dart';

class CardDeliveryFee extends StatelessWidget {
  const CardDeliveryFee({
    Key? key,
    required this.deliveryTime,
    required this.price,
    this.isActive = false,
    required this.onPressed,
  }) : super(key: key);

  final String deliveryTime;
  final String price;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(9.sp),
      color: Colors.grey.shade200,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Insets.small.h * .5,
            horizontal: Insets.medium.w * .5,
          ),
          child: Row(
            children: [
              ...isActive
                  ? [
                      SvgPicture.asset(
                        'assets/vectors/check.svg',
                        width: 24.sp,
                        height: 24.sp,
                        color: Palette.accent,
                      ),
                      SizedBox(width: Insets.small.w * .85),
                    ]
                  : [const SizedBox()],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deliveryTime,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 12.sp,
                          ),
                    ),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}