import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/route/app_routes.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_rounded_loading_button_widget.dart';

/// Register submit button for the registration feature.
///
/// Delegates all animation logic to [AppRoundedLoadingButtonWidget].
/// Calls [RegisterViewmodel.register] and reports success/error accordingly.
class RegisterSubmitButtonWidget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterSubmitButtonWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterViewmodel, bool>(
      selector: (_, vm) => vm.canSubmit,
      builder: (_, canSubmit, _) {
        return AppRoundedLoadingButtonWidget(
          label: 'Create Account',
          isEnabled: canSubmit,
          onPressed: () async {
            final vm = context.read<RegisterViewmodel>();
            vm.setFullName(fullNameController.text);
            vm.setEmail(emailController.text);
            vm.setPassword(passwordController.text);
            vm.setConfirmPassword(confirmPasswordController.text);
            await vm.register();
            if (vm.status == RegisterStatus.error) return false;
            if (context.mounted) {
              context.go(AppRoutes.login);
            }
            return true;
          },
        );
      },
    );
  }
}
