import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardOrdersPeak extends StatelessWidget {
  const CardOrdersPeak({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.primary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(18.sp),
        topLeft: Radius.circular(18.sp),
        topRight: Radius.circular(18.sp),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(Insets.small.sp),
          child: Row(
            children: [
              SizedBox(width: 3.w),
              SvgPicture.asset(
                "assets/vectors/bag.svg",
                colorFilter: const ColorFilter.mode(
                  Palette.textPrimary,
                  BlendMode.srcIn,
                ),
                height: 18.sp,
                width: 18.sp,
              ),
              SizedBox(width: Insets.small.w * .75),
              Text(
                'Pesanan anda',
                style: TextStyle(
                      color: Palette.textPrimary,
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
