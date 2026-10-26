import 'package:config_app/features/theme/presentation/app_preferences.dart';
import 'package:flutter/material.dart';

abstract class ThemeManager {
  static void setThemeMode(BuildContext context, ThemeMode mode) =>
      AppPreferencesScope.of(context).setThemeMode(mode);

  static void setLightTheme(BuildContext context) =>
      setThemeMode(context, ThemeMode.light);

  static void setDarkTheme(BuildContext context) =>
      setThemeMode(context, ThemeMode.dark);

  static void switchTheme(BuildContext context) => setThemeMode(
    context,
    Theme.of(context).brightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark,
  );
}
