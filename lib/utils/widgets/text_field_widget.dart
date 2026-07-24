import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Reusable text field with label, used across features.
///
/// Provides [EmailFieldWidget] and [PasswordFieldWidget] as convenience
/// wrappers for common field patterns.

/// Standard text field decoration used by all field variants.
InputDecoration _baseDecoration({
  required String hintText,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: AppTextStyle.bodyMd.copyWith(
      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
    ),
    filled: true,
    fillColor: AppColors.surfaceContainerLow,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(
        color: AppColors.primaryContainer,
        width: 1.5,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    suffixIcon: suffixIcon,
  );
}

/// Email field widget.
class EmailFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: AppTextStyle.labelMd.copyWith(color: AppColors.onSurface),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: _baseDecoration(hintText: 'hello@community.com'),
        ),
      ],
    );
  }
}

/// Password field with visibility toggle.
class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: AppTextStyle.labelMd.copyWith(color: AppColors.onSurface),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: _baseDecoration(
            hintText: '••••••••',
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
