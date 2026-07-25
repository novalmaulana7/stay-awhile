import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Header section of login card with welcome text.
class LoginHeaderSectionWidget extends StatelessWidget {
  const LoginHeaderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome Back', style: AppTextStyle.headlineLg),
        const SizedBox(height: 4),
        Text("We've saved your seat on the porch.", style: AppTextStyle.bodyMd),
      ],
    );
  }
}
