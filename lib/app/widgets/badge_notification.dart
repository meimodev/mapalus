import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/shared/theme.dart';

class BadgeNotification extends StatelessWidget {
  const BadgeNotification({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.sp,
      width: 21.sp,
      decoration: const BoxDecoration(
        color: Palette.notification,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 11.sp,
                color: Palette.cardForeground,
              ),
        ),
      ),
    );
  }
}