import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class DialogAnnouncement extends StatelessWidget {
  const DialogAnnouncement({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  final Announcement announcement;

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
              announcement.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: Insets.small.h),
            announcement.imageUrl.isNotEmpty
                ? SizedBox(
                    height: 150,
                    child: CustomImage(
                      imageUrl: announcement.imageUrl,
                    ),
                  )
                : const SizedBox(),
            announcement.imageUrl.isNotEmpty
                ? SizedBox(height: Insets.small.h)
                : const SizedBox(),
            Text(
              announcement.description,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: Insets.small.h),
            Material(
              borderRadius: BorderRadius.circular(12),
              color: PaletteTheme.accent,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.small * 1.5,
                    vertical: Insets.small,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: PaletteTheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
