import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/MetricsDetailsWidget.dart';

class DiskUsageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: MetricsDetails('disk'),
      ),
    );
  }
}
