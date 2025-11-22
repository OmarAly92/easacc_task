import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.hintStyle,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.required = false,
    this.needBorder = true,
    this.enabled = true,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
    this.isCollapsed,
  });

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool? isCollapsed;
  final bool required;
  final bool needBorder;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // if (label != null) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       AppText(
    //         label!,
    //         style: AppTextStyle.style14Regular.copyWith(
    //           color: AppColors.labelTextColor,
    //         ),
    //       ),
    //       const VerticalSpace(8),
    //       buildTextFormField(context),
    //     ],
    //   );
    // }
    return buildTextFormField(context);
  }

  Widget buildTextFormField(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      focusNode: focusNode,
      keyboardType: keyboardType,
      controller: controller,
      style: AppTextStyle.style14Medium,
      onChanged: onChanged,
      validator: validator,
      cursorColor: AppColors.mainColor,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines ?? 1,
      onTapOutside: (event) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).unfocus();
        });
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.style14Regular,
        hintText: required ? '$hint*' : hint,
        hintStyle: hintStyle ?? AppTextStyle.style12Medium.copyWith(color: AppColors.hintColor),
        isCollapsed: isCollapsed,
        fillColor: AppColors.fillColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderSide: needBorder
              ? BorderSide.none
              : const BorderSide(color: AppColors.textFieldBorder),

          borderRadius: AppConstants.textFormBorderRadius,
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: needBorder
              ? const BorderSide(color: AppColors.textFieldBorder)
              : BorderSide.none,
          borderRadius: AppConstants.textFormBorderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: needBorder
              ? const BorderSide(color: AppColors.textFieldBorder)
              : BorderSide.none,

          borderRadius: AppConstants.textFormBorderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textFieldBorder),
          borderRadius: AppConstants.textFormBorderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: AppConstants.textFormBorderRadius,
        ),
        errorStyle: const TextStyle(color: AppColors.error),
      ),
    );
  }
}
