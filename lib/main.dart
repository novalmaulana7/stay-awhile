import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/core/auth_notifier.dart';
import 'package:stay_awhile_mobile/core/dependency_injection.dart';
import 'package:stay_awhile_mobile/firebase_options.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/viewmodels/explore_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/viewmodels/splash_viewmodel.dart';
import 'package:stay_awhile_mobile/route/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DependencyInjection.init();
  runApp(const StayAwhileApp());
}

class StayAwhileApp extends StatelessWidget {
  const StayAwhileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.I<AuthNotifier>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<SplashViewmodel>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<ProfileViewmodel>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<LoginViewmodel>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<RegisterViewmodel>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<DashboardViewmodel>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<ExploreViewmodel>()),
      ],
      child: MaterialApp.router(
        title: 'Stay Awhile',
        debugShowCheckedModeBanner: false,

        // ── Theme ──
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            primaryContainer: AppColors.primaryContainer,
            onPrimaryContainer: AppColors.onPrimaryContainer,
            secondary: AppColors.secondary,
            onSecondary: AppColors.onSecondary,
            secondaryContainer: AppColors.secondaryContainer,
            onSecondaryContainer: AppColors.onSecondaryContainer,
            tertiary: AppColors.tertiary,
            onTertiary: AppColors.onTertiary,
            tertiaryContainer: AppColors.tertiaryContainer,
            onTertiaryContainer: AppColors.onTertiaryContainer,
            error: AppColors.error,
            onError: AppColors.onError,
            errorContainer: AppColors.errorContainer,
            onErrorContainer: AppColors.onErrorContainer,
            surface: AppColors.surface,
            onSurface: AppColors.onSurface,
            surfaceContainerHighest: AppColors.surfaceContainerHighest,
            outline: AppColors.outline,
            outlineVariant: AppColors.outlineVariant,
            inverseSurface: AppColors.inverseSurface,
            inversePrimary: AppColors.inversePrimary,
          ),
          textTheme: AppTextStyle.textTheme,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.onSurface,
            elevation: 0,
            centerTitle: true,
          ),
        ),

        // ── Router ──
        routerConfig: appRouter,
      ),
    );
  }
}
