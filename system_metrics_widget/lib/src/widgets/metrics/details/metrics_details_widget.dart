import 'package:flutter/cupertino.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';

@immutable
class MetricsDetails<T> extends StatelessWidget {
  final String title;
  final T? value;
  final TextStyle? style;

  const MetricsDetails(
    this.title, {
    super.key,
    required this.value,
    this.style,
  });

  @override
  Widget build(BuildContext context) => Text(
        '$title${(value != null ? ': $value' : '')}',
        style: style ?? Settings.metricsDetailsTextStyle,
      );
}
