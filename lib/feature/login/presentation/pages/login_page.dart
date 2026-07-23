import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_card_widget.dart';

/// Login page - handles user authentication with email/password or social providers.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Selector<LoginViewmodel, LoginStatus>(
        selector: (_, vm) => vm.status,
        builder: (_, status, _) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? AppSize.marginMobile
                  : AppSize.marginDesktop,
            ).copyWith(top: AppSize.spacingLg, bottom: AppSize.spacingLg),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: LoginCardWidget(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
