import 'package:go_router/go_router.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/pages/dashboard_page.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/pages/explore_page.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/pages/profile_page.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/pages/login_page.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/pages/splash_page.dart';
import 'package:stay_awhile_mobile/route/app_routes.dart';

/// The GoRouter configuration for the app.
///
/// Shell routes are used for persistent navigation (e.g. bottom nav bar).
/// Feature pages are lazy-loaded via their own builder.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    // ── Splash ──
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    // ── Login ──
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),

    // ── Dashboard ──
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),

    // ── Explore ──
    GoRoute(
      path: AppRoutes.explore,
      name: 'explore',
      builder: (context, state) => const ExplorePage(),
    ),

    // ── Profile ──
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
