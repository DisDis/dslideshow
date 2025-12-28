import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_i18n/i18n.dart';

// ignore_for_file: avoid-non-null-assertion
extension BuildContextExt on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);

  ThemeTextStyles get text => Theme.of(this).extension<ThemeTextStyles>()!;

  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;
}
