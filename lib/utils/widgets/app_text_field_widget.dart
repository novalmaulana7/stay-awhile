import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Reusable text field with label, used across features.
///
/// Provides [AppTextFieldWidget] as the base field, plus convenience wrappers
/// [EmailFieldWidget] and [PasswordFieldWidget] for common patterns.
///
/// Supports pill-shaped (default) or underline-border style via [useUnderlineBorder].

/// Generic text field with label.
///
/// Supports pill-shaped (default) or underline-border style via [useUnderlineBorder].
/// ```dart
/// AppTextFieldWidget(
///   label: 'Name',
///   hintText: 'Enter your name',
///   controller: nameController,
/// )
/// ```
class AppTextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool useUnderlineBorder;

  const AppTextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.useUnderlineBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.labelMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: _decoration(),
        ),
      ],
    );
  }

  InputDecoration _decoration() {
    final hintStyle = AppTextStyle.bodyMd.copyWith(
      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
    );

    if (useUnderlineBorder) {
      return InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.outlineVariant, width: 2),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.outlineVariant, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryContainer, width: 2),
        ),
        suffixIcon: suffixIcon,
      );
    }

    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      filled: true,
      fillColor: AppColors.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
      suffixIcon: suffixIcon,
    );
  }
}

/// Email field widget (pill-shaped, for login).
class EmailFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWidget(
      label: 'Email Address',
      hintText: 'hello@community.com',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

/// Password field with visibility toggle (pill-shaped, for login).
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
    return AppTextFieldWidget(
      label: 'Password',
      hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
      controller: controller,
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: onToggleVisibility,
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
