import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardOrdersPeak extends StatelessWidget {
  const CardOrdersPeak({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BaseColor.primary3,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(18.sp),
        topLeft: Radius.circular(18.sp),
        topRight: Radius.circular(18.sp),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(BaseSize.w12),
          child: Row(
            children: [
              SizedBox(width: 3.w),
              SvgPicture.asset(
                "assets/vectors/bag.svg",
                colorFilter: const ColorFilter.mode(
                  BaseColor.primaryText,
                  BlendMode.srcIn,
                ),
                height: 18.sp,
                width: 18.sp,
              ),
              SizedBox(width: BaseSize.w12 * .75),
              Text(
                'Pesanan anda',
                style: TextStyle(
                      color: BaseColor.primaryText,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
              ),
              SizedBox(width: 3.w),
            ],
          ),
        ),
      ),
    );
  }
}
