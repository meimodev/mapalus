import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardSearchBar extends StatelessWidget {
  const CardSearchBar({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.controller,
    this.onPressed,
    this.autoFocus = false,
  });

  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;

  final VoidCallback? onPressed;

  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BaseColor.editable,
        borderRadius: BorderRadius.circular(
          BaseSize.roundnessMedium,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: BaseSize.h12,
        horizontal: BaseSize.w12,
      ),
      child: Row(
        children: [
          const Icon(
            Ionicons.search,
            color: BaseColor.secondaryText,
          ),
          Gap.w12,
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              autofocus: autoFocus,
              readOnly: onPressed != null,
              onTap: onPressed,
              onChanged: onChanged,
              maxLines: 1,
              autocorrect: false,
              style: BaseTypography.caption.toSecondary,
              cursorColor: BaseColor.primary3,
              decoration: InputDecoration(
                hintStyle: BaseTypography.titleLarge.toSecondary.w400,
                isDense: true,
                border: InputBorder.none,
                hintText: 'Cari Produk',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
