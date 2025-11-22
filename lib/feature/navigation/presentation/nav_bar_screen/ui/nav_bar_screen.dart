import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';
import 'package:easacc_task/feature/navigation/presentation/nav_bar_screen/logic/nav_bar_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/settings_screen.dart';
import 'package:easacc_task/feature/webview/presentation/webview_screen/ui/webview_screen.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: const [
              WebViewScreen(),
              SettingsScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      activeIcon: AppAsset.webviewActiveIcon,
                      inactiveIcon: AppAsset.webviewInactiveIcon,
                      label: 'WebView',
                      isSelected: state.currentIndex == 0,
                      onTap: () => context.read<NavBarCubit>().changeTab(0),
                    ),
                    _NavBarItem(
                      activeIcon: AppAsset.settingsActiveIcon,
                      inactiveIcon: AppAsset.settingsInactiveIcon,
                      label: 'Settings',
                      isSelected: state.currentIndex == 1,
                      onTap: () => context.read<NavBarCubit>().changeTab(1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String activeIcon;
  final String inactiveIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSvgImage(
              isSelected ? activeIcon : inactiveIcon,
              width: 24.w,
              height: 24.h,
              color: isSelected ? AppColors.primaryColor : AppColors.zn400,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primaryColor : AppColors.zn400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
