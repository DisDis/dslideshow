import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:system_metrics_widget/src/widgets/metrics/cpu_info_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/disk_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/memory_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/network_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/system_info_widget.dart';

class SystemInfoMetrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      staggeredTiles: [
        StaggeredTile.fit(1),
        StaggeredTile.fit(3),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(1),
      ],
      crossAxisCount: 4,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        CpuInfoWidget(),
        SystemInfoWidget(),
        MemoryUsageWidget(),
        NetworkUsageWidget(),
        DiskUsageWidget(),
      ],
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
