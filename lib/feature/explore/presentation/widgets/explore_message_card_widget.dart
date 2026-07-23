import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

class ExploreMessageCardWidget extends StatelessWidget {
  final NearbyMessage message;
  final VoidCallback? onLikeTap;

  const ExploreMessageCardWidget({
    super.key,
    required this.message,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.spacingMd),
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
            children: [
              _Avatar(url: message.authorPhotoUrl, name: message.authorName),
              const SizedBox(width: AppSize.spacingSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.authorName,
                      style: AppTextStyle.labelMd,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      message.timeAgo,
                      style: AppTextStyle.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.spacingSm),
          Text(
            message.text,
            style: AppTextStyle.bodyMd,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSize.spacingSm),
          Container(
            padding: const EdgeInsets.only(top: AppSize.spacingSm),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.surfaceVariant)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (message.hashtag != null)
                  Text(
                    message.hashtag!,
                    style: AppTextStyle.labelSm.copyWith(
                      color: AppColors.secondary,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                const Icon(Icons.more_horiz, color: AppColors.surfaceVariant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? url;
  final String name;

  const _Avatar({required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surfaceContainerHigh,
        ),
        child: const Icon(
          Icons.person,
          color: AppColors.onSurfaceVariant,
          size: 20,
        ),
      );
    }

    return ClipOval(
      child: Image.network(
        url!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainerHigh,
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.onSurfaceVariant,
            size: 20,
          ),
        ),
      ),
    );
  }
}
