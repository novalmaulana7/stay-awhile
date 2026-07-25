import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_text_field_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_remember_me_checkbox_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_sign_in_button_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_footer_widget.dart';

/// Login form with email, password, remember me and submit button.
class LoginFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<LoginViewmodel, String?>(
          selector: (_, vm) => vm.fieldErrors['email'],
          builder: (_, error, _) {
            return _FieldWrapper(
              error: error,
              child: AppTextFieldWidget(
                label: 'Email Address',
                hintText: 'hello@community.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<LoginViewmodel, ({bool obscure, String? error})>(
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
                    context.read<LoginViewmodel>().togglePasswordVisibility();
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
        Selector<LoginViewmodel, bool>(
          selector: (_, vm) => vm.rememberMe,
          builder: (_, rememberMe, _) {
            return RememberMeCheckboxWidget(
              value: rememberMe,
              onChanged: (value) {
                context.read<LoginViewmodel>().toggleRememberMe(value);
              },
            );
          },
        ),
        const SizedBox(height: AppSize.spacingLg),
        SignInButtonWidget(
          viewmodel: context.read<LoginViewmodel>(),
          emailController: emailController,
          passwordController: passwordController,
        ),
        const SizedBox(height: AppSize.spacingXl),
        const LoginFooterWidget(),
      ],
    );
  }
}

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
