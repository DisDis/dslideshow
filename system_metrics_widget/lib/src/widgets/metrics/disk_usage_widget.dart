import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/disk_usage_indicator_widget.dart';

class DiskUsageWidget extends StatelessWidget {
  final int totalMemory;
  final int usedMemory;
  final int usagePercent;

  DiskUsageWidget({@required this.totalMemory, @required this.usedMemory, @required this.usagePercent});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: DiskUsageIndicatorWidget(
          totalMemory: totalMemory,
          usedMemory: usedMemory,
          usagePercent: usagePercent,
        ),
      ),
    );
  }
}
