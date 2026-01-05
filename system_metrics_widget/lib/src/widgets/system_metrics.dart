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
import 'package:system_metrics_widget/src/widgets/metrics/sensors_info_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/uptime_info_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/version_info_widget.dart';

class SystemInfoMetrics extends StatelessWidget {
  final SystemInfo _model;

  const SystemInfoMetrics({required SystemInfo model, super.key}) : _model = model;

    @override
      Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 8,
      mainAxisSpacing: 8.0,  // Компактные отступы
      crossAxisSpacing: 8.0,
      children: <Widget>[
          const StaggeredGridTile.fit(
            crossAxisCellCount: 8,
            child: CurrentTimeWidget(),
          ),
          const StaggeredGridTile.fit(
            crossAxisCellCount: 5,
            child: VersionInfoWidget(),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 5,
            child: UptimeInfoWidget(uptime: _model.updateInfo.uptime),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 3,
            child: CpuInfoWidget(
              cpu: _model.cpuInfo,
              cpuLoad1: _model.updateInfo.cpuLoad1,
              cpuLoad5: _model.updateInfo.cpuLoad5,
              cpuLoad15: _model.updateInfo.cpuLoad15,
            ),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 5,
            child: OSInfoWidget(model: _model.osInfo),
          ),
          
          StaggeredGridTile.fit(
            crossAxisCellCount: 4,
            child: MemoryUsageWidget(
              totalMemory: _model.updateInfo.memTotal,
              usedMemory: _model.updateInfo.memUsed,
              totalSwapMemory: _model.updateInfo.swapTotal,
              usedSwapMemory: _model.updateInfo.swapUsed,
            ),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 4,
            child: DiskUsageWidget(
              totalMemory: _model.updateInfo.diskUsed + _model.updateInfo.diskAvailable,
              usedMemory: _model.updateInfo.diskUsed,
              usagePercent: _model.updateInfo.diskUsedPercent,
            ),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 8,
            child: NetworkUsageWidget(model: _model.networkInfo),
          ),
          if (_model.updateInfo.sensors.isNotEmpty)
            StaggeredGridTile.fit(
              crossAxisCellCount: 4,
              child: SensorsInfoWidget(
                model: _model.updateInfo,
              ),
            ),
        ],
      );
  }
}
