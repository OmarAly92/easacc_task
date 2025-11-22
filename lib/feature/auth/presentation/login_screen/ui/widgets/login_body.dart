import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_assets_image.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/horizontal_padding.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/feature/auth/data/model/social_user_model.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/logic/login_cubit.dart';
import 'package:easacc_task/feature/auth/presentation/login_screen/ui/widgets/social_login_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return HorizontalPadding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpace(24),
          AppText('Welcome Back', style: AppTextStyle.style24Bold),
          const VerticalSpace(8),
          AppText(
            'Sign in to continue',
            style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
          ),
          const VerticalSpace(40),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final isGoogleLoading =
                  state is LoginLoadingState && state.provider == SocialProvider.google;
              final isFacebookLoading =
                  state is LoginLoadingState && state.provider == SocialProvider.facebook;
              final isLoading = state is LoginLoadingState;

              return Column(
                children: [
                  SocialLoginButton(
                    text: 'Continue with Google',
                    iconPath: AppAsset.googleIcon,
                    isLoading: isGoogleLoading,
                    isDisabled: isLoading && !isGoogleLoading,
                    onPressed: () => cubit.loginWithGoogle(),
                  ),
                  const VerticalSpace(16),
                  SocialLoginButton(
                    text: 'Continue with Facebook',
                    iconPath: AppAsset.facebookIcon,
                    isLoading: isFacebookLoading,
                    isDisabled: isLoading && !isFacebookLoading,
                    backgroundColor: const Color(0xFF1877F2),
                    textColor: Colors.white,
                    onPressed: () => cubit.loginWithFacebook(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
