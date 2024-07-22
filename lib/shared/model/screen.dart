import 'package:flutter/material.dart';

class Screen {
  final String title;
  final Widget widget;
  final IconData iconData;
  final IconData? activeIconData;

  Screen( {
    required this.title,
    required this.widget,
    required this.iconData,
    this.activeIconData,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Screen &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          widget == other.widget &&
          iconData == other.iconData &&
          activeIconData == other.activeIconData;

  @override
  int get hashCode =>
      title.hashCode ^
      widget.hashCode ^
      iconData.hashCode ^
      activeIconData.hashCode;
}
