import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text_field.dart';
import 'package:easacc_task/core/widgets/main_widgets/primary_button.dart';
import 'package:easacc_task/core/widgets/main_widgets/secondary_button.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/logic/settings_cubit.dart';

class UrlInputSection extends StatelessWidget {
  const UrlInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('URL Configuration', style: AppTextStyle.style18Bold),
        const VerticalSpace(8),
        AppText(
          'Enter the website URL to display in the WebView',
          style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
        ),
        const VerticalSpace(16),
        Form(
          key: cubit.formKey,
          child: AppTextField(
            label: 'Website URL',
            hint: 'https://example.com',
            controller: cubit.urlController,
            keyboardType: TextInputType.url,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a URL';
              }
              return null;
            },
          ),
        ),
        const VerticalSpace(8),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (previous, current) =>
              current is UrlSavingState ||
              current is UrlSavedState ||
              current is UrlClearedState ||
              current is SettingsFailureState ||
              current is UrlLoadedState,
          builder: (context, state) {
            final isLoading = state is UrlSavingState;
            return Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Save URL',
                    isLoading: isLoading,
                    onPressed: () => cubit.saveUrl(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SecondaryButton(
                    text: 'Clear',
                    onPressed: isLoading ? null : () => cubit.clearUrl(),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
