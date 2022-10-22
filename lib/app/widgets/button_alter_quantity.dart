import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class ButtonAlterQuantity extends StatelessWidget {
  const ButtonAlterQuantity(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.isEnabled = true})
      : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isEnabled ? Palette.primary : Colors.grey.shade300,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        child: SizedBox(
          width: 45.w,
          height: 45.h,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 19.sp,
                    color:
                        isEnabled ? Palette.textPrimary : Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}