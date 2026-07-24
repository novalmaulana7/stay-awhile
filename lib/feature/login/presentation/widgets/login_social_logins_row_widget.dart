import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_assets.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_social_login_button_widget.dart';

/// Row of social login buttons (Google & Apple).
class SocialLoginsRowWidget extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const SocialLoginsRowWidget({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SocialLoginButtonWidget(
          imageAsset: AppAssets.icGoogle,
          text: 'Google',
          onPressed: onGoogleTap,
        ),
        const SizedBox(width: AppSize.spacingMd),
        SocialLoginButtonWidget(
          imageAsset: AppAssets.icApple,
          text: 'Apple',
          onPressed: onAppleTap,
        ),
      ],
    );
  }
}
