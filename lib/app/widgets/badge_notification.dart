import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class BadgeNotification extends StatelessWidget {
  const BadgeNotification({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.sp,
      width: 21.sp,
      decoration: const BoxDecoration(
        color: BaseColor.notification,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style:TextStyle(
                fontSize: 11.sp,
                color: BaseColor.cardForeground,
              ),
        ),
      ),
    );
  }
}