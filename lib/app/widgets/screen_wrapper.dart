import 'package:flutter/material.dart';
import 'package:mapalus/shared/theme.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Palette.scaffold,
      body: child,
    ));
  }
}