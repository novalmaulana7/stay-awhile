import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_paper_card_widget.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';

/// A single dropped message card in the profile list.
class DroppedMessageItemWidget extends StatelessWidget {
  final DroppedMessageModel message;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DroppedMessageItemWidget({
    super.key,
    required this.message,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppPaperCardWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.title,
                            style: AppTextStyle.labelMd.copyWith(
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: AppSize.spacingXs),
                          Text(
                            '${message.timeAgo} at ${message.location}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSize.spacingSm),
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, size: 18),
                      color: AppColors.onSurfaceVariant,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      padding: EdgeInsets.zero,
                      splashRadius: 16,
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, size: 18),
                      color: AppColors.onSurfaceVariant,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      padding: EdgeInsets.zero,
                      splashRadius: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}