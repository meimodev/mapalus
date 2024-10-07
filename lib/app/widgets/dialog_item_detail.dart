// ignore_for_file: use_super_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/text_input_quantity.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

import 'button_altering.dart';

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

  String errorMessagePrice = "";

  @override
  void initState() {
    super.initState();
    initAmount = 1;
    additionAmountUnit = 1;
    additionAmountPrice = widget.product.price.toInt();

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
        height: 610.h,
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
                  color: BaseColor.cardBackground1,
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
                          horizontal: BaseSize.w24,
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                isKeyboardVisible
                                    ? const SizedBox()
                                    : SizedBox(height: BaseSize.h12),
                                Text(
                                  '${widget.product.price} / ${widget.product.unit}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                isKeyboardVisible
                                    ? const SizedBox()
                                    : SizedBox(height: BaseSize.h24),
                                isKeyboardVisible
                                    ? const SizedBox()
                                    : Text(
                                        widget.product.description,
                                        maxLines: 4,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: isKeyboardVisible ? 0 : BaseSize.h24,
                                bottom: BaseSize.h24,
                              ),
                              child: widget.product.status!.isAvailable
                                  ? _buildAvailableWidgets(context)
                                  : _buildUnavailableWidgets(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: widget.product.status!.isAvailable
                          ? errorMessagePrice.isEmpty
                              ? BaseColor.primary3
                              : Colors.grey
                          : BaseColor.editable,
                      borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                      child: InkWell(
                        onTap: () {
                          if (errorMessagePrice.isNotEmpty) {
                            return;
                          }

                          if (widget.product.status!.isAvailable) {
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
                          padding: EdgeInsets.symmetric(vertical: BaseSize.h12),
                          child: Center(
                            child: Text(
                              widget.product.status!.isAvailable
                                  ? "Masukkan Keranjang"
                                  : "Kembali",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: widget.product.status!.isAvailable
                                    ? BaseColor.primaryText
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
                foregroundDecoration: !widget.product.status!.isAvailable
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(.5),
                      )
                    : null,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: BaseColor.accent,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: .5,
                      blurRadius: 15,
                      color: Colors.grey.withOpacity(.5),
                      offset: const Offset(3, 5),
                    ),
                  ],
                ),
                child: CustomImage(imageUrl: widget.product.image),
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
        const Text(
          "Produk sedang tidak tersedia",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 15.h),
        SvgPicture.asset(
          "assets/vectors/empty.svg",
          width: 60.sp,
          height: 60.sp,
          colorFilter: const ColorFilter.mode(
            Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  _onChangeValue({required bool isFromPrice}) {
    String t1 = tecUnit.text;
    String t2 = tecPrice.text;

    double gram = 0;
    double price = 0;

    setState(() {
      errorMessagePrice = "";
    });

    try {
      gram = double.parse(t1);
      price = double.parse(t2);
    } catch (e) {
      gram = 0;
      price = 0;
      setState(() {
        errorMessagePrice = "Gunakan angka 0 - 9 untuk mengisi";
      });
      return;
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

    final freshPrice = double.tryParse(tecPrice.text);
    if (freshPrice == null) {
      setState(() {
        errorMessagePrice = "Gunakan angka 0 - 9 untuk mengisi";
      });
      return;
    }
    final minimumPrice = widget.product.minimumPrice;
    if (minimumPrice > 0) {
      if (freshPrice < minimumPrice) {
        setState(() {
          errorMessagePrice =
              "Harga pembelian minimal ${minimumPrice.formatNumberToCurrency()}";
        });
      }
    }
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
        _buildQuantityCustomizableInfoRow(),
        _buildQuantitySuggestionRow(),
        _buildQuantityRow(
          context: context,
          valueLabel: widget.product.unit!.name,
          isCustomPrice: true,
          isReadOnly: !widget.product.customPrice,
          icon: SvgPicture.asset(
            'assets/vectors/gram.svg',
            width: 15.sp,
            height: 15.sp,
            colorFilter: const ColorFilter.mode(
              BaseColor.accent,
              BlendMode.srcIn,
            ),
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
        _buildErrorMinimumPriceRow(),
        _buildQuantityRow(
          context: context,
          valueLabel: 'Rp',
          isCustomPrice: widget.product.customPrice,
          isReadOnly: !widget.product.customPrice,
          icon: SvgPicture.asset(
            'assets/vectors/money.svg',
            width: 15.sp,
            height: 15.sp,
            colorFilter: const ColorFilter.mode(
              BaseColor.accent,
              BlendMode.srcIn,
            ),
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
    bool isReadOnly = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextInputQuantity(
          icon: icon,
          onTextChanged: onValueChanged,
          textEditingController: textEditingController,
          isReadOnly: !isCustomPrice || isReadOnly,
          trailingWidget: Row(
            children: [
              SizedBox(width: 3.w),
              Text(
                valueLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(width: BaseSize.w12),
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

        ButtonAltering(
          label: "-",
          onPressed: onSub,
          enabled: isCustomPrice,
        ),
        SizedBox(width: 3.w),
        ButtonAltering(
          label: "+",
          onPressed: onAdd,
          enabled: isCustomPrice,
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
          (widget.product.price * 1.5).formatNumberToCurrency()),
      _buildQuantitySuggestionChip(
          (widget.product.price * 2).formatNumberToCurrency()),
      _buildQuantitySuggestionChip(
          (widget.product.price * 2.5).formatNumberToCurrency()),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...widget.product.unit!.name.toLowerCase().contains("kg")
              ? decimalKilosDesc
              : [],
          ...widget.product.unit!.name.toLowerCase() == "gram"
              ? decimalKilosAsc
              : [],
          ...widget.product.customPrice ? multiplePrices : [],
        ],
      ),
    );
  }

  _buildQuantitySuggestionChip(String text) {
    bool isPrice = text.contains("Rp.");

    return Padding(
      padding: EdgeInsets.only(
        bottom: BaseSize.h12 * 1,
        left: BaseSize.w12 * .25,
        right: BaseSize.w12 * .25,
      ),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: BaseColor.primary3,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            if (isPrice) {
              tecPrice.text = text.formatCurrencyToNumber().toInt().toString();
              _onChangeValue(isFromPrice: isPrice);
              return;
            }
            tecUnit.text = text.replaceAll(RegExp(r'[a-zA-Z]'), '');
            _onChangeValue(isFromPrice: isPrice);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: BaseSize.w12 * .75,
              vertical: BaseSize.h12 * .25,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 8.sp,
                color: BaseColor.accent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildQuantityCustomizableInfoRow() {
    if (widget.product.customPrice) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "* Bisa ubah harga pembelian sesuai kebutuhan",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: BaseSize.h12 * .5),
        ],
      );
    }

    return const SizedBox();
  }

  _buildErrorMinimumPriceRow() {
    if (errorMessagePrice.isEmpty) {
      return SizedBox(height: BaseSize.h12);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 3.h),
        Text(
          errorMessagePrice,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: BaseColor.negative,
            fontSize: 9.sp,
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}
