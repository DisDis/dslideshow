import 'package:dslideshow_backend/config.dart';
import 'package:flutter/widgets.dart';

/// System mode delegates locale resolution to MaterialApp and its supported
/// locales; unsupported system languages fall back to English.
extension FrameLanguageLocale on FrameLanguage {
  Locale? get locale => switch (this) {
    FrameLanguage.system => null,
    FrameLanguage.en => const Locale('en'),
    FrameLanguage.ru => const Locale('ru'),
  };
}
