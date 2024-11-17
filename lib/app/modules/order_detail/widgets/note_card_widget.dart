import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.note,
  });

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BaseSize.radiusMd),
        color: BaseColor.editable,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w12,
        vertical: BaseSize.h12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.edit_note_rounded, size: BaseSize.radiusLg),
          Gap.w8,
          Expanded(
            child: ReadMoreText(
              '$note ',
              trimLines: 1,
              colorClickableText: BaseColor.primary3,
              trimMode: TrimMode.Line,
              style: BaseTypography.titleLarge.w300,
              delimiter: "  . . .  ",
              delimiterStyle: BaseTypography.bodyLarge.w400.toBold,
            ),
          ),
        ],
      ),
    );
  }
}
