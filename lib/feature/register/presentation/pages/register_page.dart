import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/widgets/register_brand_header_widget.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/widgets/register_card_widget.dart';

/// Register page - handles user account creation.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegisterViewmodel>().attachControllers(
        fullNameController: _fullNameController,
        emailController: _emailController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
      );
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _BackgroundPainter()),
            ),
          ),
          Selector<RegisterViewmodel, RegisterStatus>(
            selector: (_, vm) => vm.status,
            builder: (_, status, _) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile
                      ? AppSize.marginMobile
                      : AppSize.marginDesktop,
                ).copyWith(top: AppSize.spacingXl, bottom: AppSize.spacingXl),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        const RegisterBrandHeaderWidget(),
                        RegisterCardWidget(
                          fullNameController: _fullNameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final greenPaint = Paint()
      ..color = AppColors.secondaryContainer.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);
    canvas.drawCircle(const Offset(-96, -96), 192, greenPaint);

    final amberPaint = Paint()
      ..color = AppColors.primaryContainer.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 160);
    canvas.drawCircle(
      Offset(size.width + 120, size.height + 120),
      250,
      amberPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
