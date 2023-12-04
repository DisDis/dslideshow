import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class SensorsInfoWidget extends StatelessWidget {
  const SensorsInfoWidget({required this.model, super.key});
  final UpdateInfo model;

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: Icons.sensors_outlined,
      backgroundColor: Colors.blueGrey,
      iconColor: Colors.white,
      child: Column(children: <Widget>[
        const Row(children: [MetricsDetails('Sensors:', value: null)]),
        for (final sensor in model.sensors) Row(children: [MetricsDetails(sensor.name, value: sensor.value)]),
      ]),
    );
  }
}
