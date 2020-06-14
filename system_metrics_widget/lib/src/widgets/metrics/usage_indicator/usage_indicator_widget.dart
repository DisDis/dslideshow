import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/usage_bar.dart';

abstract class UsageIndicatorWidget extends StatelessWidget {
  final String title;
  final String total;
  final String free;
  final String used;
  final int usagePercent;

  UsageIndicatorWidget({
    @required this.title,
    @required this.total,
    @required this.free,
    @required this.used,
    @required this.usagePercent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$title: $total, used: $used, free: $free, usage $usagePercent %',
          style: Settings.metricsDetailsTextStyle,
        ),
        UsageBar(
          usagePercent: usagePercent,
        ),
      ],
    );
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }
}
