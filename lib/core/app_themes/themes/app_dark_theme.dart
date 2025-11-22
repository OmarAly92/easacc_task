import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/utils/app_strings.dart';

sealed class AppDarkThemes {
  static ThemeData call() {
    return ThemeData(
      useMaterial3: true,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.mainColor,
        selectionColor: CupertinoColors.activeBlue.withValues(alpha: .4),
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      fontFamily: AppStrings.enFont,
      fontFamilyFallback: [AppStrings.arFont],
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.appbarBackground,
        titleTextStyle: AppTextStyle.style24SemiBold,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 16,
        shape: const Border(bottom: BorderSide(color: AppColors.appbarDivider, width: 1.5)),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        surfaceTintColor: Colors.transparent,
        // shadowColor: Colors.grey,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.zn200,
        labelStyle: AppTextStyle.style16Medium,
        unselectedLabelColor: AppColors.zn300,
        unselectedLabelStyle: AppTextStyle.style16Medium,
        dividerColor: AppColors.zn700,
        indicatorColor: AppColors.zn200,
        overlayColor: const WidgetStatePropertyAll<Color>(AppColors.zn700),
        splashFactory: InkRipple.splashFactory,
      ),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.mainColor,
      ),
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? const Icon(Icons.check, color: AppColors.primary, size: 20)
              : const Icon(Icons.close, size: 20),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? AppColors.primary : AppColors.white,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? AppColors.white : AppColors.primary,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? null : AppColors.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            side: const BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
      badgeTheme: const BadgeThemeData(backgroundColor: AppColors.red),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(AppColors.mainColor),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.zn700;
          }
          return AppColors.zn700;
        }),
        side: const BorderSide(color: AppColors.zn500),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 75,
        labelTextStyle: WidgetStatePropertyAll<TextStyle>(AppTextStyle.style14Light),
        overlayColor: const WidgetStatePropertyAll<Color>(AppColors.blue50),
        backgroundColor: AppColors.primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mainColor;
          }
          return AppColors.zn500;
        }),
      ),
      dividerColor: AppColors.appbarDivider,
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: AppColors.primary,
        todayForegroundColor: WidgetStatePropertyAll<Color>(AppColors.primary),
        confirmButtonStyle: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll<Color>(AppColors.mainColor),
        ),
        cancelButtonStyle: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll<Color>(AppColors.mainColor),
        ),
      ),
    );
  }
}
