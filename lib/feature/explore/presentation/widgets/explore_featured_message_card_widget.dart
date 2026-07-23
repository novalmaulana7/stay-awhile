import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

class ExploreFeaturedMessageCardWidget extends StatelessWidget {
  final NearbyMessage message;
  final VoidCallback? onLikeTap;

  const ExploreFeaturedMessageCardWidget({
    super.key,
    required this.message,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      message.authorPhotoUrl ?? '',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceContainerHigh,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.spacingSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.authorName,
                        style: AppTextStyle.labelMd,
                      ),
                      Text(
                        '${message.timeAgo} • ${message.distance}',
                        style: AppTextStyle.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.push_pin,
                color: AppColors.tertiary,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: AppSize.spacingMd),
          Text(
            '"${message.text}"',
            style: AppTextStyle.bodyLg.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSize.spacingLg),
          Row(
            children: [
              _ActionChip(
                icon: Icons.favorite,
                count: message.likeCount,
                onTap: onLikeTap,
              ),
              const SizedBox(width: AppSize.spacingMd),
              _ActionChip(
                icon: Icons.chat_bubble,
                count: message.commentCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  const _ActionChip({
    required this.icon,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.onSecondaryFixedVariant,
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: AppTextStyle.labelSm.copyWith(
              color: AppColors.onSecondaryFixedVariant,
            ),
          ),
        ],
      ),
    );
  }
}
