import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

sealed class AppConstants {
  static const int slideAnimation = 350;
  static const int fadInAnimation = 350;

  /// Apply this on all project
  static const double borderRadius = 8;
  static BorderRadius borderRadiusCircular = BorderRadius.circular(
    borderRadius,
  );
  static BorderRadius borderRadiusCircularButton = BorderRadius.circular(
    borderRadius,
  );
  static BorderRadius textFormBorderRadius = BorderRadius.circular(
    borderRadius,
  );
  static const double horizontalPadding = 16;
  static const horizontalPaddingEdge = EdgeInsets.symmetric(
    horizontal: horizontalPadding,
  );

  static const double bottomNavBarHeight = 80;
  static const String authLogoHeroTag = 'authLogo';

  static const String appVersion = '1.0.0';

  /// Spacing
  static const double xxs = 4;
  static const double xs = 8;
  static const double small = 12;
  static const double large = 16;
  static const double xlarge = 20;
  static const double xxlarge = 24;

  static const String currencySymbol = 'EGP';
}
