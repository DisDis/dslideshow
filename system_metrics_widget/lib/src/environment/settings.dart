import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings {
  static TextStyle metricsDetailsTextStyle = GoogleFonts.roboto(
    fontSize: 16,
    color: Colors.white,
  );

  static TextStyle loadAverageDetailsTextStyle = GoogleFonts.roboto(
    fontSize: 12,
    color: Colors.white,
  );

  static TextStyle loadAverageTitleTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.white,
  );

  static TextStyle metricsClockTextDigitalStyle = GoogleFonts.righteous(
    fontSize: 80,
    color: Colors.white,
  );

  static TextStyle metricsClockDateTextDigitalStyle = GoogleFonts.righteous(
    fontSize: 36,
    color: Colors.white,
  );
  
  // TextStyles для cpu_info_widget.dart
  static TextStyle cpuModelTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  
  static TextStyle cpuCoresBadgeTextStyle = const TextStyle(
    fontSize: 9,
    color: Colors.white70,
  );
  
  static TextStyle cpuLoadAverageLabelTextStyle = const TextStyle(
    color: Colors.white54,
    fontSize: 9,
  );
  
  // TextStyles для network_usage_widget.dart
  static TextStyle networkNoConnectionTextStyle = const TextStyle(
    color: Colors.redAccent,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle networkInterfaceNameTextStyle = const TextStyle(
    color: Colors.white38,
    fontSize: 8,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );
  
  static TextStyle networkIpAddressTextStyle = const TextStyle(
    color: Colors.cyanAccent,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Courier',
    letterSpacing: 0.5,
  );
  
  // TextStyles для sensors_info_widget.dart
  static TextStyle sensorNameTextStyle = const TextStyle(
    color: Colors.white54,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle sensorValueTextStyle(Color valueColor) => TextStyle(
    color: valueColor,
    fontSize: 16,
    fontFamily: 'Courier',
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle sensorUnitTextStyle(Color valueColor) => TextStyle(
    color: valueColor.withAlpha((255.0 * 0.5).round()),
    fontSize: 10,
  );
  
  static TextStyle sensorBinaryStatusTextStyle(Color color) => TextStyle(
    color: color,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle sensorAlertTextStyle = const TextStyle(
    color: Colors.deepOrangeAccent,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
    fontSize: 12,
  );
  
  static TextStyle sensorGenericValueTextStyle = const TextStyle(
    color: Colors.cyanAccent,
    fontSize: 12,
    fontFamily: 'Courier',
  );
  
  // TextStyles для usage_indicator_widget.dart
  static TextStyle usageIndicatorTitleTextStyle = const TextStyle(
    color: Colors.white70,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );
  
  static TextStyle usageIndicatorPercentTextStyle(Color color) => TextStyle(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle usageIndicatorDetailsTextStyle = const TextStyle(
    color: Colors.white54,
    fontSize: 10,
  );
  
  // TextStyles для circular_indicator_widget.dart
  static TextStyle circularIndicatorValueTextStyle(Color color) => TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  
  static TextStyle circularIndicatorTitleTextStyle = const TextStyle(
    color: Colors.white38,
    fontSize: 8,
  );
  
  // TextStyles для metrics_container_widget.dart
  static TextStyle metricsContainerDefaultTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    decoration: TextDecoration.none,
  );
}
