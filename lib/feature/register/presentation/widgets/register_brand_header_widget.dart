import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_assets.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Brand header with logo and app name for register page.
class RegisterBrandHeaderWidget extends StatelessWidget {
  const RegisterBrandHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.logoApp,
          width: 64,
          height: 64,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.park, size: 64, color: AppColors.primary);
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Text(
          'Stay Awhile',
          style: AppTextStyle.headlineLgMobile.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
