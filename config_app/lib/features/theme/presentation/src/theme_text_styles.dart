part of '../theme.dart';

// ignore_for_file: avoid-non-null-assertion, no-equal-arguments
class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  final TextStyle appTitle;
  final TextStyle appDescription;
  final TextStyle labelStyle;
  final TextStyle searchHint;
  final TextStyle searchInput;
  final TextStyle settingsDialogLanguage;
  final TextStyle chatDateStyle;
  final TextStyle chatMessageTextStyle;

  ThemeTextStyles({
    required this.appTitle,
    required this.appDescription,
    required this.labelStyle,
    required this.searchHint,
    required this.searchInput,
    required this.settingsDialogLanguage,
    required this.chatDateStyle,
    required this.chatMessageTextStyle,
  });

  @override
  // ignore: long-parameter-list
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? appBarTitle,
    TextStyle? appTitle,
    TextStyle? appDescription,
    TextStyle? labelStyle,
    TextStyle? searchHint,
    TextStyle? searchInput,
    TextStyle? settingsDialogLanguage,
    TextStyle? chatDateStyle,
    TextStyle? chatMessageTextStyle,
  }) {
    return ThemeTextStyles(
      appTitle: appTitle ?? this.appTitle,
      appDescription: appDescription ?? this.appDescription,
      labelStyle: labelStyle ?? this.labelStyle,
      searchHint: searchHint ?? this.searchHint,
      searchInput: searchInput ?? this.searchInput,
      chatDateStyle: chatDateStyle ?? this.chatDateStyle,
      chatMessageTextStyle: chatMessageTextStyle ?? this.chatMessageTextStyle,
      settingsDialogLanguage:
          settingsDialogLanguage ?? this.settingsDialogLanguage,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      appTitle: TextStyle.lerp(appTitle, other.appTitle, t)!,
      appDescription: TextStyle.lerp(appDescription, other.appDescription, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      searchHint: TextStyle.lerp(searchHint, other.searchHint, t)!,
      chatDateStyle: TextStyle.lerp(chatDateStyle, other.chatDateStyle, t)!,
      searchInput: TextStyle.lerp(searchInput, other.searchInput, t)!,
      chatMessageTextStyle: TextStyle.lerp(
        chatMessageTextStyle,
        other.chatMessageTextStyle,
        t,
      )!,
      settingsDialogLanguage: TextStyle.lerp(
        settingsDialogLanguage,
        other.settingsDialogLanguage,
        t,
      )!,
    );
  }

  factory ThemeTextStyles.fromTheme(TextTheme text, ColorScheme scheme) =>
      ThemeTextStyles(
        appTitle: text.titleLarge!,
        appDescription: text.bodyMedium!.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        labelStyle: text.labelLarge!,
        searchHint: text.bodyLarge!.copyWith(color: scheme.onSurfaceVariant),
        searchInput: text.bodyLarge!,
        settingsDialogLanguage: text.bodyMedium!,
        chatDateStyle: text.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
        chatMessageTextStyle: text.bodyLarge!.copyWith(
          color: scheme.onSecondaryContainer,
        ),
      );

  static ThemeTextStyles get light {
    final scheme = _createColorScheme(Brightness.light);
    return ThemeTextStyles.fromTheme(createTextTheme(scheme), scheme);
  }

  static ThemeTextStyles get dark {
    final scheme = _createColorScheme(Brightness.dark);
    return ThemeTextStyles.fromTheme(createTextTheme(scheme), scheme);
  }
}
