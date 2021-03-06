import 'package:flutter/cupertino.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';

class MetricsDetails extends StatelessWidget {
  final String title;
  final dynamic? value;
  final TextStyle? style;

  MetricsDetails(this.title, {required this.value, this.style});

  @override
  Widget build(BuildContext context) => Text(
        '$title${(value != null ? ': $value' : '')}',
        style: style ?? Settings.metricsDetailsTextStyle,
      );
}
