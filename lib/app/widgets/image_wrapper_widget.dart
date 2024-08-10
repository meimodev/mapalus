import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class ImageWrapperWidget extends StatelessWidget {
  const ImageWrapperWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: BaseSize.customWidth(76),
      height: BaseSize.customWidth(76),
      decoration: BoxDecoration(
        color: BaseColor.secondaryText.withOpacity(.5),
        borderRadius: BorderRadius.circular(
          BaseSize.roundnessMedium,
        ),
      ),
      child: Center(
        child: LogoMapalus(
          height: BaseSize.w12,
          width: BaseSize.w12,
        ),
      ),
    );
  }
}
