import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardNoteWidget extends StatelessWidget {
  const CardNoteWidget({
    super.key,
    required this.onChangedNote,
    required this.note,
  });

  final void Function(String) onChangedNote;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BaseSize.roundnessMedium),
      clipBehavior: Clip.hardEdge,
      color: BaseColor.editable,
      elevation: .5,
      child: InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (_) => _BuildBottomSheet(
              note: note,
              onSubmitNote: (value) {
                Navigator.pop(context);
                onChangedNote(value);
              },
              onDeleteNote: () {
                onChangedNote("");
                Navigator.pop(context);
              },
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_note_rounded,
                  size: BaseSize.customRadius(20),
                ),
                Gap.w4,
                Expanded(
                  child: note.isEmpty
                      ? _buildNoteHint(context)
                      : Text(
                          note,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: BaseTypography.caption,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoteHint(BuildContext context) {
    final List<String> hints = [
      "Rica yang pidis neh",
      "Nasi stenga jo",
      "Se tore akang sadiki ",
    ];

    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        text: "Catatan: ",
        style: BaseTypography.caption,
        children: [
          TextSpan(
            text: hints[Random().nextInt(hints.length)],
            style: BaseTypography.caption
                .copyWith(color: BaseColor.secondaryText.withValues(alpha: .75)),
          ),
        ],
      ),
    );
  }
}

class _BuildBottomSheet extends StatefulWidget {
  const _BuildBottomSheet({
    required this.onSubmitNote,
    required this.onDeleteNote,
    // required this.onChangedNote,
    required this.note,
  });

  final void Function(String) onSubmitNote;
  final VoidCallback onDeleteNote;
  // final void Function(String) onChangedNote;
  final String note;

  @override
  State<_BuildBottomSheet> createState() => _BuildBottomSheetState();
}

class _BuildBottomSheetState extends State<_BuildBottomSheet> {
  final tecNote = TextEditingController();

  @override
  void initState() {
    super.initState();
    tecNote.text = widget.note;
  }

  @override
  void dispose() {
    tecNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: BaseColor.white,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(BaseSize.radiusLg),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BaseSize.w24,
          vertical: BaseSize.w24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Catatan:",
              style: BaseTypography.caption,
            ),
            Gap.h12,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: BaseSize.w12,
                vertical: BaseSize.customWidth(2),
              ),
              decoration: BoxDecoration(
                color: BaseColor.editable,
                borderRadius: BorderRadius.circular(BaseSize.roundnessMedium),
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
                    onSubmitted: (value) => widget.onSubmitNote(value),
                    // onChanged: widget.onChangedNote,
                    autocorrect: false,
                    autofocus: true,
                    style: BaseTypography.caption,
                    cursorColor: BaseColor.primary3,
                    decoration: InputDecoration(
                      hintStyle: BaseTypography.caption,
                      isDense: true,
                      border: InputBorder.none,
                      labelText: null,
                    ),
                  ),
                ],
              ),
            ),
            Gap.h12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  clipBehavior: Clip.hardEdge,
                  color: BaseColor.negative,
                  shape: const CircleBorder(),
                  elevation: 1,
                  child: InkWell(
                    onTap: () {
                      tecNote.text = "";
                      widget.onDeleteNote();
                    },
                    child: SizedBox(
                      height: BaseSize.w36,
                      width: BaseSize.w36,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: BaseColor.cardBackground1,
                          size: BaseSize.w20,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  clipBehavior: Clip.hardEdge,
                  color: BaseColor.positive,
                  shape: const CircleBorder(),
                  elevation: 1,
                  child: InkWell(
                    onTap: () => widget.onSubmitNote(tecNote.text),
                    child: SizedBox(
                      height: BaseSize.w36,
                      width: BaseSize.w36,
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: BaseColor.cardBackground1,
                          size: BaseSize.w20,
                        ),
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
}
