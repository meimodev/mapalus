import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/app/widgets/custom_image.dart';
import 'package:mapalus/app/widgets/text_input_quantity.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:mapalus/shared/utils.dart';

import 'button_alter_quantity.dart';

class DialogItemDetail extends StatefulWidget {
  const DialogItemDetail({
    Key? key,
    required this.product,
    required this.onPressedAddToCart,
  }) : super(key: key);

  final Product product;
  final Function(ProductOrder) onPressedAddToCart;

  @override
  State<DialogItemDetail> createState() => _DialogItemDetailState();
}

class _DialogItemDetailState extends State<DialogItemDetail> {
  TextEditingController tecUnit = TextEditingController();
  TextEditingController tecPrice = TextEditingController();

  late int initAmount;

  late int additionAmountUnit;

  late int additionAmountPrice;

  late StreamSubscription<bool> keyboardSubs;

  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    initAmount = 1;
    additionAmountUnit = 1;
    additionAmountPrice = widget.product.price;

    tecUnit.text = initAmount.toString();
    tecPrice.text = widget.product.price.toString();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubs = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    tecUnit.dispose();
    tecPrice.dispose();
    keyboardSubs.cancel();
    super.dispose();
  }

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
                    isKeyboardVisible
                        ? SizedBox(height: 230.h)
                        : SizedBox(height: 135.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.medium.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  widget.product.name,
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
                                  '${widget.product.priceF} / ${widget.product.unit}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                      ),
                                ),
                                isKeyboardVisible
                                    ? const SizedBox()
                                    : SizedBox(height: Insets.medium.h),
                                isKeyboardVisible
                                    ? const SizedBox()
                                    : Text(
                                        widget.product.description,
                                        maxLines: 4,
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
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: isKeyboardVisible ? 0 : Insets.medium.h,
                                bottom: Insets.medium.h,
                              ),
                              child: widget.product.isAvailable
                                  ? _buildAvailableWidgets(context)
                                  : _buildUnavailableWidgets(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: widget.product.isAvailable
                          ? Palette.primary
                          : Palette.editable,
                      borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                      child: InkWell(
                        onTap: () {
                          if (widget.product.isAvailable) {
                            widget.onPressedAddToCart(
                              ProductOrder(
                                product: widget.product,
                                quantity: double.parse(tecUnit.text),
                                totalPrice: double.parse(tecPrice.text),
                              ),
                            );
                          }
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: Insets.small.h),
                          child: Center(
                            child: Text(
                              widget.product.isAvailable
                                  ? "Masukkan Keranjang"
                                  : "Kembali",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: widget.product.isAvailable
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
                clipBehavior: Clip.hardEdge,
                height: 210.h,
                width: 210.w,
                foregroundDecoration: !widget.product.isAvailable
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
                  ],
                ),
                child: CustomImage(imageUrl: widget.product.imageUrl),
              ),
            ),
          ],
        ),
      ),
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

  _onChangeValue({required bool isFromPrice}) {
    String t1 = tecUnit.text;
    String t2 = tecPrice.text;

    double gram = 0;
    double price = 0;
    try {
      gram = double.parse(t1);
      price = double.parse(t2);
    } catch (e) {
      gram = 0;
      price = 0;
    }

    if (isFromPrice) {
      double g = price / widget.product.price;
      String s = g.toStringAsFixed(2);
      if (s.contains(".00")) {
        s = s.substring(0, s.length - 3);
      }
      tecUnit.text = s;
    } else {
      tecPrice.text = (gram * widget.product.price).floor().toString();
    }
    // print('gram = ${tecGram.text} price = ${tecPrice.text}');
  }

  _adding(int amount, TextEditingController controller, bool isFromPrice) {
    late int cur;
    try {
      cur = int.parse(controller.text);
    } catch (_) {
      cur = 0;
    }
    if (amount < 0 && cur + amount <= 0) {
      amount = 0;
    }
    controller.text = (cur + amount).toString();
    _onChangeValue(isFromPrice: isFromPrice);
  }

  Widget _buildAvailableWidgets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildQuantitySuggestionRow(),
        _buildQuantityRow(
          context: context,
          valueLabel: widget.product.unit,
          isCustomPrice: true,
          icon: SvgPicture.asset(
            'assets/vectors/gram.svg',
            width: 15.sp,
            height: 15.sp,
            color: Palette.accent,
          ),
          textEditingController: tecUnit,
          onValueChanged: (value) {
            _onChangeValue(isFromPrice: false);
          },
          onAdd: () {
            _adding(additionAmountUnit, tecUnit, false);
          },
          onSub: () {
            _adding(-additionAmountUnit, tecUnit, false);
          },
        ),
        SizedBox(height: 9.h),
        _buildQuantityRow(
          context: context,
          valueLabel: 'Rp',
          isCustomPrice: widget.product.isCustomPrice,
          icon: SvgPicture.asset(
            'assets/vectors/money.svg',
            width: 15.sp,
            height: 15.sp,
            color: Palette.accent,
          ),
          textEditingController: tecPrice,
          onValueChanged: (value) {
            _onChangeValue(isFromPrice: true);
          },
          onAdd: () {
            _adding(additionAmountPrice, tecPrice, true);
          },
          onSub: () {
            _adding(-additionAmountPrice, tecPrice, true);
          },
        )
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
    required TextEditingController textEditingController,
    bool isCustomPrice = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextInputQuantity(
          icon: icon,
          onTextChanged: onValueChanged,
          textEditingController: textEditingController,
          isReadOnly: !isCustomPrice,
          trailingWidget: Row(
            children: [
              SizedBox(width: 3.w),
              Text(
                valueLabel,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(width: Insets.small.w),
            ],
          ),
        ),
        // Text(
        //   valueLabel,
        //   style: Theme.of(context).textTheme.bodyText1?.copyWith(
        //         fontWeight: FontWeight.w300,
        //       ),
        // ),
        SizedBox(width: 3.w),

        ButtonAlterQuantity(
          label: "-",
          onPressed: onSub,
          isEnabled: isCustomPrice,
        ),
        SizedBox(width: 3.w),
        ButtonAlterQuantity(
          label: "+",
          onPressed: onAdd,
          isEnabled: isCustomPrice,
        ),
      ],
    );
  }

  _buildQuantitySuggestionRow() {
    // if unit == kilogram then display the decimals kilos
    // if customPrice than show prices 1.5x, 2x, 2.5x,

    final decimalKilosDesc = [
      _buildQuantitySuggestionChip("0.75 ${widget.product.unit}"),
      _buildQuantitySuggestionChip("0.5 ${widget.product.unit}"),
      _buildQuantitySuggestionChip("0.25 ${widget.product.unit}"),
    ];

    final decimalKilosAsc = [
      _buildQuantitySuggestionChip("100 ${widget.product.unit}"),
      _buildQuantitySuggestionChip("200 ${widget.product.unit}"),
      _buildQuantitySuggestionChip("500 ${widget.product.unit}"),
    ];

    final multiplePrices = [
      _buildQuantitySuggestionChip(
          Utils.formatNumberToCurrency(widget.product.price * 1.5)),
      _buildQuantitySuggestionChip(
          Utils.formatNumberToCurrency(widget.product.price * 2)),
      _buildQuantitySuggestionChip(
          Utils.formatNumberToCurrency(widget.product.price * 2.5)),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...widget.product.unit.toLowerCase().contains("kg")
              ? decimalKilosDesc
              : [],
          ...widget.product.unit.toLowerCase() == "gram" ? decimalKilosAsc : [],
          ...widget.product.isCustomPrice ? multiplePrices : [],
        ],
      ),
    );
  }

  _buildQuantitySuggestionChip(String text) {
    bool isPrice = text.contains("Rp.");

    return Padding(
      padding: EdgeInsets.only(
        bottom: Insets.small.h * .75,
        left: Insets.small.w * .25,
        right: Insets.small.w * .25,
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        // color: Palette.primary,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Palette.primary,
              width: 1.5,
            )),
        child: InkWell(
          onTap: () {
            if (isPrice) {
              tecPrice.text =
                  Utils.formatCurrencyToNumber(text).toInt().toString();
              _onChangeValue(isFromPrice: isPrice);
              return;
            }
            tecUnit.text = text.replaceAll(RegExp(r'[a-zA-Z]'), '');
            _onChangeValue(isFromPrice: isPrice);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Insets.small.w * .75,
              vertical: Insets.small.h * .25,
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 8.sp,
                    color: Palette.primary,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}