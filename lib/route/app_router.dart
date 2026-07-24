import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_awhile_mobile/core/auth_notifier.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/pages/dashboard_page.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/pages/explore_page.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/pages/profile_page.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/pages/login_page.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/pages/register_page.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/pages/splash_page.dart';
import 'package:stay_awhile_mobile/route/app_routes.dart';

final authNotifier = GetIt.I<AuthNotifier>();

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  refreshListenable: authNotifier,
  redirect: (context, state) {
    final user = authNotifier.currentUser;
    final onAuthRoute = state.matchedLocation == AppRoutes.splash ||
        state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register;

    if (user == null && !onAuthRoute) return AppRoutes.login;
    if (user != null && onAuthRoute) return AppRoutes.dashboard;
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: AppRoutes.explore,
      name: 'explore',
      builder: (context, state) => const ExplorePage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
