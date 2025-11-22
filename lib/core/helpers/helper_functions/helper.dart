import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/primary_button.dart';

sealed class Helper {
  static String dateTimeFormat(DateTime date) {
    final String result = DateFormat('yyyy-MM-dd').format(date);
    return result;
  }

  static String dateStringFormat(String date) {
    final datetime = DateTime.tryParse(date);
    if (datetime == null) return '';
    final String result = DateFormat('yyyy-MM-dd h:m a').format(datetime);
    return result;
  }

  /// Shows a custom dialog with a centered message and one (or two) buttons at the bottom.
  ///
  /// [context] – the build context.
  /// [message] – the message text displayed in the center.
  /// [buttonText] – the text for the primary button.
  /// [buttonAction] – the action to perform when the primary button is tapped.
  /// [secondButtonText] – (optional) text for a second button.
  /// [secondButtonAction] – (optional) action to perform when the second button is tapped.
  static Future<void> showCustomDialog(
    BuildContext context, {
    required String message,
    required String buttonText,
    required VoidCallback buttonAction,
    String? secondButtonText,
    VoidCallback? secondButtonAction,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AppText(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.style16Regular,
                  ),
                ),
                const SizedBox(height: 16),
                secondButtonText != null && secondButtonAction != null
                    ? Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
                                context.pop();
                                buttonAction();
                              },
                              text: buttonText,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
                                context.pop();
                                secondButtonAction();
                              },
                              text: secondButtonText,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: context.width,
                        child: PrimaryButton(
                          onPressed: () {
                            context.pop();
                            buttonAction();
                          },
                          text: buttonText,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                AppText(message, style: AppTextStyle.style16Medium),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Hides the currently displayed dialog.
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static bool isAuthorization() => CacheHelper.get(CacheKeys.token) != null;
}
