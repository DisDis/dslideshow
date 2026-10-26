import 'package:flutter/material.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';

enum AppLocale {
  system,
  en,
  ru;

  const AppLocale();

  Locale? get locale {
    switch (this) {
      case AppLocale.system:
        return null;
      case AppLocale.en:
        return const Locale('en');
      case AppLocale.ru:
        return const Locale('ru');
    }
  }

  String toLanguage(BuildContext context) {
    switch (this) {
      case AppLocale.system:
        return context.localizations.ui_system_default;
      case AppLocale.en:
        return context.localizations.english;
      case AppLocale.ru:
        return context.localizations.russian;
    }
  }
}
