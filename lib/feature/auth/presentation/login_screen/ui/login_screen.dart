import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easacc_task/core/app_routes/routes_strings.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_scaffold.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/logic/login_cubit.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/ui/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          context.showSnackBar(state.failure.message);
        }
        if (state is LoginSuccessState) {
          context.pushNamedAndRemoveUntil(RoutesStrings.appNavBarScreen, (route) => false);
        }
      },
      child: const AppScaffold(body: LoginBody()),
    );
  }
}
