import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class TextInputQuantity extends StatelessWidget {
  const TextInputQuantity({
    super.key,
    this.icon,
    this.onTextChanged,
    required this.textEditingController,
    this.isReadOnly = false,
    this.trailingWidget,
  });

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
        color: BaseColor.editable,
        borderRadius: BorderRadius.circular(6.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: BaseSize.w12),
          icon != null
              ? SizedBox(
                  height: 45.h,
                  width: 12.w,
                  child: icon,
                )
              : const SizedBox(),
          SizedBox(width: BaseSize.w12 * .5),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: onTextChanged,
              keyboardType: TextInputType.number,
              maxLines: 1,
              autocorrect: false,
              readOnly: isReadOnly,
              style: TextStyle(
                color: BaseColor.accent,
                fontFamily: fontFamily,
                fontSize: 14.sp,
              ),
              cursorColor: BaseColor.primary3,
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
