import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_assets.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_social_button_widget.dart';

/// Row of social login buttons (Google & Apple), used in login forms.
class LoginSocialLoginsRowWidget extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const LoginSocialLoginsRowWidget({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LoginSocialButtonWidget(
          imageAsset: AppAssets.icGoogle,
          text: 'Google',
          onPressed: onGoogleTap,
        ),
        const SizedBox(width: AppSize.spacingMd),
        LoginSocialButtonWidget(
          imageAsset: AppAssets.icApple,
          text: 'Apple',
          onPressed: onAppleTap,
        ),
      ],
    );
  }
}
