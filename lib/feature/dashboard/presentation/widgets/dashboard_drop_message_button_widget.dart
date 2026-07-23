import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

class DashboardDropMessageButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const DashboardDropMessageButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.spacingLg,
          vertical: AppSize.spacingMd,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.primaryContainer, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              color: AppColors.onPrimaryContainer,
              size: 24,
            ),
            const SizedBox(width: AppSize.spacingSm),
            Text(
              'DROP MESSAGE',
              style: AppTextStyle.labelMd.copyWith(
                color: AppColors.onPrimaryContainer,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
