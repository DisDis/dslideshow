import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: $total, used: $used, free: $free - $usagePercent%',
          style: Settings.metricsDetailsTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: UsageBar(
            usagePercent: usagePercent,
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
