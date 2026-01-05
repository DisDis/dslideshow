import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class OSInfoWidget extends StatelessWidget {
  final OSInfo model;

  const OSInfoWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final iconData =switch (model.osType) {
  OSType.linux => FontAwesomeIcons.linux,
  OSType.ios => FontAwesomeIcons.apple,
  OSType.windows => FontAwesomeIcons.windows,
  OSType.macos => FontAwesomeIcons.apple,
  OSType.android => Ionicons.logo_android,
  _ => Icons.device_unknown, 
};
    return MetricsContainerWidget(
      iconData: iconData,
      iconColor: Colors.deepPurpleAccent,
      child: Column(
        children: <Widget>[
          MetricsDetails('Os info', value: model.name),
          Icon(iconData, color: Colors.white, size: 50.0),
        ],
      ),
    );
  }
}
