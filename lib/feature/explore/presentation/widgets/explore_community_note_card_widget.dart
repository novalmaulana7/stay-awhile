import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

class ExploreCommunityNoteCardWidget extends StatelessWidget {
  final NearbyMessage message;

  const ExploreCommunityNoteCardWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.primaryFixed,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.onPrimaryFixedVariant,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.onPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSize.spacingSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community Note',
                    style: AppTextStyle.labelMd.copyWith(
                      color: AppColors.onPrimaryFixed,
                    ),
                  ),
                  Text(
                    message.timeAgo,
                    style: AppTextStyle.labelSm.copyWith(
                      color: AppColors.onPrimaryFixedVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSize.spacingSm),
          Text(
            '"${message.text}"',
            style: AppTextStyle.bodyMd.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: AppColors.onPrimaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}
