import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/modules/account_settings/account_settings_controller.dart';
import 'package:mapalus/app/widgets/button_delete_account.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class AccountSettingsScreen extends GetView<AccountSettingsController> {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CardNavigation(title: 'Tentang Akun'),
                Expanded(
                  child: Obx(
                    () => LoadingWrapper(
                      loading: controller.loading.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: BaseSize.w24,
                        ),
                        child: controller.user != null
                            ? _buildSignedInBody(controller.user!)
                            : _buildAnonymousBody(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: BaseSize.w24,
              vertical: BaseSize.w24,
            ),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'mapalus ${controller.currentVersion}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'with ♥ ${Jiffy.now().year} ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 12.sp,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/logo_meimo.svg',
                      width: 15.sp,
                      height: 15.sp,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignedInBody(UserApp user) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap.h24,
            Text(
              user.name,
              style: BaseTypography.bodyMedium.toBold,
            ),
            Text(
              user.phone,
              style: BaseTypography.bodyMedium,
            ),
          ],
        ),
        Gap.h24,
        Container(
          height: .5,
          margin: EdgeInsets.symmetric(
            horizontal: BaseSize.w48,
          ),
          color: BaseColor.accent,
        ),
        Gap.h24,
        Column(
          children: [
            // _buildItemRow(
            //   assetLocation: 'assets/vectors/bag.svg',
            //   text: 'Riwayat Pesanan',
            //   onPressed: () {},
            // ),
            _buildItemRow(
              assetLocation: 'assets/vectors/exit.svg',
              text: 'Keluar',
              onPressed: controller.onPressedSignOut,
            ),
          ],
        ),
        Gap.h12,
        DeleteAccountButton(
          onPressedDelete: controller.onPressedDeleteAccount,
          userPhone: controller.userRepo.signedUser!.phone,
        ),
      ],
    );
  }

  Widget _buildAnonymousBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap.h24,
        Text(
          'Silahkan masuk untuk melanjutkan',
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        Gap.h12,
        Material(
          clipBehavior: Clip.hardEdge,
          color: BaseColor.primary3,
          borderRadius: BorderRadius.circular(9.sp),
          elevation: 2,
          child: InkWell(
            onTap: controller.onPressedSignIn,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: BaseSize.w24,
                vertical: BaseSize.w12,
              ),
              child: const Text(
                'Masuk',
                style: TextStyle(
                  color: BaseColor.accent,
                ),
              ),
            ),
          ),
        ),
        Gap.h24,
      ],
    );
  }

  Widget _buildItemRow({
    required String assetLocation,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(BaseSize.radiusMd),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BaseSize.w12,
            vertical: BaseSize.h12,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                assetLocation,
                width: BaseSize.w12,
                height: BaseSize.w12,
              ),
              Gap.w12,
              Text(
                text,
                style: BaseTypography.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
