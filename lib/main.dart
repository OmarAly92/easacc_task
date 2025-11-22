import 'package:easacc_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'core/helpers/localization/app_localization.dart';
import 'core/helpers/cache/cache_helper.dart';
import 'core/utils/app_assets.dart';
import 'core/utils/app_methods.dart';
import 'core/utils/service_locator.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!await AppMethods.isSafeDevice && kReleaseMode) {
    runApp(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('This device is not safe to use this app'))),
      ),
    );
    return;
  }
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    ServiceLocator.init(),
    CacheHelper.init(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);

  Bloc.observer = TalkerBlocObserver(
    settings: const TalkerBlocLoggerSettings(
      enabled: kDebugMode,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
      printEventFullData: false,
      printStateFullData: false,
    ),
  );

  /// Set the Orientation of the App to be Portrait Only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      startLocale: AppLocalization.enLocal,
      supportedLocales: AppLocalization.locales,
      path: AppAsset.translations,
      fallbackLocale: AppLocalization.locales.first,
      child: const MyApp(),
    ),
  );
}

/// To Generate Native Splash from [flutter_native_splash] package
/// dart run flutter_native_splash:create --path=flutter_native_splash.yaml

/// To Generate App Icon from [icons_launcher] package
/// dart run icons_launcher:create --path icons_launcher.yaml

/// To Run Build Runner
/// flutter pub run build_runner build --delete-conflicting-outputs

/// To Generate Localizations
/// dart run easy_localization:generate -S assets/translations -O lib/core/helpers/localization -o locale_keys.g.dart -f keys

/// Add Env file
/// Add in run in Additional run argus: --dart-define-from-file=env.json

/// To Generate KEY and IV for Encryption (Put it in env.json file as ENCRYPT_KEY , ENCRYPT_IV)
/// dart lib/core/helpers/encrypt_helper/crypto_generator.dart

/// on release the app on stores build the app with the following command
/// flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info --dart-define-from-file=env.json

/// Cleaning IOS Libraries Commands
/// rm -rf ios/Pods
/// rm -rf ios/Podfile.lock
/// rm -rf ~/Library/Developer/Xcode/DerivedData
/// flutter clean
/// cd ios
/// pod install --repo-update

/// Opening Xcode project in IOS
/// open ios/Runner.xcworkspace
