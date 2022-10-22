import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:get/get.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton(
      {Key? key, required this.onPressedDelete, required this.userPhone})
      : super(key: key);

  final Function(String phone) onPressedDelete;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(Insets.small.w * 1.5),
        side: const BorderSide(
          width: .5,
          color: Palette.negative,
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
          padding: EdgeInsets.all(Insets.small.w),
          child: Text(
            'Hapus Akun',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 14.sp,
                  color: Palette.negative,
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
      {Key? key, required this.onPressedPositive, required this.userPhone})
      : super(key: key);

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
          top: Radius.circular(Insets.large.w),
        ),
      ),
      onClosing: () {},
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.all(Insets.medium.w),
        // height: 270.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Perhatian!',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: Insets.small.h),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 12.sp),
                children: [
                  const TextSpan(
                    text: 'Akun yang dihapus ',
                  ),
                  TextSpan(
                    text: 'tidak bisa dikembalikan lagi. ',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Palette.negative,
                        ),
                  ),
                  const TextSpan(
                    text:
                        'Silahkan masukkan nomor telpon akun untuk konfirmasi.',
                  ),
                ],
              ),
            ),
            SizedBox(height: Insets.medium.h),
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
                      color: Palette.accent,
                      fontFamily: fontFamily,
                      fontSize: 14.sp,
                    ),
                    cursorColor: Palette.primary,
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
            SizedBox(height: Insets.small.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: isDeleteButtonEnabled
                  ? Material(
                      color: Palette.negative,
                      elevation: 5,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(Insets.small.w),
                      ),
                      child: InkWell(
                        onTap: widget.onPressedPositive,
                        child: Padding(
                          padding: EdgeInsets.all(Insets.small.w),
                          child: Text(
                            'HAPUS AKUN',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
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
