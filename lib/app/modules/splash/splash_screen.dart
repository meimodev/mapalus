import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/app/widgets/wrapper_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WrapperScreen(
      child: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}