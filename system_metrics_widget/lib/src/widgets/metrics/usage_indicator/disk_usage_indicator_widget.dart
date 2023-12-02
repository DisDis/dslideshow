import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/usage_indicator_widget.dart';

class DiskUsageIndicatorWidget extends UsageIndicatorWidget {
  final int totalMemory;
  final int usedMemory;

  DiskUsageIndicatorWidget({
    super.key,
    required this.totalMemory,
    required this.usedMemory,
    required super.usagePercent,
  }) : super(
          title: 'Disk',
          total: _formatter(totalMemory),
          free: _formatter((totalMemory - usedMemory)),
          used: _formatter(usedMemory),
        );

  static String _formatter(int memory) => UsageIndicatorWidget.formatKBytes(memory, 2);
}
