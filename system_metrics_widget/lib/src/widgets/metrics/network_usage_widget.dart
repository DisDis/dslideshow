import 'package:community_material_icon/community_material_icon.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class NetworkUsageWidget extends StatelessWidget {
  final NetworkInfo? _model;
  const NetworkUsageWidget({required NetworkInfo? model, Key? key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: _model!.hasInternet ? CommunityMaterialIcons.lan_connect : CommunityMaterialIcons.lan_disconnect,
      backgroundColor: Colors.lightBlueAccent,
      iconColor: _model!.hasInternet ? Colors.white : Colors.red,
      child: Column(children: <Widget>[
        Row(children: [MetricsDetails(' network: ${DateTime.fromMillisecondsSinceEpoch(_model!.lastUpdate)}', value: null)]),
        for (final interface in _model!.interfaces!)
          if (interface.status == NetworkInterfaceStatus.running && interface.name != 'lo')
            Row(children: [MetricsDetails(interface.name, value: interface.ip4)]),
      ]),
    );
  }
}
