import 'package:flutter/material.dart';

sealed class AppLocalization {
  static const enLocal = Locale('en');
  static const arLocal = Locale('ar');
  static const List<Locale> locales = [enLocal, arLocal];
}

/// To Run Code Generator of Keys
/// flutter pub run easy_localization:generate -S assets/translations -O lib/core/localization -o locale_keys.g.dart -f keys
