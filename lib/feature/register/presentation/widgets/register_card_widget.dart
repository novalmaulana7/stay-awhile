import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/widgets/register_header_section_widget.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/widgets/register_social_buttons_widget.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/widgets/register_form_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_or_divider_widget.dart';

/// Registration card container with all form elements.
class RegisterCardWidget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterCardWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSize.radiusXl),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RegisterHeaderSectionWidget(),
          const SizedBox(height: AppSize.spacingLg),
          Consumer<RegisterViewmodel>(
            builder: (_, vm, __) {
              return RegisterSocialButtonsWidget(
                onGoogleTap: () => vm.registerWithGoogle(),
                onAppleTap: () => vm.registerWithApple(),
              );
            },
          ),
          const SizedBox(height: AppSize.spacingLg),
          const OrDividerWidget(),
          const SizedBox(height: AppSize.spacingLg),
          RegisterFormWidget(
            fullNameController: fullNameController,
            emailController: emailController,
            passwordController: passwordController,
          ),
        ],
      ),
    );
  }
}
