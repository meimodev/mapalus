import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/shared/theme.dart';

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
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 16.sp,
                  ),
            ),
            SizedBox(height: Insets.small.h),
            Text(
              description ?? '',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
                              Theme.of(context).textTheme.bodyText1?.copyWith(
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