import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapalus/app/widgets/text_input_quantity.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:transparent_image/transparent_image.dart';

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
  TextEditingController tecGram = TextEditingController();
  TextEditingController tecPrice = TextEditingController();

  late int initAmount;

  late int additionAmountUnit;

  late int additionAmountPrice;

  @override
  void initState() {
    initAmount = 1;
    additionAmountUnit = 1;
    additionAmountPrice = widget.product.price;

    tecGram.text = initAmount.toString();
    tecPrice.text = widget.product.price.toString();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tecGram.dispose();
    tecPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        alignment: Alignment.center,
        height: 570.h,
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
                height: 470.h,
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
                                SizedBox(height: Insets.medium.h),
                                Text(
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
                              padding: EdgeInsets.symmetric(
                                vertical: Insets.medium.h,
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
                                quantity: double.parse(tecGram.text),
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        color: Palette.primary,
                        strokeWidth: 1,
                      ),
                    ),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.product.imageUrl,
                      imageErrorBuilder: (context, _, __) {
                        return SvgPicture.asset(
                          'assets/images/mapalus.svg',
                          width: 60.w,
                          color: Palette.primary,
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
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

  Widget _buildAvailableWidgets(BuildContext context) {
    _onChangeValue(bool isFromPrice) {
      double gram = double.parse(tecGram.text);
      double price = double.parse(tecPrice.text);

      if (isFromPrice) {
        double g = price / widget.product.price;
        String s = g.toStringAsFixed(2);
        if (s.contains(".00")) {
          s = s.substring(0, s.length - 3);
        }
        tecGram.text = s;
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
      _onChangeValue(isFromPrice);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildQuantityRow(
          context: context,
          valueLabel: 'gram',
          isCustomPrice: true,
          icon: SvgPicture.asset(
            'assets/vectors/gram.svg',
            width: 15.sp,
            height: 15.sp,
            color: Palette.accent,
          ),
          textEditingController: tecGram,
          onValueChanged: (value) {
            _onChangeValue(false);
          },
          onAdd: () {
            _adding(additionAmountUnit, tecGram, false);
          },
          onSub: () {
            _adding(-additionAmountUnit, tecGram, false);
          },
        ),
        SizedBox(height: 9.h),
        _buildQuantityRow(
          context: context,
          valueLabel: 'rupiah',
          isCustomPrice: widget.product.isCustomPrice,
          icon: SvgPicture.asset(
            'assets/vectors/money.svg',
            width: 15.sp,
            height: 15.sp,
            color: Palette.accent,
          ),
          textEditingController: tecPrice,
          onValueChanged: (value) {
            _onChangeValue(true);
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
}