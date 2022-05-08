import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapalus/app/widgets/custom_image.dart';
import 'package:mapalus/shared/theme.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    Key? key,
    this.isSelected = false,
    required this.name,
    required this.onPressed,
    required this.imageUrl,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onPressed;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45.w,
          width: 45.w,
          child: Material(
            color: isSelected ? Palette.accent : Palette.cardForeground,
            elevation: isSelected ? 0 : 3,
            borderRadius: BorderRadius.all(
              Radius.circular(12.sp),
            ),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: onPressed,
              child: CustomImage(
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
        SizedBox(height: Insets.small.h * .5),
        SizedBox(
          width: 75,
          child: Text(
            name,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12.sp,
                  color: isSelected ? Palette.textPrimary : Colors.grey,
                ),
          ),
        ),
      ],
    );
  }
}