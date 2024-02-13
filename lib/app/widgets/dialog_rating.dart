import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class DialogRating extends StatefulWidget {
  const DialogRating({
    Key? key,
    required this.onPressedRate,
  }) : super(key: key);

  final Function(String message, double rating) onPressedRate;

  @override
  State<DialogRating> createState() => _DialogRatingState();
}

class _DialogRatingState extends State<DialogRating> {
  TextEditingController tecMessage = TextEditingController();
  double rating = 3;

  @override
  void dispose() {
    tecMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 420.h,
        width: 300.w,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: PaletteTheme.cardForeground,
          borderRadius: BorderRadius.circular(9.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Masukkan & Penilaian anda\nakan sangat membantu layanan ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                    fontSize: 14.sp,
                  ),
            ),
            SizedBox(height: Insets.medium.h),
            Container(
              height: 210.h,
              margin: EdgeInsets.symmetric(horizontal: Insets.small.w),
              padding: EdgeInsets.symmetric(
                horizontal: 9.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.sp),
                color: PaletteTheme.editable,
              ),
              child: TextField(
                controller: tecMessage,
                maxLines: 100,
                textAlign: TextAlign.start,
                enableSuggestions: false,
                scrollPhysics: const BouncingScrollPhysics(),
                autocorrect: false,
                style: TextStyle(
                  color: PaletteTheme.accent,
                  fontFamily: fontFamily,
                  fontSize: 14.sp,
                ),
                cursorColor: PaletteTheme.primary,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.sp,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Layanan ini akan lebih baik jika ...",
                ),
              ),
            ),
            SizedBox(height: Insets.small.h),
            SizedBox(
              width: 50.w,
              height: 50.h,
              child: Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  glowColor: PaletteTheme.editable.withOpacity(.25),
                  itemSize: 27.sp,
                  itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                  onRatingUpdate: (r) {
                    rating = r;
                  },
                  itemBuilder: (BuildContext context, int index) =>
                      SvgPicture.asset(
                    'assets/vectors/star.svg',
                    colorFilter: const ColorFilter.mode(
                      PaletteTheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  updateOnDrag: true,
                  unratedColor: PaletteTheme.accent,
                ),
              ),
            ),
            SizedBox(height: Insets.small.h),
            Material(
              color: PaletteTheme.primary,
              borderRadius: BorderRadius.circular(9.sp),
              child: InkWell(
                onTap: () {
                  widget.onPressedRate(tecMessage.text, rating);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.small.w,
                    vertical: Insets.small.h,
                  ),
                  child: const Center(
                    child: Text(
                      'Nilai',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
