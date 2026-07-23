import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';

/// Footer with error message and sign up link.
class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<LoginViewmodel, String?>(
          selector: (_, vm) => vm.errorMessage,
          builder: (_, errorMessage, __) {
            if (errorMessage == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSize.spacingMd),
              child: Text(
                errorMessage,
                style: AppTextStyle.bodyMd.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        Text(
          "First time visiting?",
          style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
        TextButton(
          onPressed: () {
            context.read<LoginViewmodel>().onSignUp();
          },
          child: Text(
            'Create an account',
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