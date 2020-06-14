import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class MemoryUsageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: MetricsDetails('memory'),
      ),
    );
  }
}
