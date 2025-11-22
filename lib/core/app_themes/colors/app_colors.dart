import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color blue25 = Color(0xFFE6F0FB);
  static const Color blue50 = Color(0xFFD9E8F9);
  static const Color blue100 = Color(0xFFB0D0F3);
  static const Color blue200 = Color(0xFF0068D9);
  static const Color blue300 = Color(0xFF0053AE);
  static const Color blue400 = Color(0xFF004EA3);
  static const Color blue500 = Color(0xFF003E82);
  static const Color blue600 = Color(0xFF002F62);
  static const Color blue700 = Color(0xFF00244C);

  static const Color zn25 = Color(0xFFfafafa);
  static const Color zn50 = Color(0xFFf4f4f5);
  static const Color zn100 = Color(0xFFe4e4e7);
  static const Color zn200 = Color(0xFFd4d4d8);
  static const Color zn300 = Color(0xFFa1a1aa);
  static const Color zn400 = Color(0xFF71717a);
  static const Color zn500 = Color(0xFF52525b);
  static const Color zn600 = Color(0xFF3f3f46);
  static const Color zn700 = Color(0xFF27272a);
  static const Color zn800 = Color(0xFF18181b);
  static const Color zn900 = Color(0xFF09090b);

  static const Color green = Color(0xFF38B000);
  static const Color purple = Color(0xFF9333EA);
  static const Color red = CupertinoColors.destructiveRed;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  /// Payroll details colors
  static const Color payrollTitle = Color(0xff4B5563);
  static const Color payrollBonusValue = Color(0xffBF6A02);
  static const Color payrollAllowancesValue = Color(0xff02542D);
  static const Color payrollNetSalaryValue = blue200;

  /// Error
  static const Color error = Color(0xffB3261E);

  /// Success
  static const Color success = green;

  static const Color primary = white;
  static const Color secondary = zn800;
  static const Color mainColor = blue200;
  static const Color primaryColor = blue200;

  /// Global Widget UI Colors
  static const Color scaffoldBackground = primary;
  static const Color appbarBackground = primary;
  static const Color divider = Color(0xffEFFAFE);
  static const Color appbarDivider = divider;

  /// Text Form Colors
  static const Color labelTextColor = zn300;
  static const Color hintColor = Color(0xFF8D9499);
  static const Color fillColor = zn700;
  static const Color bookedChairColor = Color(0xFFE8E8E8);
  static const Color subTitle = Color(0xFF6B7280);
  static const Color textFieldBorder = zn100;

  /// Chat Colors
  static const Color chatTextField = white;

  static Color get myMessageBubble => blue300;
  static const Color hisMessageBubble = zn100;
  static Color get myMessageBubbleText => white;
  static const Color hisMessageBubbleText = black;

  static Color get myMessageReply => zn600;
  static const Color hisMessageReply = white;
  static const Color myMessageReplyTitle = white;
  static const Color hisMessageReplyTitle = black;
  static const Color myMessageReplyText = white;
  static const Color hisMessageReplyText = black;
  static const Color messageBubbleTextColor = white;
}
