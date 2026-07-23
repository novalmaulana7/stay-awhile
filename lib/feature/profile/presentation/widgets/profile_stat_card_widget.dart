import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/utils/widgets/paper_card.dart';

/// A single stat card showing a value and label (e.g. Messages Dropped / Found).
class StatCardWidget extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const StatCardWidget({
    super.key,
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyle.headlineMd.copyWith(color: valueColor),
          ),
          const SizedBox(height: AppSize.spacingXs),
          Text(
            label,
            style: AppTextStyle.labelMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}