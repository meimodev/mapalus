import 'package:flutter/material.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: child,
      ),
    );
  }
}