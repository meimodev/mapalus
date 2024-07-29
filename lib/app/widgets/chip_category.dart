import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class ChipCategory extends StatelessWidget {
  const ChipCategory({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BaseColor.accent,
        borderRadius: BorderRadius.circular(BaseSize.roundnessMedium),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w8,
            vertical: BaseSize.w4,
          ),
          child: Text(
            title,
            style: BaseTypography.labelSmall.toPrimary,
          ),
        ),
      ),
    );
  }
}
