import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Message textarea input section for the Drop feature.
class DropMessageInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const DropMessageInputWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's on your mind?",
          style: AppTextStyle.labelMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSize.spacingSm),
        Container(
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
          padding: const EdgeInsets.all(AppSize.spacingMd),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLength: 500,
            maxLines: 6,
            buildCounter: (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSize.spacingXs),
                child: Text(
                  '$currentLength / $maxLength',
                  style: AppTextStyle.labelSm.copyWith(
                    color: currentLength >= maxLength!
                        ? AppColors.error
                        : AppColors.outlineVariant,
                  ),
                  textAlign: TextAlign.end,
                ),
              );
            },
            keyboardType: TextInputType.multiline,
            style: AppTextStyle.bodyLg.copyWith(color: AppColors.onSurface),
            decoration: InputDecoration(
              hintText:
                  'Share a quiet thought, a hidden gem, or a gentle warning for the next passerby...',
              hintStyle: AppTextStyle.bodyLg.copyWith(
                color: AppColors.outlineVariant,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
