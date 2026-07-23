import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';

class SplashLogoWidget extends StatelessWidget {
  final double bounceOffset;

  const SplashLogoWidget({super.key, required this.bounceOffset});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);
    final size = isMobile ? 192.0 : 256.0;

    return Transform.translate(
      offset: Offset(0, bounceOffset),
      child: Image.asset(
        'assets/images/logo_app.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
