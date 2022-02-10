import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/shared/theme.dart';

import 'dialog_item_detail.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    this.isAvailable = true,
    this.onPressed,
  }) : super(key: key);

  final String name;
  final String price;
  final String image;
  final bool isAvailable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(12.sp),
      ),
      clipBehavior: Clip.hardEdge,
      color: Palette.cardForeground,
      child: InkWell(
        onTap: onPressed ??
            () {
              showDialog(
                context: context,
                builder: (_) => DialogItemDetail(isAvailable: isAvailable),
              );
            },
        child: Padding(
          padding: EdgeInsets.all(Insets.small.sp * 1.75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isAvailable
                  ? Text(
                      "Tidak Tersedia",
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
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color:
                              isAvailable ? Palette.textPrimary : Colors.grey,
                        ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 11.sp,
                          color:
                              isAvailable ? Palette.textPrimary : Colors.grey,
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