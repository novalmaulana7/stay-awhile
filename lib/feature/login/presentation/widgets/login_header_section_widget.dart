import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_mobile_header_widget.dart';

/// Header section of login card with welcome text.
class LoginHeaderSectionWidget extends StatelessWidget {
  const LoginHeaderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.spacingLg),
        const MobileHeaderWidget(),
        const SizedBox(height: AppSize.spacingLg),
        Text('Welcome Back', style: AppTextStyle.headlineLg),
        const SizedBox(height: 4),
        Text("We've saved your seat on the porch.", style: AppTextStyle.bodyMd),
      ],
    );
  }
}
