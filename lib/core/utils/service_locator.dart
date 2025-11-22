import 'package:dio/dio.dart';
import 'package:easacc_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:easacc_task/core/api/api_request_helpers/dio_consumer.dart';
import 'package:easacc_task/core/helpers/network/network_status.dart';
import 'package:easacc_task/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:easacc_task/feature/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:easacc_task/feature/auth/data/repository/auth_repository.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/logic/login_cubit.dart';
import 'package:easacc_task/feature/navigation/presentation/nav_bar_screen/logic/nav_bar_cubit.dart';
import 'package:easacc_task/feature/settings/data/data_source/device_scanner_data_source.dart';
import 'package:easacc_task/feature/settings/data/data_source/url_storage_data_source.dart';
import 'package:easacc_task/feature/settings/data/repository/settings_repository.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/logic/settings_cubit.dart';
import 'package:easacc_task/feature/webview/data/data_source/webview_url_data_source.dart';
import 'package:easacc_task/feature/webview/data/repository/webview_repository.dart';
import 'package:easacc_task/feature/webview/presentation/webview_screen/logic/webview_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    _coreSetup();
    _authFeatureSetup();
    _navigationFeatureSetup();
    _settingsFeatureSetup();
    _webViewFeatureSetup();
  }

  static void _authFeatureSetup() {
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl<AuthRepository>()));

    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(
        sl<AuthRemoteDataSource>(),
        sl<FirebaseAuthDataSource>(),
        sl<NetworkStatus>(),
      ),
    );

    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(sl<ApiConsumer>()),
    );

    sl.registerLazySingleton<FirebaseAuthDataSource>(() => FirebaseAuthDataSourceImp());
  }

  static void _navigationFeatureSetup() {
    sl.registerFactory<NavBarCubit>(() => NavBarCubit());
  }

  static void _settingsFeatureSetup() {
    sl.registerFactory<SettingsCubit>(() => SettingsCubit(sl<SettingsRepository>()));

    sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImp(sl<UrlStorageDataSource>(), sl<DeviceScannerDataSource>()),
    );

    sl.registerLazySingleton<UrlStorageDataSource>(() => UrlStorageDataSourceImp());

    sl.registerLazySingleton<DeviceScannerDataSource>(() => DeviceScannerDataSourceImp());
  }

  static void _webViewFeatureSetup() {
    sl.registerFactory<WebViewCubit>(() => WebViewCubit(sl<WebViewRepository>()));

    sl.registerLazySingleton<WebViewRepository>(
      () => WebViewRepositoryImp(sl<WebViewUrlDataSource>()),
    );

    sl.registerLazySingleton<WebViewUrlDataSource>(() => WebViewUrlDataSourceImp());
  }

  static void _coreSetup() {
    sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImp(sl<InternetConnection>()));
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer());

    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<InternetConnection>(
      () => InternetConnection.createInstance(
        customCheckOptions: [InternetCheckOption(uri: Uri.parse('https://www.google.com/'))],
      ),
    );
  }
}
