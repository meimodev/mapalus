import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardNavigation extends StatelessWidget {
  const CardNavigation({
    super.key,
    required this.title,
    this.onPressedBack,
    this.isInverted = false,
    this.isCircular = false,
    this.padding,
  });

  final String title;
  final bool isInverted;
  final bool isCircular;
  final VoidCallback? onPressedBack;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isInverted ? BaseColor.accent : BaseColor.white,
      elevation: isInverted ? 0 : 6,
      shadowColor: isInverted ? null : Colors.grey.withOpacity(.125),
      // shape: isCircular ? const CircleBorder() : null,
      child: InkWell(
        onTap: onPressedBack ?? () => Navigator.pop(context),
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(horizontal: BaseSize.w24),
          height: BaseSize.customHeight(60),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Ionicons.chevron_back_circle_outline,
                  weight: 2,
                  size: BaseSize.customRadius(30),
                  color: isInverted ? BaseColor.white : BaseColor.primaryText,
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color:
                        isInverted ? BaseColor.editable : BaseColor.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
