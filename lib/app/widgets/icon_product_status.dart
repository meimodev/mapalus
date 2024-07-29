import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class IconProductStatus extends StatelessWidget {
  const IconProductStatus({
    super.key,
    required this.text,
    this.textColor,
  });

  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(BaseSize.roundnessSmall),
      decoration: const BoxDecoration(
        color: BaseColor.accent,
        shape: BoxShape.circle,
      ),
      child: Text(
        text,
        style: BaseTypography.bodySmall.toPrimary.bold,
      ),
    );
  }
}
