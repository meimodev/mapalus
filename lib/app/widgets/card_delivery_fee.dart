import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/shared/theme.dart';

class CardDeliveryFee extends StatelessWidget {
  const CardDeliveryFee({
    Key? key,
    this.isActive = false,
    required this.deliveryInfo,
    required this.onPressed,
    required this.price,
  }) : super(key: key);

  final DeliveryInfo deliveryInfo;
  final String price;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return deliveryInfo.isAvailable
        ? Material(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(9.sp),
              side: BorderSide(
                width: 1.5,
                color: isActive ? Palette.primary : Colors.transparent,
              ),
            ),
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
                          Row(
                            children: [
                              Text(
                                deliveryInfo.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontSize: 12.sp,
                                      color: Palette.textPrimary,
                                    ),
                              ),
                              deliveryInfo.isTomorrow
                                  ? Text(
                                      ' BESOK ( ${deliveryInfo.startDate.add(days: 1).format("EEEE dd MMM")} )',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: Palette.textPrimary,
                                            fontSize: 12.sp,
                                          ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          Text(
                            price,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : _buildUnavailableLayout(context, "");
  }

  _buildUnavailableLayout(BuildContext context, String message) {
    return Material(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(9.sp),
        side: const BorderSide(
          width: 1.5,
          color: Colors.transparent,
        ),
      ),
      color: Colors.grey.shade200,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          // onPressed();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Waktu pengantaran sedang tidak tersedia',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 14.sp,
                      color: Palette.cardForeground,
                    ),
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Insets.small.h * .5,
            horizontal: Insets.medium.w * .5,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          deliveryInfo.title,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          message,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Palette.textPrimary,
                                    fontSize: 12.sp,
                                  ),
                        )
                      ],
                    ),
                    Text(
                      "Waktu pengantaran sedang tidak tersedia",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
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