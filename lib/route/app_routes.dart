/// Central registry for all route path constants.
///
/// Usage:
///   context.go(AppRoutes.dashboard);
///   context.go(AppRoutes.explore);
abstract final class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String explore = '/explore';
  static const String profile = '/profile';
  static const String register = '/register';
}
