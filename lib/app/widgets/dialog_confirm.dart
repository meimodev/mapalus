import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({
    Key? key,
    required this.onPressedConfirm,
    this.title,
    this.description,
    this.confirmText,
  }) : super(key: key);

  final VoidCallback onPressedConfirm;
  final String? title;
  final String? description;
  final String? confirmText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(
          top: Insets.medium.h,
          left: Insets.medium.w,
          right: Insets.medium.w,
          bottom: Insets.small.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? 'Perhatian !',
              style: TextStyle(
                    fontSize: 16.sp,
                  ),
            ),
            SizedBox(height: Insets.small.h),
            Text(
              description ?? '',
              style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            SizedBox(height: Insets.medium.h),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Material(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: InkWell(
                    onTap: () {
                      onPressedConfirm();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.small.w,
                        vertical: Insets.small.h * .5,
                      ),
                      child: Center(
                        child: Text(
                          confirmText ?? 'HAPUS',
                          style:
                          const TextStyle(
                                    color: Palette.primary,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}