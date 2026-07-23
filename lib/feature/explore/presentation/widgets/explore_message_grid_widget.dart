import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_message_card_widget.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_featured_message_card_widget.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_community_note_card_widget.dart';

class ExploreMessageGridWidget extends StatelessWidget {
  final List<NearbyMessage> messages;

  const ExploreMessageGridWidget({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);
    final isDesktop = AppSize.isDesktop(context);

    if (messages.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSize.spacingXl),
          child: Text('No nearby messages found.'),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = isDesktop ? 3 : (isMobile ? 1 : 2);

        if (columns == 1) {
          return Column(
            children: messages.map((msg) => _buildCard(msg, false)).toList(),
          );
        }

        return Wrap(
          spacing: AppSize.gutter,
          runSpacing: AppSize.gutter,
          children: messages.asMap().entries.map((entry) {
            final index = entry.key;
            final msg = entry.value;
            final isFeatured = index == 0 && columns >= 2;

            final cardWidth = isFeatured
                ? (constraints.maxWidth - AppSize.gutter) * 0.65
                : (constraints.maxWidth - AppSize.gutter * (columns - 1)) /
                      columns;

            return SizedBox(
              width: cardWidth,
              child: _buildCard(msg, isFeatured),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCard(NearbyMessage msg, bool isFeatured) {
    if (msg.isCommunityNote) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSize.gutter),
        child: ExploreCommunityNoteCardWidget(message: msg),
      );
    }

    if (isFeatured || msg.isPinned) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSize.gutter),
        child: ExploreFeaturedMessageCardWidget(message: msg),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.gutter),
      child: ExploreMessageCardWidget(message: msg),
    );
  }
}
