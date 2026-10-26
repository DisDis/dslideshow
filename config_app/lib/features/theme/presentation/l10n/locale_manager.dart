import 'package:config_app/features/theme/presentation/l10n/app_locale.dart';
import 'package:config_app/features/theme/presentation/app_preferences.dart';
import 'package:flutter/material.dart';

abstract class LocaleManager {
  static void setRuLocale(BuildContext context) {
    setLocaleAction(context, AppLocale.ru);
  }

  static void setEnLocale(BuildContext context) {
    setLocaleAction(context, AppLocale.en);
  }

  static void setLocaleAction(BuildContext context, AppLocale locale) {
    AppPreferencesScope.of(context).setLocale(locale);
  }
}
