import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_header_widget.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_stats_bento_grid_widget.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_dropped_messages_section_widget.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_settings_section_widget.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/widgets/profile_logout_section_widget.dart';
import 'package:stay_awhile_mobile/route/app_routes.dart';
import 'package:stay_awhile_mobile/utils/widgets/bottom_nav_widget.dart';

/// Profile page — shows profile info, stats, dropped messages, settings, and logout.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewmodel>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavWidget(
        items: const [
          BottomNavItem(icon: Icons.map, label: 'Map'),
          BottomNavItem(icon: Icons.explore, label: 'Explorer'),
          BottomNavItem(icon: Icons.person, label: 'Profile'),
        ],
        activeIndex: 2,
        onTabChanged: (index) {
          final routes = [AppRoutes.dashboard, AppRoutes.explore, AppRoutes.profile];
          context.go(routes[index]);
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: const SizedBox(width: kToolbarHeight),
        leadingWidth: kToolbarHeight,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.park, color: AppColors.primary, size: 28),
            const SizedBox(width: AppSize.spacingSm),
            Text(
              'Stay Awhile',
              style: AppTextStyle.headlineMd.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // actions: [
        //   Selector<ProfileViewmodel, VoidCallback>(
        //     selector: (_, vm) => vm.onNotifications,
        //     builder: (_, onNotifications, _) => IconButton(
        //       onPressed: onNotifications,
        //       icon: const Icon(Icons.notifications_outlined),
        //       color: AppColors.onSurface,
        //     ),
        //   ),
        // ],
      ),
      body: Consumer<ProfileViewmodel>(
        builder: (_, vm, _) {
          if (vm.status == ProfileStatus.loading && vm.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.status == ProfileStatus.error && vm.profile == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSize.spacingLg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      vm.errorMessage ?? 'Something went wrong',
                      style: AppTextStyle.bodyMd.copyWith(
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSize.spacingMd),
                    ElevatedButton(
                      onPressed: () => vm.loadProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final profile = vm.profile;
          if (profile == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.marginMobile,
            ).copyWith(top: AppSize.spacingLg, bottom: 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeaderWidget(
                  profile: profile,
                  onEditProfile: vm.onEditProfile,
                ),
                const SizedBox(height: AppSize.spacingXl),
                StatsBentoGridWidget(profile: profile),
                const SizedBox(height: AppSize.spacingXl),
                DroppedMessagesSectionWidget(
                  messages: vm.droppedMessages,
                  onViewAll: vm.onViewAllMessages,
                  onEditMessage: vm.onEditMessage,
                  onDeleteMessage: (id) =>
                      vm.confirmAndDeleteMessage(context, id),
                ),
                const SizedBox(height: AppSize.spacingXl),
                Text(
                  'App Settings',
                  style: AppTextStyle.headlineMd.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSize.spacingMd),
                SettingsSectionWidget(
                  onNotifications: vm.onSettingsNotifications,
                  onPrivacy: vm.onSettingsPrivacy,
                  onLanguage: vm.onSettingsLanguage,
                  onSupport: vm.onSettingsSupport,
                ),
                const SizedBox(height: AppSize.spacingXl),
                LogoutSectionWidget(
                  appVersion: profile.appVersion,
                  onLogout: vm.onLogout,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
