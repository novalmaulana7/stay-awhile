import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/widgets/dashboard_map_canvas_widget.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/widgets/dashboard_location_card_widget.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/widgets/dashboard_drop_message_button_widget.dart';
import 'package:stay_awhile_mobile/route/app_routes.dart';
import 'package:stay_awhile_mobile/utils/widgets/bottom_nav_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewmodel>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.park, color: AppColors.primary),
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
      ),
      bottomNavigationBar: BottomNavWidget(
        items: const [
          BottomNavItem(icon: Icons.map, label: 'Map'),
          BottomNavItem(icon: Icons.explore, label: 'Explorer'),
          BottomNavItem(icon: Icons.person, label: 'Profile'),
        ],
        activeIndex: 0,
        onTabChanged: (index) {
          final routes = [
            AppRoutes.dashboard,
            AppRoutes.explore,
            AppRoutes.profile,
          ];
          context.go(routes[index]);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Selector<DashboardViewmodel, DashboardStatus>(
              selector: (_, vm) => vm.status,
              builder: (_, status, _) {
                if (status == DashboardStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (status == DashboardStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: AppSize.spacingMd),
                        Selector<DashboardViewmodel, String?>(
                          selector: (_, vm) => vm.errorMessage,
                          builder: (_, msg, __) =>
                              Text(msg ?? 'Something went wrong'),
                        ),
                        const SizedBox(height: AppSize.spacingMd),
                        GestureDetector(
                          onTap: () => context
                              .read<DashboardViewmodel>()
                              .loadDashboard(),
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Selector<DashboardViewmodel,
                          ({List<MapMarker> markers, double lat, double lng})>(
                        selector: (_, vm) => (
                          markers: vm.markers,
                          lat: vm.currentPosition?.latitude ?? -6.8912,
                          lng: vm.currentPosition?.longitude ?? 107.6110,
                        ),
                        builder: (_, data, __) {
                          return DashboardMapCanvasWidget(
                            markers: data.markers,
                            centerLat: data.lat,
                            centerLng: data.lng,
                          );
                        },
                      ),
                    ),
                    if (!isMobile)
                      Positioned(
                        bottom: AppSize.spacingLg,
                        right: AppSize.marginDesktop,
                        child: Selector<DashboardViewmodel, LocationInfo?>(
                          selector: (_, vm) => vm.locationInfo,
                          builder: (_, locationInfo, __) {
                            if (locationInfo == null)
                              return const SizedBox.shrink();
                            return DashboardLocationCardWidget(
                              locationInfo: locationInfo,
                            );
                          },
                        ),
                      ),
                    Positioned(
                      bottom: isMobile ? 100 : AppSize.spacingLg,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Selector<DashboardViewmodel, bool>(
                          selector: (_, vm) => vm.showDropDialog,
                          builder: (_, showDrop, __) {
                            return DashboardDropMessageButtonWidget(
                              onPressed: () => context
                                  .read<DashboardViewmodel>()
                                  .toggleDropDialog(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
