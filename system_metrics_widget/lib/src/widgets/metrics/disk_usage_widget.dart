import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/disk_usage_indicator_widget.dart';

class DiskUsageWidget extends StatelessWidget {
  final int totalMemory;
  final int usedMemory;
  final int usagePercent;

  const DiskUsageWidget({super.key, required this.totalMemory, required this.usedMemory, required this.usagePercent});

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: CommunityMaterialIcons.harddisk,
      backgroundColor: Colors.indigo,
      child: DiskUsageIndicatorWidget(
        totalMemory: totalMemory,
        usedMemory: usedMemory,
        usagePercent: usagePercent,
      ),
    );
  }
}
