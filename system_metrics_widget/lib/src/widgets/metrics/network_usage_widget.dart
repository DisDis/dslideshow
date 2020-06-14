import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/model/system_info/network_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class NetworkUsageWidget extends StatelessWidget {
  NetworkUsageWidget({@required NetworkInfo model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: MetricsDetails('network'),
      ),
    );
  }
}
