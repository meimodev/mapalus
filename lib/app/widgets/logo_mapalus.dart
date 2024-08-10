import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class LogoMapalus extends StatelessWidget {
  const LogoMapalus({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/mapalus.svg",
      width: width ?? BaseSize.w48,
      height: height ?? BaseSize.h48,
      colorFilter: BaseColor.primary3.filterSrcIn,
    );
  }
}
