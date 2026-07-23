import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';

class ExploreFabWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const ExploreFabWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.primaryContainer,
      foregroundColor: AppColors.onPrimaryContainer,
      elevation: 4,
      shape: const CircleBorder(),
      child: const Icon(Icons.edit),
    );
  }
}
