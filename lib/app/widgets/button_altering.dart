import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class ButtonAltering extends StatelessWidget {
  const ButtonAltering({
    super.key,
    required this.onPressed,
    required this.label,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final String label;
  final bool enabled;

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
          width: BaseSize.customWidth(22),
          height: BaseSize.customWidth(22),
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
