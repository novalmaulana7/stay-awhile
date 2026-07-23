import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_dropped_message_item_widget.dart';

/// Displays the "My Dropped Messages" section with header and list.
class DroppedMessagesSectionWidget extends StatelessWidget {
  final List<DroppedMessageModel> messages;
  final VoidCallback? onViewAll;
  final void Function(String messageId)? onEditMessage;
  final void Function(String messageId)? onDeleteMessage;

  const DroppedMessagesSectionWidget({
    super.key,
    required this.messages,
    this.onViewAll,
    this.onEditMessage,
    this.onDeleteMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'My Dropped Messages',
              style: AppTextStyle.headlineMd.copyWith(
                color: AppColors.onSurface,
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                'View All',
                style: AppTextStyle.labelMd.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.spacingMd),
        ...messages.map(
          (message) => Padding(
            padding: const EdgeInsets.only(bottom: AppSize.spacingMd),
            child: DroppedMessageItemWidget(
              message: message,
              onEdit: () => onEditMessage?.call(message.id),
              onDelete: () => onDeleteMessage?.call(message.id),
            ),
          ),
        ),
        if (messages.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.spacingLg),
            child: Center(
              child: Text(
                'No dropped messages yet',
                style: AppTextStyle.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
