import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_assets.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_social_login_button_widget.dart';

/// Vertical stack of social signup buttons (Google & Apple).
class RegisterSocialButtonsWidget extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const RegisterSocialButtonsWidget({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialLoginButtonWidget(
          imageAsset: AppAssets.icGoogle,
          text: 'Continue with Google',
          onPressed: onGoogleTap,
          isFullWidth: true,
        ),
        const SizedBox(height: AppSize.spacingMd),
        SocialLoginButtonWidget(
          imageAsset: AppAssets.icApple,
          text: 'Continue with Apple',
          onPressed: onAppleTap,
          isFullWidth: true,
        ),
      ],
    );
  }
}
