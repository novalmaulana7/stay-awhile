import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Text field with bottom-border focus style, used in registration forms.
///
/// Different from [EmailFieldWidget]/[PasswordFieldWidget] which use
/// pill-shaped containers. This variant uses a clean underline focus effect.
class BottomBorderFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const BottomBorderFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.labelMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            filled: true,
            fillColor: AppColors.surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 16,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryContainer,
                width: 2,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
