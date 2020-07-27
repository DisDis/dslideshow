import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class NetworkUsageWidget extends StatelessWidget {
  final NetworkInfo _model;
  NetworkUsageWidget({@required NetworkInfo model, Key key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: _model.hasInternet ? FlutterIcons.lan_connect_mco : FlutterIcons.lan_disconnect_mco,
      backgroundColor: Colors.lightBlueAccent,
      child: Column(children: <Widget>[
        Row(children: [MetricsDetails(' network: ${_model.lastUpdate}')]),
        for (final interface in _model.interfaces)
          Row(children: [MetricsDetails('${interface.name} - ${interface.status}')]),
      ]),
    );
  }
}
