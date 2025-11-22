import 'package:easacc_task/core/app_routes/routes_strings.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/logic/settings_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadSavedUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFailureState) {
          context.showSnackBar(state.failure.message);
        }
        if (state is UrlSavedState) {
          context.showSnackBar('URL saved successfully', snackColor: AppColors.success);
        }
        if (state is UrlClearedState) {
          context.showSnackBar('URL cleared', snackColor: AppColors.success);
        }
        if (state is LogoutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesStrings.loginScreen, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppText('Settings', style: AppTextStyle.style18Bold),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                final cubit = context.read<SettingsCubit>();
                final isScanning = state is DeviceScanningState;

                return IconButton(
                  onPressed: isScanning ? null : () => cubit.scanDevices(),
                  icon: isScanning
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue200),
                          ),
                        )
                      : Icon(Icons.refresh, color: AppColors.blue200, size: 24.sp),
                );
              },
            ),
          ],
        ),
        body: const SettingsBody(),
      ),
    );
  }
}
