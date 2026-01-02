import 'package:community_material_icon/community_material_icon.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class NetworkUsageWidget extends StatelessWidget {
  final NetworkInfo model;
  const NetworkUsageWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: model.hasInternet ? CommunityMaterialIcons.lan_connect : CommunityMaterialIcons.lan_disconnect,
      backgroundColor: Colors.lightBlueAccent,
      iconColor: model.hasInternet ? Colors.white : Colors.red,
      child: Column(children: <Widget>[
        const Row(children: [MetricsDetails('Network:', value: null)]),
        for (final interface in model.interfaces!)
          if (interface.status == NetworkInterfaceStatus.running && interface.name != 'lo'
          && interface.name != 'lo0'
          && interface.ip4.isNotEmpty)
            Row(children: [MetricsDetails(interface.name, value: interface.ip4)]),
      ]),
    );
  }
}
