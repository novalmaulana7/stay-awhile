import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/drop/data/models/drop_model.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/viewmodels/drop_viewmodel.dart';

/// Horizontal scrollable category chip picker for the Drop feature.
class DropCategoryPickerWidget extends StatelessWidget {
  const DropCategoryPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a category',
          style: AppTextStyle.labelMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSize.spacingMd),
        SizedBox(
          height: 44,
          child: Selector<DropViewmodel, DropCategory?>(
            selector: (_, vm) => vm.selectedCategory,
            builder: (_, selected, _) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                itemCount: DropCategory.values.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSize.spacingSm),
                itemBuilder: (_, index) {
                  final category = DropCategory.values[index];
                  final isSelected = selected == category;
                  return _CategoryChip(
                    category: category,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<DropViewmodel>().selectCategory(category);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final DropCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  Color _iconColor() => switch (category) {
        DropCategory.quietSpot => AppColors.secondary,
        DropCategory.recommendation => AppColors.primary,
        DropCategory.warning => AppColors.error,
        DropCategory.story => AppColors.tertiary,
      };

  IconData _icon() => switch (category) {
        DropCategory.quietSpot => Icons.screen_rotation_outlined,
        DropCategory.recommendation => Icons.recommend_outlined,
        DropCategory.warning => Icons.warning_outlined,
        DropCategory.story => Icons.edit_note_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? AppColors.primaryContainer
        : AppColors.surfaceContainerLowest;
    final textColor =
        isSelected ? AppColors.onPrimaryContainer : AppColors.onSurface;
    final borderColor =
        isSelected ? Colors.transparent : AppColors.outlineVariant;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.spacingMd,
          vertical: AppSize.spacingSm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSize.radiusFull),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon(),
              size: 20,
              color: isSelected ? AppColors.onPrimaryContainer : _iconColor(),
            ),
            const SizedBox(width: AppSize.spacingSm),
            Text(
              category.label,
              style: AppTextStyle.labelMd.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
