import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class CardCartPeak extends StatelessWidget {
  const CardCartPeak({
    Key? key,
    required this.onPressed,
    // required this.productOrders,
    required this.totalPrice,
    required this.cartOverview,
  }) : super(key: key);

  final VoidCallback onPressed;
  // final List<ProductOrder> productOrders;
  final String totalPrice;
  final String cartOverview;

  @override
  Widget build(BuildContext context) {
    // print('cart card');
    // String _calculateTotalPrice() {
    //   double total = 0;
    //   for (var element in productOrders) {
    //     total += element.totalPrice;
    //   }
    //   return Utils.formatNumberToCurrency(total);
    // }
    //
    // String _calculateProductTotalUnitAndWeight() {
    //   int tProduct = 0;
    //   double tWeight = 0;
    //   for (var element in productOrders) {
    //     tProduct++;
    //     tWeight += element.quantity;
    //   }
    //
    //   return "$tProduct produk, ${tWeight.toStringAsFixed(2)} kilogram"
    //       .replaceFirst(".00", '');
    // }

    return Material(
      clipBehavior: Clip.hardEdge,
      elevation: 9,
      color: Palette.accent,
      borderRadius: BorderRadius.circular(30.sp),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 210.w,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Insets.small.w,
              horizontal: Insets.small.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   backgroundColor: Palette.primary,
                //   child: Padding(
                //     padding: EdgeInsets.all(9.sp),
                //     child: SvgPicture.asset(
                //       "assets/vectors/cart.svg",
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(9.sp),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.primary,
                  ),
                  child: SvgPicture.asset(
                    "assets/vectors/cart.svg",
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                SizedBox(width: Insets.small.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      totalPrice,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Palette.cardForeground,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                    ),
                    Text(
                      cartOverview,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}