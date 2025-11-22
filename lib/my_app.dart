import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/app_routes/app_router.dart';
import 'package:easacc_task/core/app_routes/routes_strings.dart';
import 'package:easacc_task/core/app_themes/themes/app_themes.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:easacc_task/core/helpers/localization/localization_logic/localization_cubit.dart';
import 'package:easacc_task/core/utils/app_strings.dart';
import 'package:easacc_task/core/widgets/failure_widgets/custom_flutter_error_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => LocalizationCubit(context))],
          child: MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: ThemeMode.dark,
            darkTheme: AppThemes.dark(),
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: getInitialRoute(),
            navigatorKey: AppRouter.navigationKey,
            builder: (context, child) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomFlutterErrorWidget(errorDetails: errorDetails);
              };
              return child!;
            },
          ),
        );
      },
    );
  }

  String getInitialRoute() {
    final isLoggedIn = CacheHelper.get(CacheKeys.userEmail) != null;
    // final biometricEnabled = CacheHelper.get(CacheKeys.lastAuthTime) ?? true;

    // return RoutesStrings.biometricScreen;
    // if (isLoggedIn && biometricEnabled) {
    //   return RoutesStrings.biometricScreen;
    // }

    // return RoutesStrings.appNavBarScreen;
    if (isLoggedIn) {
      return RoutesStrings.appNavBarScreen;
    }

    return RoutesStrings.loginScreen;
  }
}
