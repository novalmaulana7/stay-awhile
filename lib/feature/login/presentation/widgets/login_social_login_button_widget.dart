import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Button for social login options (Google, Apple).
class SocialLoginButtonWidget extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;
  final String? imageAsset;

  const SocialLoginButtonWidget({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surfaceContainerLowest,
            foregroundColor: AppColors.onSurface,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
              side: const BorderSide(color: AppColors.outlineVariant),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageAsset != null) ...[
                Image.network(
                  imageAsset!,
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                    );
                  },
                ),
              ] else if (icon != null) ...[
                Icon(icon, size: 20, color: AppColors.onSurface),
              ],
              const SizedBox(width: 8),
              Text(
                text,
                style: AppTextStyle.labelMd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}