import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/primary_button.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    this.failure,
    this.onPressed,
    this.isEmpty = false,
    this.image,
    this.errorButtonMessage,
    this.emptyMessage,
  });

  final Failure? failure;
  final void Function()? onPressed;
  final bool isEmpty;
  final String? emptyMessage;
  final Widget? image;
  final String? errorButtonMessage;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // (image != null)
            //     ? image!
            //     : const Icon(
            //         CupertinoIcons.xmark_circle,
            //         size: 100,
            //         color: AppColors.error,
            //       ),
            // const VerticalSpace(10),
            AppText(
              emptyMessage ?? 'Empty',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: AppTextStyle.style16Medium,
            ),
          ],
        ),
      );
    }

    if (failure != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (image != null)
                ? image!
                : const Icon(
                    CupertinoIcons.exclamationmark_octagon,
                    size: 100,
                    color: AppColors.error,
                  ),
            const VerticalSpace(10),
            AppText(
              (failure?.message.isEmpty ?? true) ? 'Something went wrong' : failure!.message,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: AppTextStyle.style20Medium,
            ),
            const VerticalSpace(30),
            Visibility(
              visible: onPressed != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
                child: PrimaryButton.expand(
                  text: errorButtonMessage ?? 'Reload Screen',
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
