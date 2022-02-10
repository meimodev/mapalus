import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/shared/theme.dart';

class CardNavigation extends StatelessWidget {
  const CardNavigation({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.cardForeground,
      elevation: 6,
      shadowColor: Colors.grey.withOpacity(.125),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
          height: 60.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  'assets/vectors/back.svg',
                  height: 24.sp,
                  width: 24.sp,
                ),
              ),
              Center(
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}