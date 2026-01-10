import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_metrics_widget/src/theme/theme_colors.dart';
import 'package:system_metrics_widget/src/theme/theme_settings.dart';

class Settings {
  static TextStyle metricsDetailsTextStyle = GoogleFonts.roboto(
    fontSize: ThemeSettings.systemMetricsLargeFontSize,
    color: ThemeColors.systemMetricsTextColor,
  );

  static TextStyle loadAverageDetailsTextStyle = GoogleFonts.roboto(
    fontSize: ThemeSettings.systemMetricsMainFontSize,
    color: ThemeColors.systemMetricsTextColor,
  );

  static TextStyle loadAverageTitleTextStyle = GoogleFonts.roboto(
    fontSize: ThemeSettings.systemMetricsMediumFontSize,
    color: ThemeColors.systemMetricsTextColor,
  );

  static TextStyle metricsClockTextDigitalStyle = GoogleFonts.righteous(
    fontSize: ThemeSettings.systemMetricsClockTimeFontSize,
    color: ThemeColors.systemMetricsTextColor,
  );

  static TextStyle metricsClockDateTextDigitalStyle = GoogleFonts.righteous(
    fontSize: ThemeSettings.systemMetricsClockDateFontSize,
    color: ThemeColors.systemMetricsTextColor,
  );
  
  // TextStyles для cpu_info_widget.dart
  static TextStyle cpuModelTextStyle = const TextStyle(
    fontSize: ThemeSettings.systemMetricsMainFontSize,
    fontWeight: FontWeight.bold,
    color: ThemeColors.systemMetricsTextColor,
    letterSpacing: 0.5,
  );
  
  static TextStyle cpuCoresBadgeTextStyle = const TextStyle(
    fontSize: ThemeSettings.systemMetricsCpuCoresBadgeFontSize,
    color: ThemeColors.systemMetricsSubTextColor,
  );
  
  static TextStyle cpuLoadAverageLabelTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsDisabledTextColor,
    fontSize: ThemeSettings.systemMetricsCpuLoadLabelFontSize,
  );
  
  // TextStyles для network_usage_widget.dart
  static TextStyle networkNoConnectionTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsErrorColor,
    fontSize: ThemeSettings.systemMetricsSmallFontSize,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle networkInterfaceNameTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsHintTextColor,
    fontSize: ThemeSettings.systemMetricsTinyFontSize,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );
  
  static TextStyle networkIpAddressTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsNetworkIpAddressColor,
    fontSize: ThemeSettings.systemMetricsMediumFontSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Courier',
    letterSpacing: 0.5,
  );
  
  // TextStyles для sensors_info_widget.dart
  static TextStyle sensorNameTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsDisabledTextColor,
    fontSize: ThemeSettings.systemMetricsSensorNameFontSize,
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle sensorValueTextStyle(Color valueColor) => TextStyle(
    color: valueColor,
    fontSize: ThemeSettings.systemMetricsSensorValueFontSize,
    fontFamily: 'Courier',
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle sensorUnitTextStyle(Color valueColor) => TextStyle(
    color: valueColor.withAlpha((255.0 * 0.5).round()),
    fontSize: ThemeSettings.systemMetricsSensorUnitFontSize,
  );
  
  static TextStyle sensorBinaryStatusTextStyle(Color color) => TextStyle(
    color: color,
    fontSize: ThemeSettings.systemMetricsSensorNameFontSize,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle sensorAlertTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsSensorAlertColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
    fontSize: ThemeSettings.systemMetricsSensorAlertFontSize,
  );
  
  static TextStyle sensorGenericValueTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsSensorValueColor,
    fontSize: ThemeSettings.systemMetricsMainFontSize,
    fontFamily: 'Courier',
  );
  
  // TextStyles для usage_indicator_widget.dart
  static TextStyle usageIndicatorTitleTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsSubTextColor,
    fontSize: ThemeSettings.systemMetricsUsageIndicatorTitleFontSize,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );
  
  static TextStyle usageIndicatorPercentTextStyle(Color color) => TextStyle(
    color: color,
    fontSize: ThemeSettings.systemMetricsUsageIndicatorPercentFontSize,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle usageIndicatorDetailsTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsDisabledTextColor,
    fontSize: ThemeSettings.systemMetricsUsageIndicatorDetailsFontSize,
  );
  
  // TextStyles для circular_indicator_widget.dart
  static TextStyle circularIndicatorValueTextStyle(Color color) => TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: ThemeSettings.systemMetricsCircularIndicatorValueFontSize,
  );
  
  static TextStyle circularIndicatorTitleTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsHintTextColor,
    fontSize: ThemeSettings.systemMetricsCircularIndicatorTitleFontSize,
  );
  
  // TextStyles для metrics_container_widget.dart
  static TextStyle metricsContainerDefaultTextStyle = const TextStyle(
    color: ThemeColors.systemMetricsTextColor,
    fontSize: ThemeSettings.systemMetricsMainFontSize,
    decoration: TextDecoration.none,
  );
}
