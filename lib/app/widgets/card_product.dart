import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/shared/theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    this.isAvailable = true,
  }) : super(key: key);

  final String name;
  final String price;
  final String image;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Palette.cardForeground,
      ),
      padding: EdgeInsets.all(Insets.small.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isAvailable
              ? const SizedBox()
              : Row(
                  children: [
                    Icon(
                      Icons.add_alarm_outlined,
                      size: 15.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(width: Insets.small.w * .5),
                    Text(
                      "Tidak Tersedia",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: .25,
                    blurRadius: 10,
                    color: isAvailable
                        ? Palette.primary.withOpacity(.125)
                        : Colors.grey.withOpacity(.125),
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Insets.small.h * 1.5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: isAvailable ? Palette.textPrimary : Colors.grey,
                    ),
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: isAvailable ? Palette.textPrimary : Colors.grey,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}