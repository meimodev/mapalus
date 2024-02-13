import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    Key? key,
    this.isSelected = false,
    required this.name,
    required this.onPressed,
    required this.imageUrl,  this.asset,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onPressed;
  final String name;
  final String imageUrl;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(12.w),
      child: InkWell(
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 400));
          onPressed();
        },
        child: SizedBox(
          width: 75.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    color: isSelected ? PaletteTheme.accent : PaletteTheme.cardForeground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.sp),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CustomImage(
                    imageUrl: imageUrl,
                    assetPath: asset,
                  ),
                ),
              ),
              SizedBox(height: Insets.small.h * .5),
              SizedBox(
                child: Text(
                  name,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                        fontSize: 12.sp,
                        color: isSelected ? PaletteTheme.textPrimary : Colors.grey,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}