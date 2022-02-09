import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/shared/theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    this.isAvailable = true,
    this.onPressed,
  }) : super(key: key);

  final String name;
  final String price;
  final String image;
  final bool isAvailable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      color: Palette.cardForeground,
      child: InkWell(
        onTap: onPressed ??
            () {
              showDialog(
                context: context,
                builder: (_) => ItemDetailDialog(isAvailable: isAvailable),
              );
            },
        child: Padding(
          padding: EdgeInsets.all(Insets.small.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isAvailable
                  ? const SizedBox()
                  : Row(
                      children: [
                        SvgPicture.asset(
                          'assets/vectors/min.svg',
                          height: 15.sp,
                          width: 15.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: Insets.small.w * .5),
                        Text(
                          "Tidak Tersedia",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                    fontSize: 11.sp,
                                  ),
                        ),
                      ],
                    ),
              SizedBox(height: Insets.small.h * 1.5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: .25,
                        blurRadius: 10,
                        color: isAvailable
                            ? Palette.primary.withOpacity(.125)
                            : Colors.grey.withOpacity(.125),
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Insets.small.h * 1.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w300,
                          color:
                              isAvailable ? Palette.textPrimary : Colors.grey,
                        ),
                  ),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w300,
                          color:
                              isAvailable ? Palette.textPrimary : Colors.grey,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDetailDialog extends StatelessWidget {
  const ItemDetailDialog({Key? key, required this.isAvailable})
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
        QuantityAlterButton(
          label: "-",
          onPressed: onSub,
        ),
        SizedBox(width: 3.w),
        QuantityAlterButton(
          label: "+",
          onPressed: onAdd,
        ),
        SizedBox(width: 3.w),
        QuantityTextInput(
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

class QuantityAlterButton extends StatelessWidget {
  const QuantityAlterButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.primary,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 45.w,
          height: 45.h,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuantityTextInput extends StatelessWidget {
  const QuantityTextInput({Key? key, this.icon, this.onTextChanged})
      : super(key: key);

  final Widget? icon;
  final Function(String text)? onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: Palette.editable,
        borderRadius: BorderRadius.circular(6.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: Insets.small.w),
          icon != null
              ? SizedBox(
                  height: 45.h,
                  width: 12.w,
                  child: icon,
                )
              : const SizedBox(),
          SizedBox(width: Insets.small.w * .75),
          Expanded(
            child: TextField(
              onChanged: onTextChanged,
              maxLines: 1,
              autocorrect: false,
              style: TextStyle(
                color: Palette.accent,
                fontFamily: fontFamily,
                fontSize: 14.sp,
              ),
              cursorColor: Palette.primary,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.sp,
                ),
                isDense: true,
                border: InputBorder.none,
                hintText: "...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}