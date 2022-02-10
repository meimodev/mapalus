import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/shared/theme.dart';

class ButtonAlterQuantity extends StatelessWidget {
  const ButtonAlterQuantity(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.primary,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 45.w,
          height: 45.h,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}