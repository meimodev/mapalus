import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

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
        color: PaletteTheme.notification,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style:TextStyle(
                fontSize: 11.sp,
                color: PaletteTheme.cardForeground,
              ),
        ),
      ),
    );
  }
}