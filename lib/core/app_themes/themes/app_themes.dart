import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/themes/app_dark_theme.dart';

sealed class AppThemes {
  static ThemeData dark() {
    return AppDarkThemes.call();
  }
}
