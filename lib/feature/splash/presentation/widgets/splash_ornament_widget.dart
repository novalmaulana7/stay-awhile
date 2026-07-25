import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stay_awhile_mobile/const/app_assets.dart';

class SplashOrnamentWidget extends StatelessWidget {
  final double opacity;

  const SplashOrnamentWidget({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Lottie.asset(
        AppAssets.circularProgressIndicator,
        width: 48,
        height: 48,
      ),
    );
  }
}
