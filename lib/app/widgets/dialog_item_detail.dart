import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/app/widgets/text_input_quantity.dart';
import 'package:mapalus/shared/theme.dart';

import 'button_alter_quantity.dart';

class DialogItemDetail extends StatelessWidget {
  const DialogItemDetail({Key? key, required this.isAvailable})
      : super(key: key);

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        alignment: Alignment.center,
        height: 600.h,
        width: 300.w,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                  color: Palette.cardForeground,
                ),
                height: 500.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 135.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.medium.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Extremely Complete Product name can be in two line',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                            ),
                            SizedBox(height: Insets.small.h),
                            Text(
                              'Rp. 999.000.000 / gram',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            SizedBox(height: Insets.medium.h),
                            Text(
                              'Description if available ora any other things that available to make the item detail modal look richer',
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                            ),
                            Expanded(
                              child: isAvailable
                                  ? _buildAvailableWidgets(context)
                                  : _buildUnavailableWidgets(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: isAvailable ? Palette.primary : Palette.editable,
                      borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: Insets.small.h),
                          child: Center(
                            child: Text(
                              isAvailable ? "Masukkan Keranjang" : "Kembali",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: isAvailable
                                        ? Palette.textPrimary
                                        : Colors.grey,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 210.h,
                width: 210.w,
                foregroundDecoration: !isAvailable
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(.5),
                      )
                    : null,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.accent,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: .5,
                        blurRadius: 15,
                        color: Colors.grey.withOpacity(.5),
                        offset: const Offset(3, 5),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableWidgets(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuantityRow(
          context: context,
          valueLabel: 'gram',
          icon: SvgPicture.asset(
            'assets/vectors/gram.svg',
            width: 15.sp,
            height: 15.sp,
            color: Palette.accent,
          ),
          onValueChanged: (value) {},
          onAdd: () {},
          onSub: () {},
        ),
        SizedBox(height: 9.h),
        _buildQuantityRow(
          context: context,
          valueLabel: 'rupiah',
          icon: SvgPicture.asset(
            'assets/vectors/money.svg',
            width: 15.sp,
            height: 15.sp,
            color: Palette.accent,
          ),
          onValueChanged: (value) {},
          onAdd: () {},
          onSub: () {},
        )
      ],
    );
  }

  Widget _buildUnavailableWidgets(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Produk sedang tidak tersedia",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        SizedBox(height: 15.h),
        SvgPicture.asset(
          "assets/vectors/empty.svg",
          width: 60.sp,
          height: 60.sp,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildQuantityRow({
    required BuildContext context,
    required Widget icon,
    required String valueLabel,
    required Function(String value) onValueChanged,
    required VoidCallback onAdd,
    required VoidCallback onSub,
  }) {
    return Row(
      children: [
        ButtonAlterQuantity(
          label: "-",
          onPressed: onSub,
        ),
        SizedBox(width: 3.w),
        ButtonAlterQuantity(
          label: "+",
          onPressed: onAdd,
        ),
        SizedBox(width: 3.w),
        TextInputQuantity(
          icon: icon,
          onTextChanged: onValueChanged,
        ),
        SizedBox(width: 6.w),
        Text(
          valueLabel,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
      ],
    );
  }
}