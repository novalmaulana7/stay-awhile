import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Available tabs for the bottom navigation bar.
enum AppBottomNavTab { map, explorer, profile }

/// Reusable bottom navigation bar with responsive mobile/desktop layouts.
///
/// On mobile, renders a full-width bar with icon + label columns.
/// On tablet/desktop, renders a floating pill-shaped bar.
///
/// Uses [AppBottomNavTab] for type-safe tab identification.
/// Animates icon and label transitions via [AnimatedSwitcher] and
/// [AnimatedDefaultTextStyle].
///
/// ```dart
/// AppBottomNavWidget(
///   activeTab: AppBottomNavTab.map,
///   onTabChanged: (tab) => context.go(/* route */),
/// )
/// ```
class AppBottomNavWidget extends StatelessWidget {
  const AppBottomNavWidget({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  final AppBottomNavTab activeTab;
  final ValueChanged<AppBottomNavTab> onTabChanged;

  static const _items =
      <
        ({
          AppBottomNavTab tab,
          IconData icon,
          IconData activeIcon,
          String label,
        })
      >[
        (
          tab: AppBottomNavTab.map,
          icon: Icons.map_outlined,
          activeIcon: Icons.map,
          label: 'Map',
        ),
        (
          tab: AppBottomNavTab.explorer,
          icon: Icons.explore_outlined,
          activeIcon: Icons.explore,
          label: 'Explorer',
        ),
        (
          tab: AppBottomNavTab.profile,
          icon: Icons.person_outline_rounded,
          activeIcon: Icons.person_rounded,
          label: 'Profile',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);

    if (!isMobile) {
      return _DesktopNav(
        items: _items,
        activeTab: activeTab,
        onTabChanged: onTabChanged,
      );
    }

    return _MobileNav(
      items: _items,
      activeTab: activeTab,
      onTabChanged: onTabChanged,
    );
  }
}

class _MobileNav extends StatelessWidget {
  final List<
    ({AppBottomNavTab tab, IconData icon, IconData activeIcon, String label})
  >
  items;
  final AppBottomNavTab activeTab;
  final ValueChanged<AppBottomNavTab> onTabChanged;

  const _MobileNav({
    required this.items,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: ColoredBox(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.spacingMd,
              vertical: AppSize.spacingSm,
            ),
            decoration: const BoxDecoration(color: AppColors.white),
            child: Row(
              children: List.generate(items.length, (i) {
                final item = items[i];
                final isActive = item.tab == activeTab;

                return Expanded(
                  child: _NavItem(
                    icon: item.icon,
                    activeIcon: item.activeIcon,
                    label: item.label,
                    isActive: isActive,
                    onTap: () => onTabChanged(item.tab),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopNav extends StatelessWidget {
  final List<
    ({AppBottomNavTab tab, IconData icon, IconData activeIcon, String label})
  >
  items;
  final AppBottomNavTab activeTab;
  final ValueChanged<AppBottomNavTab> onTabChanged;

  const _DesktopNav({
    required this.items,
    required this.activeTab,
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
          final item = items[i];
          final isActive = item.tab == activeTab;

          return _DesktopNavItem(
            icon: item.icon,
            activeIcon: item.activeIcon,
            label: item.label,
            isActive: isActive,
            onTap: () => onTabChanged(item.tab),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foreground = isActive
        ? AppColors.onPrimaryContainer
        : AppColors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.94,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey('$label-$isActive'),
                color: foreground,
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: AppTextStyle.labelSm.copyWith(color: foreground),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DesktopNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foreground = isActive
        ? AppColors.onPrimaryContainer
        : AppColors.onSurfaceVariant;

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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.94,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey('$label-$isActive'),
                color: foreground,
                size: 24,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: AppTextStyle.labelMd.copyWith(color: foreground),
                child: Text(label),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
