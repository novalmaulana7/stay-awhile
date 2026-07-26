import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_rounded_loading_button_widget.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_toast_widget.dart';

/// Sign in button for the login feature.
///
/// Delegates all animation logic to [AppRoundedLoadingButtonWidget].
/// Calls [LoginViewmodel.login] and reports success/error accordingly.
class SignInButtonWidget extends StatelessWidget {
  final LoginViewmodel viewmodel;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInButtonWidget({
    super.key,
    required this.viewmodel,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<LoginViewmodel, bool>(
      selector: (_, vm) => vm.canSubmit,
      builder: (_, canSubmit, _) {
        return AppRoundedLoadingButtonWidget(
          label: 'Sign In',
          isEnabled: canSubmit,
          resetDuration: const Duration(seconds: 3),
          onPressed: () async {
            viewmodel.setEmail(emailController.text);
            viewmodel.setPassword(passwordController.text);
            await viewmodel.login();
            if (!context.mounted) return false;
            if (viewmodel.status == LoginStatus.error) {
              AppToast.showError(
                context,
                title: 'Login Failed',
                message:
                    viewmodel.errorMessage ??
                    'Something went wrong. Please try again.',
              );
            }
            return viewmodel.status != LoginStatus.error;
          },
        );
      },
    );
  }
}
