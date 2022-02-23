import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/memory_usage_indicator_widget.dart';

class MemoryUsageWidget extends StatelessWidget {
  final int? totalMemory;
  final int? usedMemory;
  final int? totalSwapMemory;
  final int? usedSwapMemory;

  const MemoryUsageWidget({
    Key? key,
    required this.totalMemory,
    required this.usedMemory,
    required this.totalSwapMemory,
    required this.usedSwapMemory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: FlutterIcons.data_usage_mdi,
      backgroundColor: Colors.indigo,
      child: Column(
        children: <Widget>[
          MemoryUsageIndicatorWidget(
            totalMemory: totalMemory!,
            usedMemory: usedMemory!,
          ),
          MemoryUsageIndicatorWidget(
            title: 'Swap',
            totalMemory: totalSwapMemory!,
            usedMemory: usedSwapMemory!,
          )
        ],
      ),
    );
  }
}
