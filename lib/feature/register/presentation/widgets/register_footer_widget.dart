import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Footer with error message and sign-in link.
class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text(
              'Sign In',
              style: AppTextStyle.bodyMd.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
