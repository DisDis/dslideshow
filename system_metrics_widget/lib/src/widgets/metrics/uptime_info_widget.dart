import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class UptimeInfoWidget extends StatelessWidget {
  static final _timeFormatter = DateFormat('Hms');
  final String uptime;
  const UptimeInfoWidget({
    super.key,
    required this.uptime,
  });

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: CommunityMaterialIcons.clock_fast,
      backgroundColor: Colors.teal,
      child: Container(
        color: Colors.teal,
        child: Column(children: <Widget>[
          Row(children: [MetricsDetails('${uptime}last updated ${_timeFormatter.format(DateTime.now())}', value: null)]),
        ]),
      ),
    );
  }
}
