import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_bottom_sheet_widget.dart';

/// Displays the logout button and app version info.
class LogoutSectionWidget extends StatelessWidget {
  final String appVersion;
  final VoidCallback? onLogout;

  const LogoutSectionWidget({
    super.key,
    required this.appVersion,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => AppBottomSheetWidget.show(
              context: context,
              icon: Icons.logout_rounded,
              iconColor: AppColors.secondary,
              title: 'Logout?',
              message: 'Are you sure you want to logout from Stay Awhile?',
              confirmLabel: 'Logout',
              confirmColor: AppColors.error,
              confirmTextColor: AppColors.white,
              onConfirm: () => onLogout?.call(),
            ),
            icon: const Icon(Icons.logout, size: 20),
            label: Text(
              'Logout from Stay Awhile',
              style: AppTextStyle.labelMd.copyWith(color: AppColors.secondary),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.secondary,
              side: const BorderSide(color: AppColors.secondary, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.radiusFull),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.spacingMd,
                horizontal: AppSize.spacingLg,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSize.spacingLg),
        Text(
          'Version $appVersion — Handcrafted for the neighborhood',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
