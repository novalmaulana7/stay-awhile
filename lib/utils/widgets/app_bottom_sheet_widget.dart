import 'package:flutter/material.dart';

import '../../const/app_colors.dart';
import '../../const/app_size.dart';
import '../../const/app_textstyle.dart';

/// Reusable confirmation bottom sheet.
///
/// Use the static [show] method to display it:
/// ```dart
/// AppBottomSheetWidget.show(
///   context: context,
///   icon: Icons.logout_rounded,
///   iconColor: AppColors.secondary,
///   title: 'Logout?',
///   message: 'Are you sure you want to logout?',
///   confirmLabel: 'Logout',
///   confirmColor: AppColors.secondary,
///   onConfirm: () => logout(),
/// );
/// ```
class AppBottomSheetWidget extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final Color confirmColor;
  final Color confirmTextColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const AppBottomSheetWidget({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.confirmColor = AppColors.primary,
    this.confirmTextColor = AppColors.onSurface,
    required this.onConfirm,
    this.onCancel,
  });

  /// Convenience method to show the bottom sheet and return the result.
  ///
  /// Returns `true` when the user taps the confirm button, `false` or `null`
  /// otherwise.
  static Future<bool?> show({
    required BuildContext context,
    IconData? icon,
    Color? iconColor,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    Color confirmColor = AppColors.primary,
    Color confirmTextColor = AppColors.onSurface,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AppBottomSheetWidget(
        icon: icon,
        iconColor: iconColor,
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        confirmColor: confirmColor,
        confirmTextColor: confirmTextColor,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outlineVariant,
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          if (icon != null) ...[
            const SizedBox(height: AppSize.spacingLg),
            Icon(icon!, size: 48, color: iconColor ?? AppColors.primary),
          ],
          const SizedBox(height: AppSize.spacingLg),
          Text(
            title,
            style: AppTextStyle.headlineMd.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSize.spacingSm),
          Text(
            message,
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSize.spacingLg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    onCancel?.call();
                    Navigator.pop(context, false);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.onSurface,
                    side: const BorderSide(color: AppColors.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSize.radiusFull),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.spacingMd,
                    ),
                  ),
                  child: Text(
                    cancelLabel,
                    style: AppTextStyle.labelMd.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSize.spacingMd),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                    foregroundColor: confirmTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSize.radiusFull),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.spacingMd,
                    ),
                  ),
                  child: Text(
                    confirmLabel,
                    style: AppTextStyle.labelMd.copyWith(
                      color: confirmTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
