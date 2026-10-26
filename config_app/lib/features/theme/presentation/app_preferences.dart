import 'package:config_app/features/theme/presentation/l10n/app_locale.dart';
import 'package:flutter/material.dart';

/// Appearance choices for this panel session, independent of the frame's config.
class AppPreferences extends ChangeNotifier {
  AppPreferences({ThemeMode? themeMode, AppLocale? appLocale})
    : _themeMode = themeMode ?? ThemeMode.system,
      _appLocale = appLocale ?? AppLocale.system;

  ThemeMode _themeMode;
  AppLocale _appLocale;

  ThemeMode get themeMode => _themeMode;
  AppLocale get appLocale => _appLocale;

  void setThemeMode(ThemeMode value) {
    if (_themeMode == value) return;
    _themeMode = value;
    notifyListeners();
  }

  void setLocale(AppLocale value) {
    if (_appLocale == value) return;
    _appLocale = value;
    notifyListeners();
  }
}

class AppPreferencesScope extends InheritedNotifier<AppPreferences> {
  const AppPreferencesScope({
    required AppPreferences preferences,
    required super.child,
    super.key,
  }) : super(notifier: preferences);

  static AppPreferences? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AppPreferencesScope>()
      ?.notifier;

  static AppPreferences of(BuildContext context) {
    final preferences = maybeOf(context);
    assert(preferences != null, 'No AppPreferencesScope found in context.');
    return preferences!;
  }
}
