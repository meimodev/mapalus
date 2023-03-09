// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/card_cart_item.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        children: [
          const CardNavigation(title: 'Keranjang Belanja', isInverted: true),
          Expanded(
            child: Container(
              color: Palette.accent,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.productOrders.value.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Obx(
                    () => CardCartItem(
                      index: index,
                      productOrder: controller.productOrders.value[index],
                      onPressedDelete: controller.onPressedItemDelete,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Insets.medium.w,
                  right: Insets.medium.w,
                  top: Insets.medium.h,
                ),
                child: Obx(
                  () => _BuildNoteCard(
                    note: controller.note.value,
                    onChangedNote: controller.onChangedNote,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Insets.medium.h * 2,
                  right: Insets.medium.h * 2,
                  top: Insets.small.h,
                ),
                child: Obx(
                  () => Column(
                    children: [
                      _buildRowItem(
                        context,
                        "Jumlah produk",
                        controller.count.value,
                      ),
                      _buildRowItem(
                        context,
                        "Jumlah berat",
                        controller.weight.value,
                      ),
                      _buildRowItem(
                        context,
                        "Total harga",
                        controller.price.value,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.medium.w,
                  vertical: Insets.small.h,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(9.sp),
                  clipBehavior: Clip.hardEdge,
                  color: Palette.primary,
                  elevation: 4,
                  child: InkWell(
                    onTap: controller.onPressedSetDelivery,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.medium.w,
                        vertical: Insets.small.h,
                      ),
                      child: Center(
                        child: Text(
                          'Atur Pengantaran',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildRowItem(
    BuildContext context,
    String title,
    String value,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            value,
            // textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
}

class _BuildNoteCard extends StatefulWidget {
  const _BuildNoteCard({
    Key? key,
    required this.onChangedNote,
    required this.note,
  }) : super(key: key);

  final Function(String) onChangedNote;
  final String note;

  @override
  State<_BuildNoteCard> createState() => _BuildNoteCardState();
}

class _BuildNoteCardState extends State<_BuildNoteCard> {
  final tecNote = TextEditingController();

  String note = "";
  String errorText = "";

  @override
  void dispose() {
    tecNote.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    note = widget.note;
    if (widget.note.isNotEmpty) {
      tecNote.text = widget.note;
    }
  }

  void onSubmitNote() {
    final n = tecNote.text;
    widget.onChangedNote(n);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(9.sp),
      clipBehavior: Clip.hardEdge,
      color: Palette.editable,
      elevation: .5,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => _buildBottomSheet(),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.small.w,
            vertical: Insets.small.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.edit_note_rounded, size: 15.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: widget.note.isEmpty
                    ? _buildNoteHint(context)
                    : _buildNote(context, widget.note),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildNoteHint(BuildContext context) {
    final List<String> hints = [
      "Tu tomat ambe akang yang masi ba ijo-ijo",
      "Tu daging ambe yang bagian tawa lapis",
      "Tu kentang ambe yang ukuran kecil nda usah yang besar",
      "Potong akang tu kangkong pe bagian bawah ne",
      "Pisang yang masih ba mengkal, Tu popaya ambe yang mengkal lei",
      "Tu kalapa cukur ambe yang masih ba muda",
    ];

    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        text: "Catatan ",
        style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
            color: Palette.primary),
        children: [
          TextSpan(
            text: hints[Random().nextInt(hints.length)],
            style: TextStyle(
              color: Colors.grey.withOpacity(.5),
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  _buildNote(BuildContext context, String note) {
    return Text(
      note,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.sp,
      ),
    );
  }

  _buildBottomSheet() => Dialog(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Insets.medium.sp, vertical: Insets.medium.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Catatan",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: Insets.small.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.small.w,
                  vertical: 2.w,
                ),
                decoration: BoxDecoration(
                  color: Palette.editable,
                  borderRadius: BorderRadius.circular(9.sp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: tecNote,
                      maxLines: 4,
                      maxLength: 300,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onSubmitted: (_) => onSubmitNote(),
                      autocorrect: false,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Palette.textPrimary,
                      ),
                      cursorColor: Palette.primary,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12.sp,
                        ),
                        isDense: true,
                        border: InputBorder.none,
                        labelText: null,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Insets.small.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Palette.negative,
                    shape: const CircleBorder(),
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        tecNote.text = "";
                        note = "";
                        widget.onChangedNote("");
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.medium.w,
                          vertical: Insets.small.h,
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          size: 21.sp,
                          color: Palette.cardForeground,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Palette.positive,
                    shape: const CircleBorder(),
                    elevation: 1,
                    child: InkWell(
                      onTap: onSubmitNote,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.medium.w,
                          vertical: Insets.small.h,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 21.sp,
                          color: Palette.cardForeground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
