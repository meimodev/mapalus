import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:mapalus/app/modules/account_settings/account_settings_controller.dart';
import 'package:mapalus/app/widgets/button_delete_account.dart';
import 'package:mapalus/app/widgets/card_navigation.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class AccountSettingsScreen extends GetView<AccountSettingsController> {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
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
                    () => AnimatedSwitcher(
                      duration: 400.milliseconds,
                      child: controller.userName.isNotEmpty
                          ? _buildSignedInBody()
                          : _buildAnonymousBody(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildDevNote(context),
        ],
      ),
    );
  }

  Widget _buildSignedInBody() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Insets.medium.h),
            Container(
              width: 120.w,
              height: 120.h,
              padding: EdgeInsets.all(30.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: PaletteTheme.accent,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/mapalus.svg',
                  width: 60.w,
                  height: 60.h,
                  colorFilter: const ColorFilter.mode(
                    PaletteTheme.primary,
                    BlendMode.srcIn,
                  ),
                  // color: PaletteTheme.primary,
                ),
              ),
            ),
            SizedBox(height: Insets.small.h),
            Text(
              controller.userName.value,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
            ),
            Text(
              controller.userPhone.value,
              style: TextStyle(
                color: PaletteTheme.accent,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: Insets.medium.h),
        Container(
          height: .5,
          margin: EdgeInsets.symmetric(
            horizontal: Insets.large.w,
          ),
          color: PaletteTheme.accent,
        ),
        SizedBox(height: Insets.small.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
          child: Column(
            children: [
              Badge(
                showBadge: controller.orderCount > 0,
                badgeContent: Text(
                  controller.orderCount.value.toString(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: PaletteTheme.editable,
                  ),
                ),
                position: BadgePosition.topStart(),
                child: _buildItemRow(
                  assetLocation: 'assets/vectors/bag.svg',
                  text: 'Riwayat Pesanan',
                  onPressed: controller.onPressedOrders,
                ),
              ),
              _buildItemRow(
                assetLocation: 'assets/vectors/exit.svg',
                text: 'Keluar',
                onPressed: controller.onPressedSignOut,
              ),
            ],
          ),
        ),
        SizedBox(height: Insets.large.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.medium.w),
          child: DeleteAccountButton(
            onPressedDelete: controller.onPressedDeleteAccount,
            userPhone: controller.userRepo.signedUser!.phone,
          ),
        ),
      ],
    );
  }

  Widget _buildAnonymousBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: Insets.medium.h),
        Text(
          'Silahkan masuk untuk melanjutkan',
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: Insets.small.h),
        Material(
          clipBehavior: Clip.hardEdge,
          color: PaletteTheme.primary,
          borderRadius: BorderRadius.circular(9.sp),
          elevation: 2,
          child: InkWell(
            onTap: controller.onPressedSignIn,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Insets.medium.w,
                vertical: Insets.medium.w * .5,
              ),
              child: const Text(
                'Masuk',
                style: TextStyle(
                  color: PaletteTheme.accent,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Insets.medium.h),
      ],
    );
  }

  Widget _buildDevNote(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.medium.w,
        vertical: Insets.medium.h,
      ),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => Text(
              'mapalus ${controller.currentVersion.value}',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
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
    );
  }

  Widget _buildItemRow({
    required String assetLocation,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 45.h,
          child: Row(
            children: [
              SizedBox(
                width: 30.sp,
                child: SvgPicture.asset(
                  assetLocation,
                  width: 18.sp,
                  height: 18.sp,
                ),
              ),
              SizedBox(width: Insets.small.w * .5),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
