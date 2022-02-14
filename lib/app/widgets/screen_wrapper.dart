import 'package:flutter/material.dart';
import 'package:mapalus/shared/theme.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor ?? Palette.scaffold,
      body: child,
    ));
  }
}