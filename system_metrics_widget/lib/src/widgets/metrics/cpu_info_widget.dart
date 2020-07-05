import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/circular_indicator/circular_indicator_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class CpuInfoWidget extends StatelessWidget {
  final CpuInfo cpu;
  final double cpuLoad1;
  final double cpuLoad15;
  final double cpuLoad5;
  final double cpuUsedSize = 50;
  final Color backgroundBarColor = Colors.purple.shade300.withAlpha(100);

  CpuInfoWidget(
      {@required this.cpu, @required this.cpuLoad1, @required this.cpuLoad5, @required this.cpuLoad15, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: FlutterIcons.cpu_fea,
      backgroundColor: Colors.purple.shade800,
      child: Column(children: <Widget>[
        Row(children: [MetricsDetails('cpu')]),
        Row(children: [MetricsDetails('model', value: cpu.model)]),
        Row(children: [MetricsDetails('hardware', value: cpu.hardware)]),
        Row(children: [MetricsDetails('revision', value: cpu.revision)]),
        Row(children: [MetricsDetails('cores', value: cpu.cores)]),
        Row(children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'LA1',
                          style: Settings.loadAverageTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: cpuUsedSize,
                        height: cpuUsedSize,
                        child: CircularIndicatorWidget(
                          percent: cpuLoad1 / cpu.cores,
                          backgroundColor: backgroundBarColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'LA5',
                          style: Settings.loadAverageTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: cpuUsedSize,
                        height: cpuUsedSize,
                        child: CircularIndicatorWidget(
                          percent: cpuLoad5 / cpu.cores,
                          backgroundColor: backgroundBarColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'LA15',
                          style: Settings.loadAverageTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: cpuUsedSize,
                        height: cpuUsedSize,
                        child: CircularIndicatorWidget(
                          percent: cpuLoad15 / cpu.cores,
                          backgroundColor: backgroundBarColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
