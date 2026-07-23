import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';

/// Circular logo container with icon for mobile header.
class LogoCircleWidget extends StatelessWidget {
  const LogoCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.park,
        color: AppColors.onPrimaryContainer,
        size: 32,
      ),
    );
  }
}