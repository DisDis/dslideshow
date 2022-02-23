import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/usage_indicator_widget.dart';

class DiskUsageIndicatorWidget extends UsageIndicatorWidget {
  final int totalMemory;
  final int usedMemory;

  DiskUsageIndicatorWidget({Key? key, required this.totalMemory, required this.usedMemory, int? usagePercent})
      : super(
          key: key,
          title: 'Disk',
          total: _formatter(totalMemory),
          free: _formatter((totalMemory - usedMemory)),
          used: _formatter(usedMemory),
          usagePercent: usagePercent,
        );

  static String _formatter(int memory) => UsageIndicatorWidget.formatKBytes(memory, 2);
}
