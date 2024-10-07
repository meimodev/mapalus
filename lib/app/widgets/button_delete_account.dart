import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton(
      {super.key, required this.onPressedDelete, required this.userPhone});

  final Function(String phone) onPressedDelete;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BaseSize.radiusMd),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _BuildBottomSheetDeleteAccount(
              onPressedPositive: () {
                onPressedDelete(userPhone);
              },
              userPhone: userPhone,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(BaseSize.w12),
          child: Text(
            'Hapus Akun',
            style: BaseTypography.bodySmall.toError,
          ),
        ),
      ),
    );
  }
}

class _BuildBottomSheetDeleteAccount extends StatefulWidget {
  const _BuildBottomSheetDeleteAccount(
      {required this.onPressedPositive, required this.userPhone});

  final VoidCallback onPressedPositive;
  final String userPhone;

  @override
  State<_BuildBottomSheetDeleteAccount> createState() =>
      _BuildBottomSheetDeleteAccountState();
}

class _BuildBottomSheetDeleteAccountState
    extends State<_BuildBottomSheetDeleteAccount> {
  String phone = '';
  var isDeleteButtonEnabled = false;

  proceed(String value) {
    phone = value.trim();

    bool phoneConfirmed = phone == widget.userPhone.trim();
    if (!isDeleteButtonEnabled && phoneConfirmed) {
      setState(() {
        isDeleteButtonEnabled = true;
      });
    }

    if (!phoneConfirmed && isDeleteButtonEnabled) {
      setState(() {
        isDeleteButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      clipBehavior: Clip.hardEdge,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BaseSize.radiusLg),
        ),
      ),
      onClosing: () {},
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.all(BaseSize.w24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Perhatian!',
              textAlign: TextAlign.center,
              style: BaseTypography.bodyMedium.toBold,
            ),
            Gap.h12,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: BaseTypography.bodySmall,
                children: [
                  const TextSpan(
                    text: 'Akun yang dihapus ',
                  ),
                  TextSpan(
                    text: 'tidak bisa dikembalikan lagi. ',
                    style: BaseTypography.bodySmall.toError,
                  ),
                  const TextSpan(
                    text:
                        'Silahkan masukkan nomor telpon akun untuk konfirmasi.',
                  ),
                ],
              ),
            ),
            Gap.h12,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: BaseSize.w12,
                vertical: 2.w,
              ),
              decoration: BoxDecoration(
                color: BaseColor.editable,
                borderRadius: BorderRadius.circular(BaseSize.radiusMd),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: proceed,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    onSubmitted: proceed,
                    autocorrect: false,
                    style: TextStyle(
                      color: BaseColor.accent,
                      fontFamily: fontFamily,
                      fontSize: 14.sp,
                    ),
                    cursorColor: BaseColor.primary3,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                      labelText: 'Nomor Handphone',
                    ),
                  ),
                ],
              ),
            ),
            Gap.h12,
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: isDeleteButtonEnabled
                  ? Material(
                      color: BaseColor.negative,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(BaseSize.radiusMd),
                      ),
                      child: InkWell(
                        onTap: widget.onPressedPositive,
                        child: Padding(
                          padding: EdgeInsets.all(BaseSize.w12),
                          child: Text(
                            'HAPUS AKUN',
                            style: BaseTypography.button.toWhite,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Gap.h24,
          ],
        ),
      ),
    );
  }
}
