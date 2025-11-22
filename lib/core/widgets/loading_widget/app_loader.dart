import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.isCentered = false, this.strokeWidth = 4})
    : isPagination = false,
      spinkit = false;

  const AppLoader.center({super.key, this.strokeWidth = 4})
    : isCentered = true,
      spinkit = false,
      isPagination = false;

  const AppLoader.pagination({super.key, this.strokeWidth = 4})
    : isCentered = true,
      spinkit = false,
      isPagination = true;

  const AppLoader.spinkit({super.key, this.strokeWidth = 4, this.isCentered = true})
    : spinkit = true,
      isPagination = false;

  final bool isCentered;
  final bool isPagination;
  final bool spinkit;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    if (spinkit) {
      return const SpinKitThreeBounce(color: AppColors.mainColor, size: 20);
    }
    if (isPagination) {
      return const CupertinoActivityIndicator();
    }
    if (isCentered) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.mainColor, strokeWidth: strokeWidth),
      );
    }
    return CircularProgressIndicator(color: AppColors.mainColor, strokeWidth: strokeWidth);
  }
}
