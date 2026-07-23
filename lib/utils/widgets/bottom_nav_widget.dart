import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

class BottomNavItem {
  final IconData icon;
  final String label;

  const BottomNavItem({required this.icon, required this.label});
}

class BottomNavWidget extends StatelessWidget {
  final List<BottomNavItem> items;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;

  const BottomNavWidget({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);

    if (!isMobile) {
      return _DesktopNav(
        items: items,
        activeIndex: activeIndex,
        onTabChanged: onTabChanged,
      );
    }

    return _MobileNav(
      items: items,
      activeIndex: activeIndex,
      onTabChanged: onTabChanged,
    );
  }
}

class _MobileNav extends StatelessWidget {
  final List<BottomNavItem> items;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;

  const _MobileNav({
    required this.items,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 12,
        top: 8,
        left: AppSize.spacingMd,
        right: AppSize.spacingMd,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          return _NavItem(
            icon: items[i].icon,
            label: items[i].label,
            isActive: activeIndex == i,
            onTap: () => onTabChanged(i),
          );
        }),
      ),
    );
  }
}

class _DesktopNav extends StatelessWidget {
  final List<BottomNavItem> items;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;

  const _DesktopNav({
    required this.items,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.spacingSm,
        vertical: AppSize.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (i) {
          return _DesktopNavItem(
            icon: items[i].icon,
            label: items[i].label,
            isActive: activeIndex == i,
            onTap: () => onTabChanged(i),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? AppColors.onPrimaryContainer
                  : AppColors.onSurfaceVariant,
              size: 24,
            ),
            Text(
              label,
              style: AppTextStyle.labelSm.copyWith(
                color: isActive
                    ? AppColors.onPrimaryContainer
                    : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DesktopNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? AppColors.onPrimaryContainer
                  : AppColors.onSurfaceVariant,
              size: 24,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyle.labelMd.copyWith(
                  color: AppColors.onPrimaryContainer,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
