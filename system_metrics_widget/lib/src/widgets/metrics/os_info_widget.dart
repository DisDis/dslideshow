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
    final icon = switch (model.osType) {
      OSType.linux => const FaIcon(FontAwesomeIcons.linux),
      OSType.ios || OSType.macos => const FaIcon(FontAwesomeIcons.apple),
      OSType.windows => const FaIcon(FontAwesomeIcons.windows),
      OSType.android => const Icon(Ionicons.logoAndroid),
      _ => const Icon(Icons.device_unknown),
    };
    return MetricsContainerWidget(
      icon: icon,
      iconColor: Colors.deepPurpleAccent,
      child: Column(
        children: <Widget>[
          MetricsDetails('Os info', value: model.name),
          IconTheme(
            data: const IconThemeData(color: Colors.white, size: 50.0),
            child: icon,
          ),
        ],
      ),
    );
  }
}
