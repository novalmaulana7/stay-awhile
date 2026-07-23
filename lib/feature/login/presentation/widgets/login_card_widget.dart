import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_header_section_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_social_logins_row_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_or_divider_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_form_widget.dart';

/// Login card container widget with all login form elements.
class LoginCardWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginCardWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE0DED7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoginHeaderSectionWidget(),
          const SizedBox(height: AppSize.spacingXl),
          Consumer<LoginViewmodel>(
            builder: (_, vm, __) {
              return SocialLoginsRowWidget(
                onGoogleTap: () => vm.loginWithGoogle(),
                onAppleTap: () => vm.loginWithApple(),
              );
            },
          ),
          const SizedBox(height: AppSize.spacingXl),
          const OrDividerWidget(),
          const SizedBox(height: AppSize.spacingXl),
          LoginFormWidget(
            emailController: emailController,
            passwordController: passwordController,
          ),
        ],
      ),
    );
  }
}