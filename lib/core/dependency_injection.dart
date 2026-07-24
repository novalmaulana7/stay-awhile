import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:stay_awhile_mobile/core/auth_notifier.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/repositories/dashboard_repository.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/explore/data/datasources/explore_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/explore/data/repositories/explore_repository.dart';
import 'package:stay_awhile_mobile/feature/explore/data/repositories/explore_repository_impl.dart';
import 'package:stay_awhile_mobile/feature/explore/presentation/viewmodels/explore_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/profile/data/datasources/profile_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/profile/data/repositories/profile_repository.dart';
import 'package:stay_awhile_mobile/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:stay_awhile_mobile/feature/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/login/data/datasources/login_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/login/data/repositories/login_repository.dart';
import 'package:stay_awhile_mobile/feature/login/data/repositories/login_repository_impl.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/viewmodels/login_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/register/data/datasources/register_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/register/data/repositories/register_repository.dart';
import 'package:stay_awhile_mobile/feature/register/data/repositories/register_repository_impl.dart';
import 'package:stay_awhile_mobile/feature/register/presentation/viewmodels/register_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/splash/presentation/viewmodels/splash_viewmodel.dart';

/// Central dependency injection using GetIt service locator.
///
/// Call `DependencyInjection.init()` once at app startup (in main.dart)
/// before `runApp()` to register all app-level dependencies.
///
abstract final class DependencyInjection {
  DependencyInjection._();

  static final GetIt _getIt = GetIt.instance;

  /// Initialize all dependencies. Call once at app startup.
  static Future<void> init() async {
    // ── Firebase ──
    _getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    _getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    // ── Auth ──
    _getIt.registerLazySingleton<AuthNotifier>(() => AuthNotifier());

    // ── Profile Feature ──
    _getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(),
    );
    _getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: _getIt<ProfileRemoteDataSource>(),
      ),
    );
    _getIt.registerFactory<ProfileViewmodel>(
      () => ProfileViewmodel(
        repository: _getIt<ProfileRepository>(),
      ),
    );

    // ── Login Feature ──
    _getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(),
    );
    _getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(
        remoteDataSource: _getIt<LoginRemoteDataSource>(),
      ),
    );
    _getIt.registerFactory<LoginViewmodel>(
      () => LoginViewmodel(
        repository: _getIt<LoginRepository>(),
      ),
    );

    // ── Dashboard Feature ──
    _getIt.registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSource(),
    );
    _getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(
        remoteDataSource: _getIt<DashboardRemoteDataSource>(),
      ),
    );
    _getIt.registerFactory<DashboardViewmodel>(
      () => DashboardViewmodel(
        repository: _getIt<DashboardRepository>(),
      ),
    );

    // ── Register Feature ──
    _getIt.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSource(),
    );
    _getIt.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(
        remoteDataSource: _getIt<RegisterRemoteDataSource>(),
      ),
    );
    _getIt.registerFactory<RegisterViewmodel>(
      () => RegisterViewmodel(
        repository: _getIt<RegisterRepository>(),
      ),
    );

    // ── Splash Feature ──
    _getIt.registerFactory<SplashViewmodel>(
      () => SplashViewmodel(),
    );

    // ── Explore Feature ──
    _getIt.registerLazySingleton<ExploreRemoteDataSource>(
      () => ExploreRemoteDataSource(),
    );
    _getIt.registerLazySingleton<ExploreRepository>(
      () => ExploreRepositoryImpl(
        remoteDataSource: _getIt<ExploreRemoteDataSource>(),
      ),
    );
    _getIt.registerFactory<ExploreViewmodel>(
      () => ExploreViewmodel(
        repository: _getIt<ExploreRepository>(),
      ),
    );
  }
}