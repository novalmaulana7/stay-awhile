import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';

/// Reusable paper card container matching the HTML `.paper-card` style.
///
/// Renders a white card with subtle border and soft shadow, matching
/// the warm paper aesthetic of the Stay Awhile design system.
///
/// ```dart
/// AppPaperCardWidget(
///   child: Text('Hello'),
/// )
/// ```
class AppPaperCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const AppPaperCardWidget({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSize.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color(0xFFE0DED7)),
        borderRadius: BorderRadius.circular(borderRadius ?? AppSize.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}