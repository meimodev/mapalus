import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class TextInputQuantity extends StatelessWidget {
  const TextInputQuantity({
    Key? key,
    this.icon,
    this.onTextChanged,
    required this.textEditingController,
    this.isReadOnly = false,
    this.trailingWidget,
  }) : super(key: key);

  final Widget? icon;
  final Function(String)? onTextChanged;
  final TextEditingController textEditingController;
  final bool isReadOnly;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 147.w,
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
          SizedBox(width: Insets.small.w * .5),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: onTextChanged,
              keyboardType: TextInputType.number,
              maxLines: 1,
              autocorrect: false,
              readOnly: isReadOnly,
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
                hintText: "_",
              ),
            ),
          ),
          trailingWidget ?? const SizedBox(),
        ],
      ),
    );
  }
}