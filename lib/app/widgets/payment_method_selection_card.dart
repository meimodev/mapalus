import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class PaymentMethodSelectionCard extends StatelessWidget {
  const PaymentMethodSelectionCard({
    super.key,
    required this.title,
    this.subTitle,
    required this.onPressed,
    this.activate = false,
    this.available = true,
    this.child,
  });

  final String title;
  final String? subTitle;
  final VoidCallback onPressed;
  final bool activate;
  final bool available;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.small.h * .5),
      child: Material(
        color: available ? Colors.grey.shade200 : Colors.grey.shade300,
        clipBehavior: Clip.hardEdge,
        shape: ContinuousRectangleBorder(
          side: activate
              ? const BorderSide(color: BaseColor.primary, width: 1.5)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: InkWell(
          onTap: available ? onPressed : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Insets.small.h,
              horizontal: Insets.small.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                        color: available ? BaseColor.textPrimary : Colors.grey.shade400,
                        fontSize: 12.sp,
                      ),
                ),
                subTitle != null
                    ? Text(
                        subTitle!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: available ? Colors.grey : Colors.grey.shade400,
                            ),
                      )
                    : const SizedBox(),
                child ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
