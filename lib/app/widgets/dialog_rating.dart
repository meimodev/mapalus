import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/shared/theme.dart';

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
          color: Palette.cardForeground,
          borderRadius: BorderRadius.circular(9.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Masukkan & Penilaian anda\nakan sangat membantu layanan ini',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
                color: Palette.editable,
              ),
              child: TextField(
                controller: tecMessage,
                maxLines: 100,
                textAlign: TextAlign.start,
                enableSuggestions: false,
                scrollPhysics: const BouncingScrollPhysics(),
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
                  glowColor: Palette.editable.withOpacity(.25),
                  itemSize: 27.sp,
                  itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                  onRatingUpdate: (_rating) {
                    rating = _rating;
                  },
                  itemBuilder: (BuildContext context, int index) =>
                      SvgPicture.asset(
                    'assets/vectors/star.svg',
                    color: Palette.primary,
                  ),
                  updateOnDrag: true,
                  unratedColor: Palette.accent,
                ),
              ),
            ),
            SizedBox(height: Insets.small.h),
            Material(
              color: Palette.primary,
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