import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/usage_bar.dart';

abstract class UsageIndicatorWidget extends StatelessWidget {
  final String title;
  final String total;
  final String free;
  final String used;
  final int usagePercent;

  const UsageIndicatorWidget({
    super.key,
    required this.title,
    required this.total,
    required this.free,
    required this.used,
    required this.usagePercent,
  });

  // Логика цветов "Светофор"
  Color _getStatusColor(int percent) {
    if (percent > 85) return Colors.redAccent;    // Критично
    if (percent > 60) return Colors.amberAccent;  // Внимание
    return Colors.cyanAccent;                     // Норма (Техно-стиль)
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(usagePercent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Верхняя строка: Заголовок и Процент
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: Settings.usageIndicatorTitleTextStyle,
            ),
            Text(
              '$usagePercent%',
              style: Settings.usageIndicatorPercentTextStyle(statusColor),
            ),
          ],
        ),
        
        const SizedBox(height: 4),

        // 2. Полоса загрузки
        SizedBox(
          height: 6, // Тонкая, аккуратная полоска
          child: UsageBar(
            usagePercent: usagePercent,
            primaryColor: statusColor,
          ),
        ),

        const SizedBox(height: 4),

        // 3. Нижняя строка: Детали (Used / Total)
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$used / $total',
            style: Settings.usageIndicatorDetailsTextStyle,
          ),
        ),
      ],
    );
  }

  static String formatKBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 B';
    double num = bytes.toDouble();
    const suffixes = ['KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    for (var unit in suffixes) {
      if (num.abs() < 1024) {
        return "${num.toStringAsFixed(decimals)} $unit";
      }
      num = num / 1024;
    }
    return "${num.toStringAsFixed(decimals)} YB";
  }
}