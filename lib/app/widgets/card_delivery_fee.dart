import 'package:flutter/material.dart';

import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

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
                              colorFilter: const ColorFilter.mode(
                                Palette.accent,
                                BlendMode.srcIn,
                              ),
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
                                style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Palette.textPrimary,
                                    ),
                              ),
                              deliveryInfo.isTomorrow
                                  ? Text(
                                      ' BESOK ( ${deliveryInfo.startDate.add(days: 1).format(pattern:"EEEE dd MMM")} )',
                                      style: TextStyle(
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
                            TextStyle(
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
                style: TextStyle(
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
                          TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          message,
                          style:
                          TextStyle(
                                    color: Palette.textPrimary,
                                    fontSize: 12.sp,
                                  ),
                        )
                      ],
                    ),
                    Text(
                      "Waktu pengantaran sedang tidak tersedia",
                      style: TextStyle(
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