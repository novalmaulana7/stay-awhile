import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

class SplashBrandWidget extends StatelessWidget {
  final double titleOpacity;
  final double taglineOffset;
  final double taglineOpacity;

  const SplashBrandWidget({
    super.key,
    required this.titleOpacity,
    required this.taglineOffset,
    required this.taglineOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: titleOpacity,
          child: Text(
            'Stay Awhile',
            style: AppTextStyle.headlineXl.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: AppSize.spacingXs),
        Transform.translate(
          offset: Offset(0, taglineOffset),
          child: Opacity(
            opacity: taglineOpacity,
            child: Text(
              'Discover the stories around you.',
              style: AppTextStyle.bodyLg.copyWith(
                color: AppColors.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
