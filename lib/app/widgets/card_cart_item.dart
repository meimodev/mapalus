import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/shared/theme.dart';

class CardCartItem extends StatelessWidget {
  const CardCartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Insets.medium.w * .5,
        vertical: Insets.small.h * .5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.medium.w * .5,
        vertical: Insets.small.h,
      ),
      decoration: BoxDecoration(
          color: Palette.cardForeground,
          borderRadius: BorderRadius.circular(9.sp)),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
            child: Text(
              "99",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          SizedBox(width: Insets.small.w),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Complete Product Name",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                "Rp. 999.000 / gram",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
              ),
              SizedBox(height: 6.h),
              _buildAlterRowItem(
                context: context,
                onAdd: () {},
                onSub: () {},
                value: 'gram',
              ),
              SizedBox(height: 6.h),
              _buildAlterRowItem(
                context: context,
                onAdd: () {},
                onSub: () {},
                value: 'rupiah',
              ),
            ],
          )),
          SizedBox(width: Insets.small.w),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: 60.h,
                width: 30.w,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/vectors/cross.svg',
                    width: 21.sp,
                    height: 21.sp,
                    color: Palette.negative,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAlterRowItem({
    required BuildContext context,
    required String value,
    required VoidCallback onAdd,
    required VoidCallback onSub,
  }) {
    return Row(
      children: [
        Container(
          width: 93.w,
          height: 30.h,
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
          ),
          decoration: BoxDecoration(
            color: Palette.editable,
            borderRadius: BorderRadius.circular(3.sp),
          ),
          child: TextField(
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
                  color: Colors.grey,
                  fontFamily: fontFamily,
                  fontSize: 12.sp,
                ),
                isDense: true,
                border: InputBorder.none,
                hintText: value,
                suffix: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                )),
          ),
        ),
        SizedBox(width: 6.w),
        _buildQuantityAlterButton(
          context: context,
          title: '-',
          onPressed: onAdd,
        ),
        SizedBox(width: 6.w),
        _buildQuantityAlterButton(
          context: context,
          title: '+',
          onPressed: onSub,
        ),
      ],
    );
  }

  _buildQuantityAlterButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String title,
  }) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Palette.editable,
      borderRadius: BorderRadius.circular(3.sp),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 30.h,
          width: 30.h,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}