import 'package:flutter/cupertino.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';

class MetricsDetails extends StatelessWidget {
  final String details;

  MetricsDetails(this.details);

  @override
  Widget build(BuildContext context) {
    return Text(
      details,
      style: Settings.metricsDetailsTextStyle,
    );
  }
}
