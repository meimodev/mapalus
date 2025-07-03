import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardOrderInfo extends StatelessWidget {
  const CardOrderInfo({
    super.key,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.onLongPressed,
    this.child,
  });

  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? BaseColor.primary3.withValues(alpha: .25),
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(BaseSize.radiusMd),
          side: BorderSide(
            color: borderColor ?? BaseColor.primary3,
          )),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.w12,
          ),
          child: Column(
            children: [
              text != null
                  ? Text(
                      text!,
                      style: BaseTypography.bodySmall,
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
              child == null ? const SizedBox() : Gap.h4,
              child != null ? child! : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
