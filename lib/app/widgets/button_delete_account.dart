import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:get/get.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton(
      {super.key, required this.onPressedDelete, required this.userPhone});

  final Function(String phone) onPressedDelete;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(BaseSize.w12 * 1.5),
        side: const BorderSide(
          width: .5,
          color: BaseColor.negative,
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.bottomSheet(_BuildBottomSheetDeleteAccount(
            onPressedPositive: () {
              onPressedDelete(userPhone);
            },
            userPhone: userPhone,
          ));
        },
        child: Padding(
          padding: EdgeInsets.all(BaseSize.w12),
          child: Text(
            'Hapus Akun',
            style: TextStyle(
                  fontSize: 14.sp,
                  color: BaseColor.negative,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
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
          top: Radius.circular(BaseSize.w48),
        ),
      ),
      onClosing: () {},
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.all(BaseSize.w24),
        // height: 270.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Perhatian!',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: BaseSize.h12),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(fontSize: 12.sp),
                children: const [
                  TextSpan(
                    text: 'Akun yang dihapus ',
                  ),
                  TextSpan(
                    text: 'tidak bisa dikembalikan lagi. ',
                    style: TextStyle(
                          color: BaseColor.negative,
                        ),
                  ),
                  TextSpan(
                    text:
                        'Silahkan masukkan nomor telpon akun untuk konfirmasi.',
                  ),
                ],
              ),
            ),
            SizedBox(height: BaseSize.h24),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: BaseSize.w12,
                vertical: 2.w,
              ),
              decoration: BoxDecoration(
                color: BaseColor.editable,
                borderRadius: BorderRadius.circular(9.sp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: BaseSize.h12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: isDeleteButtonEnabled
                  ? Material(
                      color: BaseColor.negative,
                      elevation: 5,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(BaseSize.w12),
                      ),
                      child: InkWell(
                        onTap: widget.onPressedPositive,
                        child: Padding(
                          padding: EdgeInsets.all(BaseSize.w12),
                          child: Text(
                            'HAPUS AKUN',
                            style:
                            TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
