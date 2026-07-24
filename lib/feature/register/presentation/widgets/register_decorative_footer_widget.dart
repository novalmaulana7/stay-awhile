import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// "Established locally" decorative footer.
class RegisterDecorativeFooterWidget extends StatelessWidget {
  const RegisterDecorativeFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSize.spacingLg,
      left: 0,
      right: 0,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.park, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            Text(
              'Established locally',
              style: AppTextStyle.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 4.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
