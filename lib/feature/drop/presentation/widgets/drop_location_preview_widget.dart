import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Location preview card showing current map position for the Drop feature.
class DropLocationPreviewWidget extends StatelessWidget {
  final String locationLabel;
  final VoidCallback? onChangeLocation;

  const DropLocationPreviewWidget({
    super.key,
    required this.locationLabel,
    this.onChangeLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your current location',
              style: AppTextStyle.labelMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            GestureDetector(
              onTap: onChangeLocation,
              child: Text(
                'Change',
                style: AppTextStyle.labelMd.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.spacingMd),
        Container(
          height: 132,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppSize.radiusXl),
            border: Border.all(color: const Color(0xFFE0DED7)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.radiusXl),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                        AppColors.surfaceContainerHigh,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.spacingMd,
                    vertical: AppSize.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(AppSize.radiusFull),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: AppSize.spacingSm),
                      Text(
                        locationLabel,
                        style: AppTextStyle.labelSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
