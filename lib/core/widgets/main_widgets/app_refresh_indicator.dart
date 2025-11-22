import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({super.key, required this.child, required this.onRefresh});

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.white,
      color: AppColors.mainColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
