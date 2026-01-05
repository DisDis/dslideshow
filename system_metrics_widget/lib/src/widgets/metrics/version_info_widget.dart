import 'package:community_material_icon/community_material_icon.dart';
import 'package:dslideshow_common/version.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class VersionInfoWidget extends StatelessWidget {
  const VersionInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: Icons.developer_board,
      iconColor: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              MetricsDetails('Version', value: ApplicationInfo.frontendVersion),
            ],
          ),
        ],
      ),
    );
  }
}
