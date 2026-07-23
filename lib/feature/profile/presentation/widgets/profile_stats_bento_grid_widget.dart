import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_stat_card_widget.dart';

/// Displays the stats cards (Messages Dropped / Messages Found) in a 2-column grid.
class StatsBentoGridWidget extends StatelessWidget {
  final ProfileModel profile;

  const StatsBentoGridWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCardWidget(
            value: profile.messagesDropped.toString(),
            label: 'Messages Dropped',
            valueColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSize.spacingMd),
        Expanded(
          child: StatCardWidget(
            value: profile.messagesFound.toString(),
            label: 'Messages Found',
            valueColor: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}