import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoMeimo extends StatelessWidget {
  const LogoMeimo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/images/logo_meimo.svg",
          width: BaseSize.w32,
        ),
        Gap.w3,
        Text(
          '©${DateTime.now().year}',
          style: BaseTypography.headlineSmall,
        ),
      ],
    );
  }
}
