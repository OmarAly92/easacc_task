import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the input is empty, just return
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove any non-digit characters (like commas)
    final String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Format number with commas
    final String formatted = _formatter.format(int.parse(newText));

    // Maintain cursor position
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
