import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BaseSize.radiusMd),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: BaseSize.customWidth(90),
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              Gap.h4,
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: BaseTypography.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
