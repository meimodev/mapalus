import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardOrder extends StatelessWidget {
  const CardOrder({
    super.key,
    required this.order,
    required this.onPressed,
  });

  final OrderApp order;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(9.sp),
      color: BaseColor.cardBackground1,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: BaseSize.w24,
            vertical: BaseSize.h24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 30.w,
                child: Text(
                  '#${order.id}',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(width: 9.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'dipesan',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 9.sp,
                      ),
                    ),
                    Text(
                      "order.createdAt.format(pattern:'E, dd MMMM')",
                      style: TextStyle(
                        fontSize: 9.sp,
                        // fontWeight:
                        //     order.orderTimeStamp.isSame(Jiffy.now(),unit: Unit.day)
                        //         ? FontWeight.w600
                        //         : FontWeight.w300,
                        color: BaseColor.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.products.length} produk',
                      style: TextStyle(fontSize: 9.sp),
                    ),
                    Text(
                      "order.orderInfo.totalPriceF",
                      style: TextStyle(fontSize: 9.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              SizedBox(
                width: 100,
                child: _buildCardOrderStatus(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildCardOrderStatus(BuildContext context) {
    if (order.status == OrderStatus.placed) {
      return Column(
        children: [
          Text(
            'Menunggu konfirmasi',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 9.sp,
            ),
          ),
          SizedBox(height: 3.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 1.h,
              color: BaseColor.primary3,
            ),
          ),
        ],
      );
    }
    if (order.status == OrderStatus.accepted) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'antar',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 9.sp,
            ),
          ),
          Text(
            "order.orderInfo.deliveryTime",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 9.sp,
            ),
          ),
          SizedBox(height: 3.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 1.h,
              color: BaseColor.accent,
            ),
          ),
        ],
      );
    }
    if (order.status == OrderStatus.rejected) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'batal',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: BaseColor.negative,
              fontSize: 9.sp,
            ),
          ),
          Text(
            // order.confirmTimeStamp?.format(pattern:"E, dd MMMM") ?? '-',
            "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: BaseColor.negative,
              fontSize: 9.sp,
            ),
          ),
        ],
      );
    }
    if (order.status == OrderStatus.delivered) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'diantar',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 9.sp,
              color: BaseColor.positive,
            ),
          ),
          Text(
            // order.deliverTimeStamp?.format(pattern:"E, dd MMM HH:mm:ss") ?? '-',
            "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: BaseColor.positive,
              fontSize: 9.sp,
            ),
          ),
        ],
      );
    }
    if (order.status == OrderStatus.finished) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'selesai',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 9.sp,
            ),
          ),
          Text(
            // order.finishTimeStamp!.format(pattern:"E, dd MMMM"),
            "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 9.sp,
            ),
          ),
        ],
      );
    }
  }
}
