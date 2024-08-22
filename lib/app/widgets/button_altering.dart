import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class ButtonAltering extends StatelessWidget {
  const ButtonAltering({
    super.key,
    required this.onPressed,
    required this.label,
    this.height,
    this.width,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final String label;
  final bool enabled;

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? BaseColor.accent : Colors.grey.shade400,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
          BaseSize.roundnessMedium,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        child: SizedBox(
          width: width ?? BaseSize.customWidth(22),
          height: height ?? BaseSize.customWidth(22),
          child: Center(
            child: Text(
              label,
              style: BaseTypography.caption.copyWith(
                color:  enabled ? BaseColor.primary3 : BaseColor.primaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
