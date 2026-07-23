import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/viewmodels/splash_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/widgets/splash_logo_widget.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/widgets/splash_brand_widget.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/widgets/splash_ornament_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final AnimationController _fadeInController;
  late final AnimationController _slideUpController;
  late final AnimationController _ornamentController;

  late final Animation<double> _bounceAnimation;
  late final Animation<double> _fadeInAnimation;
  late final Animation<double> _slideUpAnimation;
  late final Animation<double> _taglineOpacityAnimation;
  late final Animation<double> _ornamentAnimation;

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _fadeInController,
      curve: Curves.easeOut,
    );

    _slideUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideUpAnimation = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(
        parent: _slideUpController,
        curve: const Cubic(0.22, 1, 0.36, 1),
      ),
    );

    _taglineOpacityAnimation = CurvedAnimation(
      parent: _slideUpController,
      curve: Curves.easeOut,
    );

    _ornamentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _ornamentAnimation = CurvedAnimation(
      parent: _ornamentController,
      curve: Curves.easeOut,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _fadeInController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _slideUpController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _ornamentController.forward();
    });

    Future.delayed(SplashViewmodel.splashDuration, () {
      if (!mounted) return;
      final route = context.read<SplashViewmodel>().getInitialRoute();
      context.go(route);
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _fadeInController.dispose();
    _slideUpController.dispose();
    _ornamentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Container(
                width: AppSize.widthPercent(context, 0.8),
                height: AppSize.heightPercent(context, 0.8),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryFixed.withValues(alpha: 0.1),
                      blurRadius: 120,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (_, __) => SplashLogoWidget(
                    bounceOffset: _bounceAnimation.value,
                  ),
                ),
                const SizedBox(height: AppSize.spacingLg),
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _fadeInAnimation,
                    _slideUpAnimation,
                    _taglineOpacityAnimation,
                  ]),
                  builder: (_, __) => SplashBrandWidget(
                    titleOpacity: _fadeInAnimation.value,
                    taglineOffset: _slideUpAnimation.value,
                    taglineOpacity: _taglineOpacityAnimation.value,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _ornamentAnimation,
                builder: (_, __) => SplashOrnamentWidget(
                  opacity: _ornamentAnimation.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
