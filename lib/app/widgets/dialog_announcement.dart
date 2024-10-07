// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

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
          top: BaseSize.h24,
          left: BaseSize.w24,
          right: BaseSize.w24,
          bottom: BaseSize.h12,
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
            SizedBox(height: BaseSize.h12),
            announcement.imageUrl.isNotEmpty
                ? SizedBox(
                    height: 150,
                    child: CustomImage(
                      imageUrl: announcement.imageUrl,
                    ),
                  )
                : const SizedBox(),
            announcement.imageUrl.isNotEmpty
                ? SizedBox(height: BaseSize.h12)
                : const SizedBox(),
            Text(
              announcement.description,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: BaseSize.h12),
            Material(
              borderRadius: BorderRadius.circular(12),
              color: BaseColor.accent,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: BaseSize.w12 * 1.5,
                    vertical: BaseSize.h12,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: BaseColor.primary3,
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
