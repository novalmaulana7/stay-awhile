import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_assets.dart';

/// Brand header with logo and app name for register page.
class RegisterBrandHeaderWidget extends StatelessWidget {
  const RegisterBrandHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.logoAppBar,
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
