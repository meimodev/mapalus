// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

Future<double?> showBottomSheetRate({
  required BuildContext context,
}) {
  return showDialogCustomWidget<double?>(
    context: context,
    title: 'YES! Pesanan selesai',
    content: BottomSheetRateWidget(
      onPressed: (value) {
        Navigator.pop<double?>(context, value);
      },
    ),
  );
}

class BottomSheetRateWidget extends StatefulWidget {
  const BottomSheetRateWidget({
    super.key,
    required this.onPressed,
  });

  final void Function(double? rating) onPressed;

  @override
  State<BottomSheetRateWidget> createState() => _BottomSheetRateWidgetState();
}

class _BottomSheetRateWidgetState extends State<BottomSheetRateWidget> {
  double? rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          maxRating: 5,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: BaseSize.w6),
          onRatingUpdate: (value) {
            setState(() {
              rating = value;
            });
          },
          glow: false,
          itemBuilder: (_, int index) => SvgPicture.asset(
            'assets/vectors/star.svg',
            colorFilter: const ColorFilter.mode(
              BaseColor.primary3,
              BlendMode.srcIn,
            ),
          ),
          unratedColor: BaseColor.accent.withOpacity(.125),
        ),
        Gap.h24,
        ButtonWidget(
          text: "Nilai Pesanan",
          onPressed: () => widget.onPressed(rating),
          enable: rating != null,
        ),
      ],
    );
  }
}
