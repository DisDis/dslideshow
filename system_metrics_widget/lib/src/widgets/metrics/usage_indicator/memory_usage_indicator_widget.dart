import 'package:flutter/cupertino.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/usage_indicator_widget.dart';

class MemoryUsageIndicatorWidget extends UsageIndicatorWidget {
  static String _formatter(int memory) => memory.toString();

  final int totalMemory;
  final int usedMemory;

  MemoryUsageIndicatorWidget({@required this.totalMemory, @required this.usedMemory})
      : super(
            title: 'Mem',
            total: _formatter(totalMemory),
            free: _formatter(totalMemory - usedMemory),
            used: _formatter(usedMemory));
}
