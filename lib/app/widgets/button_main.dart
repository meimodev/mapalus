import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class ButtonMain extends StatelessWidget {
  const ButtonMain({
    super.key,
    required this.title,
    this.onPressed,
    this.enable = true,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BaseSize.radiusMd),
      clipBehavior: Clip.hardEdge,
      color: enable ? BaseColor.primary3 : BaseColor.disabled,
      elevation: 4,
      child: InkWell(
        onTap: enable ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w24,
            vertical: BaseSize.h12,
          ),
          child: Center(
            child: Text(
              title,
              style: BaseTypography.bodyMedium.copyWith(
                  color: enable
                      ? BaseColor.primaryText
                      : BaseColor.primaryText.withValues(alpha: .5)),
            ),
          ),
        ),
      ),
    );
  }
}
