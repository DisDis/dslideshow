import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/theme/theme_colors.dart';
import 'package:system_metrics_widget/src/theme/theme_settings.dart';

class MetricsContainerWidget extends StatelessWidget {
  final IconData iconData;
  final Widget child;
  final Color iconColor;

  const MetricsContainerWidget({
    required this.iconData,
    required this.child,
    super.key,
    this.iconColor = ThemeColors.systemMetricsTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.systemMetricsBackgroundColor,
        borderRadius: BorderRadius.circular(8), 
        border: Border.all(
          color: ThemeColors.systemMetricsBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: <Widget>[
          // Левая часть с иконкой
          Container(
            padding: EdgeInsets.all(ThemeSettings.systemMetricsPaddingLarge),
            decoration: const BoxDecoration(
              // Легкий разделитель справа
              border: Border(
                right: BorderSide(color: ThemeColors.systemMetricsSeparatorColor),
              ),
            ),
            child: Icon(
              iconData,
              color: iconColor, 
              size: ThemeSettings.systemMetricsIconSize,
            ),
          ),
          Expanded( // Expanded теперь безопасен, так как Row знает свою ширину от Grid
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ThemeSettings.systemMetricsPaddingMedium, vertical: ThemeSettings.systemMetricsPaddingLarge / 2),
              // Принудительный стиль текста
              child: DefaultTextStyle.merge(
                style: Settings.metricsContainerDefaultTextStyle,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}