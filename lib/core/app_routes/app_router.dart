import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easacc_task/core/app_routes/routes_strings.dart';
import 'package:easacc_task/core/utils/app_strings.dart';
import 'package:easacc_task/core/utils/service_locator.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/logic/login_cubit.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/ui/login_screen.dart';
import 'package:easacc_task/feature/navigation/presentation/nav_bar_screen/logic/nav_bar_cubit.dart';
import 'package:easacc_task/feature/navigation/presentation/nav_bar_screen/ui/nav_bar_screen.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/logic/settings_cubit.dart';
import 'package:easacc_task/feature/webview/presentation/webview_screen/logic/webview_cubit.dart';

sealed class AppRouter {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case RoutesStrings.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case RoutesStrings.appNavBarScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<NavBarCubit>()),
              BlocProvider(create: (context) => sl<SettingsCubit>()),
              BlocProvider(create: (context) => sl<WebViewCubit>()),
            ],
            child: const NavBarScreen(),
          ),
        );
    }
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(body: Center(child: Text(AppStrings.noRouteFound)));
      },
    );
  }
}
