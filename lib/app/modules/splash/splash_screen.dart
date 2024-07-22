import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void wait(onProceed) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    onProceed();
  }

  @override
  void initState() {
    super.initState();
    wait(() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: BaseColor.accent,
        child: Center(
          child: SvgPicture.asset(
            'assets/images/mapalus.svg',
            width: 90.sp,
            height: 90.sp,
            colorFilter: const ColorFilter.mode(
              BaseColor.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
