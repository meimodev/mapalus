import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class NavigationBarCardWidget extends StatelessWidget {
  const NavigationBarCardWidget({super.key, required this.order});

  final OrderApp order;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BaseColor.accent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: BaseSize.h12,
          ),
          child: Row(
            children: [
              const ButtonWidget(
                icon: Icons.chevron_left_rounded,
                textColor: BaseColor.primary3,
                backgroundColor: BaseColor.transparent,
              ),
              Gap.w12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dipesan ${Jiffy.now().to(order.createdAt.toJiffy, withPrefixAndSuffix: true)}",
                    style: BaseTypography.bodyMedium.toCardBackground1,
                  ),
                  Text(
                    '${order.products.length} Produk ${order.delivery != null ? "| BUNGKUS" : ""}',
                    style: BaseTypography.bodySmall.toCardBackground1,
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
