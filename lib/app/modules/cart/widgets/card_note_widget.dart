import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardNoteWidget extends StatefulWidget {
  const CardNoteWidget({
    super.key,
    required this.onChangedNote,
    required this.note,
  });

  final Function(String) onChangedNote;
  final String note;

  @override
  State<CardNoteWidget> createState() => _CardNoteWidgetState();
}

class _CardNoteWidgetState extends State<CardNoteWidget> {
  String note = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.note.isNotEmpty) {
      setState(() {
        note = widget.note;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BaseSize.roundnessMedium),
      clipBehavior: Clip.hardEdge,
      color: BaseColor.editable,
      elevation: .5,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => _BuildBottomSheet(
              note: note,
              onSubmitNote: () {
                Navigator.pop(context);
                setState(() {});
              },
              onDeleteNote: () {
                if (note.isNotEmpty) {
                  setState(() {
                    note = "";
                  });
                }
                Navigator.pop(context);
              },
              onChangedNote: (value) {
                note = value;
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
                Gap.w12,
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

  _buildNoteHint(BuildContext context) {
    final List<String> hints = [
      "Rica yang pidis neh",
      "Nasi stenga jo",
      "Se tore akang sadiki ",
    ];

    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        text: "Catatan ",
        style: BaseTypography.caption.toPrimary,
        children: [
          TextSpan(
            text: hints[Random().nextInt(hints.length)],
            style: BaseTypography.caption.toSecondary,
          ),
        ],
      ),
    );
  }
}

class _BuildBottomSheet extends StatelessWidget {
  const _BuildBottomSheet({
    super.key,
    required this.onSubmitNote,
    required this.onDeleteNote,
    required this.onChangedNote,
    required this.note,
  });

  final VoidCallback onSubmitNote;
  final VoidCallback onDeleteNote;
  final void Function(String) onChangedNote;
  final String note;

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
              "Catatan",
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
                    controller: note.isNotEmpty
                        ? (TextEditingController()..text = note)
                        : null,
                    maxLines: 4,
                    maxLength: 300,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onSubmitted: (value) => onSubmitNote(),
                    onChanged: onChangedNote,
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
                    onTap: onDeleteNote,
                    child: SizedBox(
                      height: BaseSize.w36,
                      width: BaseSize.w36,
                      child: Center(
                        child: Icon(
                          Ionicons.close_outline,
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
                    onTap: onSubmitNote,
                    child: SizedBox(
                      height: BaseSize.w36,
                      width: BaseSize.w36,
                      child: Center(
                        child: Icon(
                          Ionicons.checkmark_outline,
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
