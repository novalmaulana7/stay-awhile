import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Header section of register card with welcome text.
class RegisterHeaderSectionWidget extends StatelessWidget {
  const RegisterHeaderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create an Account',
          style: AppTextStyle.headlineMd,
        ),
        const SizedBox(height: 4),
        Text(
          'Join our community on the porch.',
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}
