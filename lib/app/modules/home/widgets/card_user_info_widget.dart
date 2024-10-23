import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CardUserInfoWidget extends StatelessWidget {
  const CardUserInfoWidget({
    super.key,
    required this.onPressed,
    this.user,
  });

  final VoidCallback onPressed;
  final UserApp? user;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: user == null ? BaseColor.primaryText : BaseColor.white,
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(
        BaseSize.radiusMd,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: _content(context),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    if (user == null) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              "Klik disini untuk masuk menggunakan nomor hp",
              style: BaseTypography.bodySmall.toPrimary,
              textAlign: TextAlign.center,
            ),
          ),
          Gap.w12,
          Icon(
            Ionicons.log_in_outline,
            size: BaseSize.customRadius(24),
            color: BaseColor.primary3,
          ),
        ],
      );
    }
    return Row(
      children: [
        Container(
          width: BaseSize.customRadius(40),
          height: BaseSize.customRadius(40),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: BaseColor.accent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              user!.name.toInitials,
              style: BaseTypography.bodyLarge.toBold.toPrimary,
            ),
          ),
        ),
        Gap.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                user!.name,
                style: BaseTypography.bodySmall.toBold,
              ),
              Text(
                user!.phone,
                style: BaseTypography.bodySmall,
              ),
            ],
          ),
        ),
        Gap.w12,
        Icon(
          Ionicons.log_out_outline,
          size: BaseSize.customRadius(24),
          color: BaseColor.negative,
        ),
      ],
    );
  }
}
