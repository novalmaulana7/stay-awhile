import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/utils/widgets/bottom_border_field_widget.dart';

/// Registration form with full name, email, password, terms and submit button.
class RegisterFormWidget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterFormWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomBorderFieldWidget(
          label: 'Full Name',
          hintText: 'John Doe',
          controller: fullNameController,
        ),
        const SizedBox(height: AppSize.spacingMd),
        BottomBorderFieldWidget(
          label: 'Email Address',
          hintText: 'you@example.com',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<RegisterViewmodel, bool>(
          selector: (_, vm) => vm.obscurePassword,
          builder: (_, obscurePassword, __) {
            return BottomBorderFieldWidget(
              label: 'Password',
              hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
              controller: passwordController,
              obscureText: obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<RegisterViewmodel>().togglePasswordVisibility();
                },
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.spacingSm),
        Selector<RegisterViewmodel, bool>(
          selector: (_, vm) => vm.agreeToTerms,
          builder: (_, agreeToTerms, __) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      context.read<RegisterViewmodel>().setAgreeToTerms(value);
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
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<RegisterViewmodel, RegisterStatus>(
          selector: (_, vm) => vm.status,
          builder: (_, status, __) {
            final isLoading = status == RegisterStatus.loading;
            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<RegisterViewmodel>().setFullName(
                              fullNameController.text,
                            );
                        context.read<RegisterViewmodel>().setEmail(
                              emailController.text,
                            );
                        context.read<RegisterViewmodel>().setPassword(
                              passwordController.text,
                            );
                        context.read<RegisterViewmodel>().register();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimaryContainer,
                  disabledBackgroundColor: AppColors.primaryContainer.withValues(alpha: 0.5),
                  elevation: 8,
                  shadowColor: AppColors.primaryContainer.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onPrimaryContainer,
                        ),
                      )
                    : Text(
                        'Create Account',
                        style: AppTextStyle.headlineMd,
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
