import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

/// Uses packaged fonts so the photoframe never needs a font download.
extension ClockFontStyle on ClockFont {
  TextStyle textStyle({required Color color, required double fontSize}) {
    final family = switch (this) {
      ClockFont.system => null,
      ClockFont.roboto => 'Roboto',
      ClockFont.orbitron => 'Orbitron',
      ClockFont.righteous => 'Righteous',
      ClockFont.fredoka => 'FredokaOne',
    };
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: family,
      fontFamilyFallback: switch (this) {
        ClockFont.system || ClockFont.roboto => null,
        _ => const ['Roboto'],
      },
      package: family == null ? null : 'system_metrics_widget',
    );
  }
}
