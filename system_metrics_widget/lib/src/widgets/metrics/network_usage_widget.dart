import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/model/system_info/network_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class NetworkUsageWidget extends StatelessWidget {
  final NetworkInfo _model;
  NetworkUsageWidget({@required NetworkInfo model, Key key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [MetricsDetails('network: ${_model.lastUpdate}')]),
          if (_model.hasInternet)
            Icon(
              Icons.cast_connected,
              color: Colors.white,
              size: 24.0,
            )
          else
            Icon(
              Icons.cast,
              color: Colors.white,
              size: 24.0,
            ),
          for (final interface in _model.interfaces)
            Row(children: [MetricsDetails('${interface.name} - ${interface.status}')]),
        ],
      ),
    );
  }
}
