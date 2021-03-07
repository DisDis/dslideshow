import 'package:flutter/cupertino.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/usage_indicator_widget.dart';

class MemoryUsageIndicatorWidget extends UsageIndicatorWidget {
  final int totalMemory;
  final int usedMemory;
  final String title;

  MemoryUsageIndicatorWidget({required this.totalMemory, required this.usedMemory, this.title = 'Mem'})
      : super(
          title: title,
          total: _formatter(totalMemory),
          free: _formatter(totalMemory - usedMemory),
          used: _formatter(usedMemory),
          usagePercent: totalMemory > 0 ? ((usedMemory / totalMemory) * 100).round().floor() : 0,
        );

  static String _formatter(int memory) => UsageIndicatorWidget.formatBytes(memory, 2);
}
