import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_text_field_widget.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/widgets/register_submit_button_widget.dart';

/// Registration form with full name, email, password, confirm password, terms and submit button.
class RegisterFormWidget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterFormWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<RegisterViewmodel, String?>(
          selector: (_, vm) => vm.fieldErrors['fullName'],
          builder: (_, error, _) {
            return _FieldWrapper(
              error: error,
              child: AppTextFieldWidget(
                label: 'Full Name',
                hintText: 'John Doe',
                controller: fullNameController,
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<RegisterViewmodel, String?>(
          selector: (_, vm) => vm.fieldErrors['email'],
          builder: (_, error, _) {
            return _FieldWrapper(
              error: error,
              child: AppTextFieldWidget(
                label: 'Email Address',
                hintText: 'you@example.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<RegisterViewmodel, ({bool obscure, String? error})>(
          selector: (_, vm) => (
            obscure: vm.obscurePassword,
            error: vm.fieldErrors['password'],
          ),
          builder: (_, data, _) {
            return _FieldWrapper(
              error: data.error,
              child: AppTextFieldWidget(
                label: 'Password',
                hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
                controller: passwordController,
                obscureText: data.obscure,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<RegisterViewmodel>().togglePasswordVisibility();
                  },
                  icon: Icon(
                    data.obscure ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<RegisterViewmodel, ({bool obscure, String? error})>(
          selector: (_, vm) => (
            obscure: vm.obscureConfirmPassword,
            error: vm.fieldErrors['confirmPassword'],
          ),
          builder: (_, data, _) {
            return _FieldWrapper(
              error: data.error,
              child: AppTextFieldWidget(
                label: 'Confirm Password',
                hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
                controller: confirmPasswordController,
                obscureText: data.obscure,
                suffixIcon: IconButton(
                  onPressed: () {
                    context
                        .read<RegisterViewmodel>()
                        .toggleConfirmPasswordVisibility();
                  },
                  icon: Icon(
                    data.obscure ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.spacingSm),
        Selector<RegisterViewmodel, ({bool agreed, String? error})>(
          selector: (_, vm) => (
            agreed: vm.agreeToTerms,
            error: vm.fieldErrors['agreeToTerms'],
          ),
          builder: (_, data, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: data.agreed,
                        onChanged: (value) {
                          context
                              .read<RegisterViewmodel>()
                              .setAgreeToTerms(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'I agree to the Terms and Privacy Policy',
                        style: AppTextStyle.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.error != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    data.error!,
                    style: AppTextStyle.labelSm.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        RegisterSubmitButtonWidget(
          fullNameController: fullNameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ),
      ],
    );
  }
}

/// Wraps a child widget and shows an error message below it when [error] is non-null.
class _FieldWrapper extends StatelessWidget {
  final String? error;
  final Widget child;

  const _FieldWrapper({required this.child, this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error!,
            style: AppTextStyle.labelSm.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
