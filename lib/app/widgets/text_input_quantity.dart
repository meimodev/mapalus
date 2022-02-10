import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/shared/theme.dart';

class TextInputQuantity extends StatelessWidget {
  const TextInputQuantity({Key? key, this.icon, this.onTextChanged})
      : super(key: key);

  final Widget? icon;
  final Function(String text)? onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: Palette.editable,
        borderRadius: BorderRadius.circular(6.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: Insets.small.w),
          icon != null
              ? SizedBox(
                  height: 45.h,
                  width: 12.w,
                  child: icon,
                )
              : const SizedBox(),
          SizedBox(width: Insets.small.w * .75),
          Expanded(
            child: TextField(
              onChanged: onTextChanged,
              maxLines: 1,
              autocorrect: false,
              style: TextStyle(
                color: Palette.accent,
                fontFamily: fontFamily,
                fontSize: 14.sp,
              ),
              cursorColor: Palette.primary,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.sp,
                ),
                isDense: true,
                border: InputBorder.none,
                hintText: "...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}