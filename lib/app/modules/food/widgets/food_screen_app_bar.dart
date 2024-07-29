import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/widgets.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class FoodScreenAppBar extends StatelessWidget {
  const FoodScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: BaseSize.customHeight(110),
      forceElevated: true,
      toolbarHeight: 0,
      floating: true,
      pinned: true,
      snap: true,
      backgroundColor: BaseColor.white,
      elevation: 5,
      clipBehavior: Clip.hardEdge,

      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(BaseSize.roundnessBold),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap.h24,
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const BackButtonIcon(),
                  ),
                  Gap.w12,
                  Expanded(
                    child: CardSearchBar(
                      onPressed: () {
                        Get.toNamed(Routes.search);
                      },
                    ),
                  ),
                  Gap.w12,
                  ButtonMapalus(
                    count: 0,
                    onPressed: () {
                      print("open settings");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
