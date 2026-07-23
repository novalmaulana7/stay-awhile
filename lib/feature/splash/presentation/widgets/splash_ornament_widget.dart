import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';

class SplashOrnamentWidget extends StatelessWidget {
  final double opacity;

  const SplashOrnamentWidget({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: const Icon(
        Icons.park,
        size: 32,
        color: AppColors.outlineVariant,
      ),
    );
  }
}
