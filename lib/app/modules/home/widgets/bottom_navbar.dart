import 'package:flutter/material.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onPressed,
    required this.screens,
  });

  final int activeIndex;
  final void Function(int activeIndex) onPressed;
  final List<Screen> screens;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.screens.map(
        (e) {
          final index = widget.screens.indexOf(e);
          final active = index == activeIndex;
          return Expanded(
            child: Material(
              color: BaseColor.accent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    activeIndex = index;
                  });
                  widget.onPressed(index);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: BaseSize.radiusMd,
                    horizontal: BaseSize.radiusSm,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? e.activeIconData ?? e.iconData : e.iconData,
                        size: BaseSize.customRadius(25),
                        color: active
                            ? BaseColor.primary3
                            : BaseColor.cardBackground1,
                      ),
                      Gap.h4,
                      Text(
                        e.title,
                        style: BaseTypography.bodySmall.copyWith(
                          color: active
                              ? BaseColor.primary3
                              : BaseColor.cardBackground1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
