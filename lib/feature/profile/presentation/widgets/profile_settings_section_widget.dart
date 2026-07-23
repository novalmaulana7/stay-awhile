import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/utils/widgets/paper_card.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_settings_item_widget.dart';

/// Displays the App Settings section with rows for Notifications, Privacy, Language, Support.
class SettingsSectionWidget extends StatelessWidget {
  final VoidCallback? onNotifications;
  final VoidCallback? onPrivacy;
  final VoidCallback? onLanguage;
  final VoidCallback? onSupport;

  const SettingsSectionWidget({
    super.key,
    this.onNotifications,
    this.onPrivacy,
    this.onLanguage,
    this.onSupport,
  });

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      child: Column(
        children: [
          SettingsItemWidget(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            trailingText: 'Enabled',
            onTap: onNotifications,
          ),
          SettingsItemWidget(
            icon: Icons.shield_outlined,
            title: 'Privacy & Safety',
            onTap: onPrivacy,
          ),
          SettingsItemWidget(
            icon: Icons.language,
            title: 'Language',
            trailingText: 'English',
            onTap: onLanguage,
          ),
          SettingsItemWidget(
            icon: Icons.help_outline,
            title: 'Support Center',
            onTap: onSupport,
          ),
        ],
      ),
    );
  }
}