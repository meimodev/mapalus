import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardDeliveryFee extends StatelessWidget {
  const CardDeliveryFee({
    super.key,
    this.isActive = false,
    // required this.deliveryInfo,
    required this.onPressed,
    required this.price,
    required this.deliveryTime,
  });

  final DeliveryTime deliveryTime;
  final String price;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return deliveryTime.available
        ? Material(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(9.sp),
              side: BorderSide(
                width: 1.5,
                color: isActive ? BaseColor.primary3 : Colors.transparent,
              ),
            ),
            color: Colors.grey.shade200,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: BaseSize.h12 * .5,
                  horizontal: BaseSize.w24 * .5,
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
                                BaseColor.accent,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap.h12,
                          ]
                        : [const SizedBox()],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                deliveryTime.toString(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: BaseColor.primaryText,
                                ),
                              ),
                              // deliveryTime.isTomorrow
                              //     ? Text(
                              //         ' BESOK ( ${deliveryTime.startDate.add(days: 1).format(pattern:"EEEE dd MMM")} )',
                              //         style: TextStyle(
                              //               color: BaseColor.primaryText,
                              //               fontSize: 12.sp,
                              //             ),
                              //       )
                              //     : const SizedBox(),
                            ],
                          ),
                          Text(
                            price,
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
          )
        : _buildUnavailableLayout(context, "");
  }

  Widget _buildUnavailableLayout(BuildContext context, String message) {
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
                  color: BaseColor.cardBackground1,
                ),
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: BaseSize.h12 * .5,
            horizontal: BaseSize.w24 * .5,
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
                          deliveryTime.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          message,
                          style: TextStyle(
                            color: BaseColor.primaryText,
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
