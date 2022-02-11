import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/shared/theme.dart';

class CardNavigation extends StatelessWidget {
  const CardNavigation({
    Key? key,
    required this.title,
    this.isInverted = false,
  }) : super(key: key);

  final String title;
  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isInverted ? Palette.accent : Palette.cardForeground,
      elevation: isInverted ? 0 : 6,
      shadowColor: isInverted ? null : Colors.grey.withOpacity(.125),
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
                  color: isInverted ? Palette.editable : Palette.textPrimary,
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color:
                            isInverted ? Palette.editable : Palette.textPrimary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}