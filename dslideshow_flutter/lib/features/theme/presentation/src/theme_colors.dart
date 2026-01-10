import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

abstract class ThemeColors {
  static const QRCodeBackground = Colors.white;
  static final QRCodeShadow = Colors.black.withAlpha((255.0 * 0.3).round());

  // Config Page Colors
  static const configBackgroundColor = Color(0xFF1E1E1E);
  static const configCardColor = Color(0xFF2C2C2C);
  static const configAccentColor = Color(0xFF64B5F6);
  static const configHeaderTextColor = Color(0xFFE6E6E6); // 0.9 alpha white
  static const configSubheaderTextColor = Color(0xFF808080); // 0.5 alpha white
  static const configNormalTextColor = Color(0xFFCCCCCC); // 0.8 alpha white
  static const configInputBorderColor = Color(0x4DFFFFFF); // Colors.white10
  static const configAccessCodeBgColor = Color(0x40000000); // Colors.black26
  static const configAccessCodeBorderColor = Color(
    0x4D64B5F6,
  ); // 0.3 alpha accent color

  // OTA Page Colors
  static const otaBackgroundColor = Colors.black;
  static const otaCardColor = Color(0xFF2C2C2C);
  static const otaAccentColor = Color(0xFF64B5F6);
  static const otaProgressIconColor = Color(0xFF64B5F6);
  static const otaProgressTextColor = Colors.white;
  static const otaProgressSubtextColor = otaSuccessSubtextColor;
  static const otaProgressPercentColor = Color(0xFF64B5F6);
  static const otaProgressBgColor = Color(0x40000000); // Colors.black26
  static const otaProgressBorderColor = Color(0x4D64B5F6); // 0.3 alpha accent
  static const otaErrorIconColor = Colors.redAccent;
  static const otaErrorTextColor = Colors.redAccent;
  static const otaErrorBgColor = Color(0x1AFF0000); // 0.1 alpha red
  static const otaErrorBorderColor = Color(0x4DFF0000); // 0.3 alpha red
  static const otaSuccessIconColor = Colors.greenAccent;
  static const otaSuccessTextColor = Colors.greenAccent;
  static const otaSuccessSubtextColor = Color(0xB3FFFFFF); // Colors.white70
  static const otaTerminalHeaderBgColor = Color(0xFF1E1E1E);
  static const otaTerminalHeaderTextColor = Color(0xFF666666); // Colors.white38
  static const otaTerminalHeaderIconColor = Color(0xFF666666); // Colors.white38
  static const otaTerminalBgColor = Colors.black;
  static const otaTerminalBorderColor = Color(
    0x80FF0000,
  ); // 0.5 alpha red for red dot
  static const otaTerminalBorderAmberColor = Color(
    0x80FFFF00,
  ); // 0.5 alpha amber for amber dot
  static const otaTerminalBorderGreenColor = Color(
    0x8000FF00,
  ); // 0.5 alpha green for green dot
  static const otaDevButtonColor = Color(0xFF666666); // Colors.white38
  static const otaVersionCurrentColor = Color(0xE6FF0000); // 0.9 alpha red
  static const otaReadyHeaderTextColor = Color(0xFFE6E6E6); // 0.9 alpha white
  static const otaReadySubheaderTextColor = Color(
    0xFF808080,
  ); // 0.5 alpha white
  static const otaReadyNormalTextColor = Color(0xFFCCCCCC); // 0.8 alpha white
  static const otaReadyInputBorderColor = Color(0x4DFFFFFF); // Colors.white10
  static const otaReadyAccessCodeBgColor = Color(0x40000000); // Colors.black26
  static const otaReadyAccessCodeBorderColor = Color(
    0x4D64B5F6,
  ); // 0.3 alpha accent color

  static const terminaTheme = TerminalTheme(
    cursor: Colors.transparent, // Скрываем курсор, так как readOnly
    selection: Color(0xFF264F78),
    foreground: Color(0xFFCCCCCC),
    background: Colors.black,

    // Обычные цвета (ANSI 0-7)
    black: Color(0xFF000000),
    red: Color(0xFFCD3131),
    green: Color(0xFF0DBC79),
    yellow: Color(0xFFE5E510),
    blue: Color(0xFF2472C8),
    magenta: Color(0xFFBC3FBC),
    cyan: Color(0xFF11A8CD),
    white: Color(0xFFE5E5E5),

    // Яркие цвета (ANSI 8-15)
    brightBlack: Color(0xFF666666),
    brightRed: Color(0xFFF14C4C),
    brightGreen: Color(0xFF23D18B),
    brightYellow: Color(0xFFF5F543),
    brightBlue: Color(0xFF3B8EEA),
    brightMagenta: Color(0xFFD670D6),
    brightCyan: Color(0xFF29B8DB),
    brightWhite: Color(0xFFFFFFFF),

    // Цвета поиска (обязательные поля)
    searchHitBackground: Color(0xFFF8C18C),
    searchHitBackgroundCurrent: Color(0xFF314365),
    searchHitForeground: Color(0xFF000000),
  );
}
