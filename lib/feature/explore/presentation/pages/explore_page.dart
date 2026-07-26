import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_refresh_indicator/flutter_refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/viewmodels/explore_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_radius_slider_widget.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/widgets/explore_message_grid_widget.dart';

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
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<ExploreViewmodel>().loadNearbyMessages(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
                    Selector<
                      ExploreViewmodel,
                      ({
                        ExploreStatus status,
                        String? error,
                        List<NearbyMessage> messages,
                      })
                    >(
                      selector: (_, vm) => (
                        status: vm.status,
                        error: vm.errorMessage,
                        messages: vm.messages,
                      ),
                      builder: (_, data, __) {
                        if (data.status == ExploreStatus.loading &&
                            data.messages.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(AppSize.spacingXl),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (data.status == ExploreStatus.error &&
                            data.messages.isEmpty) {
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
                                Text(data.error ?? 'Something went wrong'),
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
                        return ExploreMessageGridWidget(
                          messages: data.messages,
                          currentUserId: context
                              .read<ExploreViewmodel>()
                              .currentUserId,
                        );
                      },
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
