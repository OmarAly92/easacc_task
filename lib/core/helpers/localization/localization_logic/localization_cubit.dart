import 'package:easy_localization/easy_localization.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easacc_task/core/utils/app_strings.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(BuildContext context) : super(const LocalizationChanged()) {
    _loadLanguage(context);
  }
  Future<void> _loadLanguage(BuildContext context) async {
    final languageCode = CacheHelper.get(CacheKeys.currentLanguage) ?? AppStrings.enLanguage;
    await changeLanguage(context, locale: Locale(languageCode));
  }

  Future<void> changeLanguage(BuildContext context, {required Locale locale}) async {
    await context.setLocale(locale);
    await CacheHelper.save(CacheKeys.currentLanguage, locale.languageCode);
    emit(const LocalizationChanged());
  }
}
