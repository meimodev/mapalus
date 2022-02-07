import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapalus/app/widgets/card_product.dart';
import 'package:mapalus/app/widgets/screen_wrapper.dart';
import 'package:mapalus/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: CustomScrollView(
        slivers: [
          // _buildUpperSection(context),
          SliverAppBar(
            title: const SearchView(),
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
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        Text(
                          "Antar ke Rumah",
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
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
          const CardCategory(
            iconData: Icons.star,
            isSelected: true,
            name: 'Makanan',
          ),
          SizedBox(width: Insets.medium.w),
          const CardCategory(
            iconData: Icons.star,
            name: 'Minuman',
          ),
          SizedBox(width: Insets.medium.w),
          const CardCategory(
            iconData: Icons.star,
            name: 'Makian',
          ),
          SizedBox(width: Insets.medium.w),
          const CardCategory(
            iconData: Icons.star,
            name: 'Maksiat',
          ),
          SizedBox(width: Insets.medium.w),
          const CardCategory(
            iconData: Icons.star,
            name: 'Mendingan',
          ),
          SizedBox(width: Insets.medium.w),
          const CardCategory(
            iconData: Icons.star,
            name: 'Mayat',
          ),
        ],
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.editable,
        borderRadius: BorderRadius.circular(Roundness.large.sp),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Insets.small.h * .5,
        horizontal: Insets.small.h * .5,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Insets.small.w * .25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.add_alarm,
                  color: Colors.grey,
                  size: 21.sp,
                ),
                SizedBox(width: Insets.small.w * .5),
                Text(
                  "Cari Produk ...",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(width: Insets.small.w * .5),
            CircleAvatar(
              radius: 15.sp,
              backgroundColor: Palette.accent,
              child: SvgPicture.asset(
                'assets/images/mapalus_logo.svg',
                height: 12.sp,
                width: 12.sp,
                color: Palette.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardCategory extends StatelessWidget {
  const CardCategory({
    Key? key,
    this.isSelected = false,
    required this.name,
    required this.iconData,
  }) : super(key: key);

  final bool isSelected;
  final String name;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            boxShadow: isSelected
                ? []
                : [
                    BoxShadow(
                      spreadRadius: .125,
                      blurRadius: 10,
                      color: Colors.grey.shade200,
                      offset: const Offset(3, 3),
                    )
                  ],
            color: isSelected ? Palette.accent : Palette.cardForeground,
            borderRadius: BorderRadius.all(
              Radius.circular(12.sp),
            ),
          ),
          child: Icon(
            iconData,
            color: isSelected ? Palette.primary : Palette.accent,
            size: 30.sp,
          ),
        ),
        SizedBox(height: Insets.small.h * .5),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: isSelected ? Palette.textPrimary : Colors.grey,
              ),
        ),
      ],
    );
  }
}