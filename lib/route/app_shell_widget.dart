import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_awhile_mobile/utils/widgets/app_bottom_nav_widget.dart';

class AppShellWidget extends StatelessWidget {
  const AppShellWidget({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabToIndex = {
    AppBottomNavTab.map: 0,
    AppBottomNavTab.explorer: 1,
    AppBottomNavTab.profile: 2,
  };

  static const _indexToTab = {
    0: AppBottomNavTab.map,
    1: AppBottomNavTab.explorer,
    2: AppBottomNavTab.profile,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavWidget(
        activeTab: _indexToTab[navigationShell.currentIndex]!,
        onTabChanged: (tab) {
          final index = _tabToIndex[tab]!;
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
