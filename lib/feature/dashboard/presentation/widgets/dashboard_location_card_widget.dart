import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';

class DashboardLocationCardWidget extends StatelessWidget {
  final LocationInfo locationInfo;

  const DashboardLocationCardWidget({
    super.key,
    required this.locationInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      padding: const EdgeInsets.all(AppSize.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSize.radiusXl),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationInfo.name,
                      style: AppTextStyle.headlineMd.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      locationInfo.subtitle,
                      style: AppTextStyle.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.nature,
                color: AppColors.secondary,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: AppSize.spacingSm),
          Text(
            locationInfo.description,
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSize.spacingSm),
          if (locationInfo.avatarUrls.isNotEmpty)
            SizedBox(
              height: 32,
              child: Stack(
                children: [
                  for (int i = 0; i < locationInfo.avatarUrls.length && i < 2; i++)
                    Positioned(
                      left: i * 24.0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surface, width: 2),
                          color: AppColors.grey200,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            locationInfo.avatarUrls[i],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 16);
                            },
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: locationInfo.avatarUrls.length * 24.0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                        color: AppColors.primaryFixed,
                      ),
                      child: Center(
                        child: Text(
                          '+${locationInfo.neighborCount - locationInfo.avatarUrls.length}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onPrimaryFixed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
