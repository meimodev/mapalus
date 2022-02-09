import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/shared/theme.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,
    required this.onSubmitted,
    required this.onLogoPressed,
  }) : super(key: key);

  final Function(String value) onSubmitted;
  final VoidCallback onLogoPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.editable,
        borderRadius: BorderRadius.circular(Roundness.large.sp),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Insets.small.h * .5,
        horizontal: Insets.small.h * .5,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Insets.small.w * .25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: Insets.small.w * .5),
                  SvgPicture.asset(
                    'assets/vectors/search.svg',
                    height: 15.sp,
                    width: 15.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(width: Insets.small.w * 1),
                  Flexible(
                    child: TextField(
                      onSubmitted: onSubmitted,
                      maxLines: 1,
                      autocorrect: false,
                      style: TextStyle(
                        color: Palette.accent,
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                      ),
                      cursorColor: Palette.primary,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12.sp,
                        ),
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Cari Produk ...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Insets.small.w * .5),
            Material(
              shape: const CircleBorder(),
              color: Palette.accent,
              child: InkWell(
                onTap: onLogoPressed,
                child: Container(
                  padding: EdgeInsets.all(6.sp),
                  height: 33.sp,
                  width: 33.sp,
                  child: SvgPicture.asset(
                    'assets/images/mapalus_logo.svg',
                    height: 12.sp,
                    width: 12.sp,
                    color: Palette.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}