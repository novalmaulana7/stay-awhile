import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

class DashboardHeaderWidget extends StatelessWidget {
  const DashboardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSize.marginMobile : AppSize.marginDesktop,
        vertical: AppSize.spacingMd,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.park,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(width: AppSize.spacingSm),
              Text(
                'Stay Awhile',
                style: AppTextStyle.headlineMd.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (!isMobile) ...[
                _NavButton(label: 'Journal', onTap: () {}),
                const SizedBox(width: AppSize.spacingMd),
                _NavButton(label: 'Connections', onTap: () {}),
                const SizedBox(width: AppSize.spacingMd),
              ],
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyle.labelMd.copyWith(color: AppColors.onSurface),
      ),
    );
  }
}
