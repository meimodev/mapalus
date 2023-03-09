import 'package:flutter/material.dart'hide Badge;
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart' ;


class CardSearchBar extends StatelessWidget {
  const CardSearchBar({
    Key? key,
    required this.onSubmitted,
    required this.onLogoPressed,
    required this.notificationBadgeCount,
    this.onTap,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  final Function(String value) onSubmitted;
  final Function(String value) onChanged;
  final VoidCallback onLogoPressed;
  final int notificationBadgeCount;
  final TextEditingController? controller;

  final VoidCallback? onTap;

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
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),                  ),
                  SizedBox(width: Insets.small.w * 1),
                  Flexible(
                    child: TextField(
                      controller: controller,
                      onSubmitted: onSubmitted,
                      onTap: onTap,
                      onChanged: onChanged,
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
            Badge(
              // elevation: 0,
              showBadge: notificationBadgeCount > 0,
              badgeContent: Center(
                child: Text(
                  notificationBadgeCount.toString(),
                  style: TextStyle(
                        fontSize: 10.sp,
                        color: Palette.editable,
                      ),
                ),
              ),
              // padding: EdgeInsets.all(6.sp),
              child: Material(
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
                      colorFilter: const ColorFilter.mode(
                        Palette.primary,
                        BlendMode.srcIn,
                      ),
                    ),
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