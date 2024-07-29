import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class SliverListViewSeparated<T> extends StatelessWidget {
  const SliverListViewSeparated({
    super.key,
    required this.title,
    required this.list,
    required this.itemBuilder,
    required this.separatorBuilder,
  });

  final String title;
  final List<T> list;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: BaseSize.w12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: BaseTypography.bodyLarge,
            ),
            Gap.h12,
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: list.map((e) {
                  final index = list.indexOf(e);
                  if (index == list.length - 1) {
                    return itemBuilder(context, e, index);
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      itemBuilder(context, e, index),
                      separatorBuilder(context, index),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
