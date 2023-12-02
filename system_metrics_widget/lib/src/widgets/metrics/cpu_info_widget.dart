import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
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

  CpuInfoWidget({required this.cpu, required this.cpuLoad1, required this.cpuLoad5, required this.cpuLoad15, super.key});

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: FeatherIcons.cpu,
      backgroundColor: Colors.purple.shade800,
      child: Column(children: <Widget>[
        const Row(children: [MetricsDetails('cpu', value: null)]),
        Row(children: [MetricsDetails('model', value: cpu.model)]),
        Row(children: [MetricsDetails('hardware', value: cpu.hardware)]),
        Row(children: [MetricsDetails('revision', value: cpu.revision)]),
        Row(children: [MetricsDetails('cores', value: cpu.cores)]),
        Row(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.purple.shade200))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          'LA1 - ${cpuLoad1.toStringAsFixed(2)}',
                          style: Settings.loadAverageTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: cpuUsedSize,
                        height: cpuUsedSize,
                        child: CircularIndicatorWidget(
                          percent: cpu.cores > 0 ? cpuLoad1 / cpu.cores : 0,
                          backgroundColor: backgroundBarColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          'LA5 - ${cpuLoad5.toStringAsFixed(2)}',
                          style: Settings.loadAverageTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: cpuUsedSize,
                        height: cpuUsedSize,
                        child: CircularIndicatorWidget(
                          percent: cpu.cores > 0 ? cpuLoad5 / cpu.cores : 0,
                          backgroundColor: backgroundBarColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          'LA15 - ${cpuLoad15.toStringAsFixed(2)}',
                          style: Settings.loadAverageTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: cpuUsedSize,
                        height: cpuUsedSize,
                        child: CircularIndicatorWidget(
                          percent: cpu.cores > 0 ? cpuLoad15 / cpu.cores : 0,
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
