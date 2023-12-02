import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:system_metrics_widget/src/environment/android.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class OSInfoWidget extends StatelessWidget {
  final OSInfo model;
  static const iconData = isLinuxEmbedded ? FontAwesomeIcons.linux : Ionicons.logo_android;

  const OSInfoWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: iconData,
      backgroundColor: Colors.deepPurpleAccent,
      child: Column(children: <Widget>[
        model.osType == OSType.unknown ? MetricsDetails('Os info', value: model.name) : MetricsDetails('Os info', value: '${model.name} (${model.osType})'),
        const Icon(
          iconData,
          color: Colors.white,
          size: 50.0,
        ),
      ]),
    );
  }
}
