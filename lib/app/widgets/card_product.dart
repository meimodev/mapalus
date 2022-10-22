import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/custom_image.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';


// class CardProduct extends StatelessWidget {
//   const CardProduct({
//     Key? key,
//     required this.onPressed,
//     required this.product,
//   }) : super(key: key);
//
//   final Product product;
//   final Function(Product product) onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.all(
//         Radius.circular(12.sp),
//       ),
//       clipBehavior: Clip.hardEdge,
//       color: Palette.cardForeground,
//       child: InkWell(
//         onTap: () {
//           onPressed(product);
//         },
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: Insets.small.w,
//             vertical: Insets.small.w,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   product.isAvailable
//                       ? SizedBox(
//                           height: Insets.small.h,
//                         )
//                       : Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/vectors/min.svg',
//                               height: 12.sp,
//                               width: 12.sp,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(width: Insets.small.w * .5),
//                             Text(
//                               "Sedang tidak tersedia",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(
//                                     fontWeight: FontWeight.w300,
//                                     color: Palette.accent,
//                                     fontSize: 9.sp,
//                                   ),
//                             ),
//                           ],
//                         ),
//                   product.isCustomPrice
//                       ? Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/vectors/money.svg',
//                               height: 12.sp,
//                               width: 12.sp,
//                               color: Palette.accent,
//                             ),
//                           ],
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//               SizedBox(height: Insets.small.h),
//               Container(
//                 height: 120.h,
//                 clipBehavior: Clip.hardEdge,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: product.isAvailable
//                       ? Palette.accent.withOpacity(.85)
//                       : Palette.accent.withOpacity(.5),
//                   boxShadow: [
//                     BoxShadow(
//                       spreadRadius: .25,
//                       blurRadius: 10,
//                       color: product.isAvailable
//                           ? Palette.primary.withOpacity(.125)
//                           : Colors.grey.withOpacity(.125),
//                       offset: const Offset(3, 3),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: CustomImage(
//                     imageUrl: product.imageUrl,
//                   ),
//                 ),
//               ),
//               SizedBox(height: Insets.small.h),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: _calculateFontSize(),
//                           color: product.isAvailable
//                               ? Palette.textPrimary
//                               : Colors.grey,
//                         ),
//                   ),
//                   SizedBox(height: 3.h),
//                   Text(
//                     '${product.priceF} / ${product.unit}',
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontWeight: FontWeight.w300,
//                           fontSize: 11.sp,
//                           color: product.isAvailable
//                               ? Palette.textPrimary
//                               : Colors.grey,
//                         ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _calculateFontSize() {
//     if (product.name.length > 30) {
//       return 10.sp;
//     }
//     if (product.name.length > 24) {
//       return 12.sp;
//     }
//   }
// }

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.onPressed,
    required this.product,
  }) : super(key: key);

  final Product product;
  final Function(Product product) onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Palette.cardForeground,
      child: InkWell(
        onTap: () {
          onPressed(product);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.small.w,
            vertical: Insets.small.h * .5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60.w,
                width: 60.w,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Palette.primary,
                  backgroundBlendMode: BlendMode.clear,
                  shape: BoxShape.circle,
                ),
                child: CustomImage(
                  imageUrl: product.imageUrl,
                ),
              ),
              SizedBox(width: Insets.small.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: _calculateFontSize(),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${product.priceF} / ${product.unit}',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        // product.unit.trim().toLowerCase() == 'kilogram'
                        //     ? const SizedBox()
                        //     : Row(
                        //   children: [
                        //     const Text(" | "),
                        //     Text(
                        //       product.weightF,
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .bodyText1
                        //           ?.copyWith(
                        //         fontSize: 10.sp,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                     SizedBox(height: 3.h),
                    _buildCategoriesChip(),
                  ],
                ),
              ),
              SizedBox(width: Insets.small.w),
              _buildStatusIcons(
                isAvailable: product.isAvailable,
                isCustomPrice: product.isCustomPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildStatusIcons({
    required bool isAvailable,
    required bool isCustomPrice,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        isAvailable
            ? const SizedBox()
            : Container(
          padding: EdgeInsets.all(9.sp),
          decoration: const BoxDecoration(
            color: Palette.accent,
            shape: BoxShape.circle,
          ),
          child: Text(
            "!",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Palette.negative,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        isCustomPrice
            ? Container(
          padding: EdgeInsets.all(9.sp),
          decoration: const BoxDecoration(
            color: Palette.accent,
            shape: BoxShape.circle,
          ),
          child: Text(
            "\$",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: Palette.primary,
            ),
          ),
        )
            : const SizedBox(),
      ],
    );
  }

  _buildCategoriesChip() {
    var categoryList = [];
    if (product.category.contains(',')) {
      var temp = product.category.split(',');
      for (String t in temp) {
        categoryList.add(t);
      }
    } else {
      categoryList.add(product.category);
    }

    return Row(
      children: [
        for (var c in categoryList)
          Container(
            decoration: BoxDecoration(
              color: Palette.accent,
              borderRadius: BorderRadius.circular(30.sp),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.small.w * .5,
                  vertical: Insets.small.h * .25,
                ),
                child: Text(
                  c,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Palette.primary,
                    fontSize: 8.sp,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  _calculateFontSize() {
    if (product.name.length > 45) {
      return 11.sp;
    }
    if (product.name.length > 35) {
      return 13.sp;
    }
  }
}