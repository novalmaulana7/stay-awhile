import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';

/// Footer with error message and sign-in link.
class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<RegisterViewmodel, String?>(
          selector: (_, vm) => vm.errorMessage,
          builder: (_, errorMessage, __) {
            if (errorMessage == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                errorMessage,
                style: AppTextStyle.bodyMd.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        Text(
          'Already have an account?',
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
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
    );
  }
}
