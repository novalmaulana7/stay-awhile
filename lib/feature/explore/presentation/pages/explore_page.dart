import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/viewmodels/explore_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_radius_slider_widget.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_message_grid_widget.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_fab_widget.dart';
import 'package:stay_awhile_mobile/route/app_routes.dart';
import 'package:stay_awhile_mobile/utils/widgets/bottom_nav_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreViewmodel>().loadNearbyMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSize.isMobile(context);
    final paddingHorizontal = isMobile
        ? AppSize.marginMobile
        : AppSize.marginDesktop;

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
        activeIndex: 1,
        onTabChanged: (index) {
          final routes = [
            AppRoutes.dashboard,
            AppRoutes.explore,
            AppRoutes.profile,
          ];
          context.go(routes[index]);
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Selector<ExploreViewmodel, ExploreStatus>(
                  selector: (_, vm) => vm.status,
                  builder: (_, status, _) {
                    if (status == ExploreStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (status == ExploreStatus.error) {
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
                            Selector<ExploreViewmodel, String?>(
                              selector: (_, vm) => vm.errorMessage,
                              builder: (_, msg, __) =>
                                  Text(msg ?? 'Something went wrong'),
                            ),
                            const SizedBox(height: AppSize.spacingMd),
                            GestureDetector(
                              onTap: () => context
                                  .read<ExploreViewmodel>()
                                  .loadNearbyMessages(),
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

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: AppSize.spacingMd),
                          Selector<ExploreViewmodel, double>(
                            selector: (_, vm) => vm.radiusKm,
                            builder: (_, radius, __) {
                              final vm = context.read<ExploreViewmodel>();
                              return ExploreRadiusSliderWidget(
                                value: radius,
                                label: vm.radiusLabel,
                                onChanged: (val) => vm.onRadiusChanged(val),
                              );
                            },
                          ),
                          const SizedBox(height: AppSize.spacingLg),
                          Selector<ExploreViewmodel, List<NearbyMessage>>(
                            selector: (_, vm) => vm.messages,
                            builder: (_, messages, __) {
                              return ExploreMessageGridWidget(
                                messages: messages,
                              );
                            },
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: ExploreFabWidget(
        onPressed: () {
          // TODO: Navigate to compose message page
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
