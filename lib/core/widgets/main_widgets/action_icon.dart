import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';

class ActionIcon extends StatelessWidget {
  const ActionIcon({super.key, this.onTap, required this.icon});

  final void Function()? onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.zn50,
      borderRadius: BorderRadiusGeometry.circular(100),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: icon,
        ),
      ),
    );
  }
}
