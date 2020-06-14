import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/memory_usage_indicator_widget.dart';

class MemoryUsageWidget extends StatelessWidget {
  final int totalMemory;
  final int usedMemory;

  MemoryUsageWidget({@required this.totalMemory, @required this.usedMemory});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: MemoryUsageIndicatorWidget(
          totalMemory: totalMemory,
          usedMemory: usedMemory,
        ),
      ),
    );
  }
}
