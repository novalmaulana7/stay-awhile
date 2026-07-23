import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_email_field_widget.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_password_field_widget.dart';
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
        EmailFieldWidget(controller: emailController),
        const SizedBox(height: AppSize.spacingMd),
        Selector<LoginViewmodel, bool>(
          selector: (_, vm) => vm.obscurePassword,
          builder: (_, obscurePassword, __) {
            return PasswordFieldWidget(
              controller: passwordController,
              obscureText: obscurePassword,
              onToggleVisibility: () {
                context.read<LoginViewmodel>().togglePasswordVisibility();
              },
            );
          },
        ),
        const SizedBox(height: AppSize.spacingMd),
        Selector<LoginViewmodel, bool>(
          selector: (_, vm) => vm.rememberMe,
          builder: (_, rememberMe, __) {
            return RememberMeCheckboxWidget(
              value: rememberMe,
              onChanged: (value) {
                context.read<LoginViewmodel>().toggleRememberMe(value);
              },
            );
          },
        ),
        const SizedBox(height: AppSize.spacingLg),
        Selector<LoginViewmodel, LoginStatus>(
          selector: (_, vm) => vm.status,
          builder: (_, status, __) {
            return SignInButtonWidget(
              isLoading: status == LoginStatus.loading,
              onPressed: () {
                context.read<LoginViewmodel>().setEmail(emailController.text);
                context.read<LoginViewmodel>().setPassword(passwordController.text);
                context.read<LoginViewmodel>().login();
              },
            );
          },
        ),
        const SizedBox(height: AppSize.spacingXl),
        const LoginFooterWidget(),
      ],
    );
  }
}