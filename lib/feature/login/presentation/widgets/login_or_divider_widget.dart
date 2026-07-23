import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';

/// "Or with email" divider widget.
class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.outlineVariant),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.spacingMd),
          child: Text(
            'Or with email',
            style: AppTextStyle.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 2.0,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.outlineVariant),
        ),
      ],
    );
  }
}