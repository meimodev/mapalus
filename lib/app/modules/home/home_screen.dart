import 'package:flutter/material.dart';
import 'package:mapalus/app/widgets/card_category.dart';
import 'package:mapalus/app/widgets/card_order_peak.dart';
import 'package:mapalus/app/widgets/card_product.dart';
import 'package:mapalus/app/widgets/card_cart_peak.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/app/widgets/search_view.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // _buildUpperSection(context),
              SliverAppBar(
                title: SearchView(
                  onSubmitted: (String value) {},
                  onLogoPressed: () {},
                ),
                collapsedHeight: 75.h,
                expandedHeight: 300.h,
                forceElevated: true,
                toolbarHeight: 75.h,
                floating: true,
                pinned: true,
                snap: true,
                backgroundColor: Palette.cardForeground,
                elevation: 5,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Insets.large.sp),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Insets.medium.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 75.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Harga Pasar",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            Text(
                              "Antar ke Rumah",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: Insets.small.h),
                        _buildCardCategories(),
                        SizedBox(height: Insets.small.h),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.all(Insets.small.sp)),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // maxCrossAxisExtent: 170.w,
                  crossAxisCount: 2,
                  crossAxisSpacing: 6.w,
                  mainAxisSpacing: 6.w,
                  mainAxisExtent: 250.h,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index % 2 == 0 ? Insets.medium.w : 0,
                      right: index % 2 == 0 ? 0 : Insets.medium.w,
                    ),
                    child: CardProduct(
                      name: 'Product Name ${index.toString()}',
                      image: 'image url',
                      price: 'Rp. 1.000.000 / gram',
                      isAvailable: index % 2 == 0,
                    ),
                  ),
                  childCount: 20,
                ),
              ),
              SliverPadding(padding: EdgeInsets.all(Insets.small.sp * 1.5)),
            ],
          ),
          Positioned(
            bottom: 110.h,
            right: 12.w,
            child: CardOrdersPeak(
              onPressed: () {},
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 12.w,
            right: 12.w,
            child: CardCartPeak(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Test'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardCategories() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardCategory(
            iconData: Icons.star,
            isSelected: true,
            name: 'Makanan',
            onPressed: () {},
          ),
          SizedBox(width: Insets.medium.w),
          CardCategory(
            iconData: Icons.star,
            name: 'Minuman',
            onPressed: () {},
          ),
          SizedBox(width: Insets.medium.w),
          CardCategory(
            iconData: Icons.star,
            name: 'Makian',
            onPressed: () {},
          ),
          SizedBox(width: Insets.medium.w),
          CardCategory(
            iconData: Icons.star,
            name: 'Maksiat',
            onPressed: () {},
          ),
          SizedBox(width: Insets.medium.w),
          CardCategory(
            iconData: Icons.star,
            name: 'Mendingan',
            onPressed: () {},
          ),
          SizedBox(width: Insets.medium.w),
          CardCategory(
            iconData: Icons.star,
            name: 'Mayat',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}