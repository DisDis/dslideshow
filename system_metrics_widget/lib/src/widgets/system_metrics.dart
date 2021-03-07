import 'dart:math';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:system_metrics_widget/src/widgets/metrics/cpu_info_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/current_time_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/disk_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/memory_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/network_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/os_info_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/uptime_info_widget.dart';

class SystemInfoMetrics extends StatelessWidget {
  final SystemInfo _model;

  SystemInfoMetrics({required SystemInfo model, Key? key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentOrientation = MediaQuery.of(context).orientation;

    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;
    print(currentOrientation);
    print(useMobileLayout);

    return OrientationBuilder(builder: (context, orientation) {
      return StaggeredGridView.count(
        staggeredTiles: [
          StaggeredTile.fit(8),
          StaggeredTile.fit(5),
          StaggeredTile.fit(3),
          StaggeredTile.fit(5),
          StaggeredTile.fit(8),
          StaggeredTile.fit(4),
          StaggeredTile.fit(4),
        ],
        crossAxisCount: 8,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CurrentTimeWidget(),
          UptimeInfoWidget(model: _model.updateInfo!.uptime),
          CpuInfoWidget(
            cpu: _model.cpuInfo,
            cpuLoad1: _model.updateInfo!.cpuLoad1,
            cpuLoad5: _model.updateInfo!.cpuLoad5,
            cpuLoad15: _model.updateInfo!.cpuLoad15,
          ),
          OSInfoWidget(model: _model.osInfo),
          NetworkUsageWidget(model: _model.networkInfo),
          MemoryUsageWidget(
            totalMemory: _model.updateInfo!.memTotal,
            usedMemory: _model.updateInfo!.memUsed,
            totalSwapMemory: _model.updateInfo!.swapTotal,
            usedSwapMemory: _model.updateInfo!.swapUsed,
          ),
          DiskUsageWidget(
            totalMemory: _model.updateInfo!.diskUsed! + _model.updateInfo!.diskAvailable!,
            usedMemory: _model.updateInfo!.diskUsed,
            usagePercent: _model.updateInfo!.diskUsedPercent,
          ),
        ],
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 8.0,
      );
    });
  }
}
