import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class ButtonMapalus extends StatelessWidget {
  const ButtonMapalus({
    super.key,
    required this.count,
    required this.onPressed,
  });

  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Badge(
      // elevation: 0,
      label: Center(
        child: Text(
          count.toString(),
          style: BaseTypography.bodySmall.toWhite,
        ),
      ),
      // padding: EdgeInsets.all(6.sp),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: BaseColor.accent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(6),
            height: BaseSize.w32,
            width: BaseSize.w32,
            child: SvgPicture.asset(
              'assets/images/mapalus_logo.svg',
              height: BaseSize.w12,
              width: BaseSize.w12,
              colorFilter: BaseColor.primary3.filterSrcIn,
            ),
          ),
        ),
      ),
    );
  }
}
