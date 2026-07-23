import 'package:flutter/material.dart';
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
          imageAsset:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAx_6kXgpoeLaJDsriWl4gY_RXoKrK2F6YlS-r8eA2YSwf2IpsUqb4haWYCmsP7Uw-EHQv_LiRJHzzmQ-KYHxa9P17en5XIHyXv5ksYT5twruYakB3v-0k51GFVmkZDGQILET2H8KeJuRJFjsjd81FmP7z2YsNVv6GfJUwDgmgNKQNp31UbN-PDRazu18CUm3P_DXP-DIWUNxVdI4ov3Em5lUyyq2zbwyrisAqrvR2QxmnOOqlmDrgAaGTOiyztPQfCC7kH9_R-voY',
          text: 'Google',
          onPressed: onGoogleTap,
        ),
        const SizedBox(width: AppSize.spacingMd),
        SocialLoginButtonWidget(
          icon: Icons.apple,
          text: 'Apple',
          onPressed: onAppleTap,
        ),
      ],
    );
  }
}