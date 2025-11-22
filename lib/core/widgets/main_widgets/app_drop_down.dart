import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_disable_widget.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/labeled_container.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    super.key,
    this.isLoading = false,
    this.disable = false,
    this.failureMessage,
    required this.items,
    required this.title,
    this.onSelected,
    this.retryRequestOnFailure,
    required this.selectedItem,
    this.child,
    this.maxWidth,
    this.minWidth,
    this.itemBuilder,
    this.label,
  });

  final bool isLoading;
  final bool disable;
  final String? failureMessage;
  final String title;
  final String? label;

  // final List<PopupMenuEntry<T>> items;
  final void Function(T value)? onSelected;
  final void Function()? retryRequestOnFailure;
  final List<PopupMenuEntry<T>> Function(BuildContext)? itemBuilder;

  final T selectedItem;
  final List<T> items;
  final Widget? child;

  final double? maxWidth, minWidth;

  @override
  Widget build(BuildContext context) {
    return AppDisableWidget(
      disable: disable,
      iconSize: 21,
      child: PopupMenuButton<T>(
        position: PopupMenuPosition.under,
        // padding: EdgeInsets.symmetric(horizontal: 8),
        // menuPadding: EdgeInsets.symmetric(horizontal: 12),
        color: AppColors.white,
        // icon: Icon(Icons.arrow_drop_down),
        iconColor: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? context.width - 100,
          minWidth: minWidth ?? context.width - 100,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        itemBuilder:
            itemBuilder ??
            (BuildContext context) => items.map((item) {
              return PopupMenuItem<T>(
                value: item,
                child: Container(
                  color: item == selectedItem ? AppColors.zn50 : Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [AppText(item.toString(), style: AppTextStyle.style14Regular)],
                  ),
                ),
              );
            }).toList(),
        onSelected: onSelected,
        child:
            child ??
            LabelledContainer(
              fillColor: AppColors.white,
              label: label ?? '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    title,
                    style: AppTextStyle.style14Regular.copyWith(color: AppColors.black),
                  ),
                  buildTrailing(),
                ],
              ),
            ),
      ),
    );
  }

  Widget buildTrailing() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 3),
      );
    } else if (failureMessage != null) {
      return SizedBox(
        height: 20,
        width: 20,
        child: IconButton(
          onPressed: retryRequestOnFailure,
          tooltip: failureMessage,
          style: IconButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
          ),
          icon: const Icon(Icons.error_outline, size: 20, color: AppColors.red),
        ),
      );
    } else {
      return const Icon(Icons.arrow_drop_down, size: 20);
    }
  }
}
