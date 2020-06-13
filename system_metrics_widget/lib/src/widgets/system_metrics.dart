import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:system_metrics_widget/src/model/system_info/system_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/cpu_info_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/disk_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/memory_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/network_usage_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/os_info_widget.dart';

class SystemInfoMetrics extends StatelessWidget {
  final SystemInfo _model;

  SystemInfoMetrics({@required SystemInfo model, Key key})
      : _model = model,
        super(key: key);

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
        CpuInfoWidget(model: _model.cpuInfo),
        OSInfoWidget(model: _model.osInfo),
        MemoryUsageWidget(),
        NetworkUsageWidget(model: _model.networkInfo),
        DiskUsageWidget(),
      ],
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
