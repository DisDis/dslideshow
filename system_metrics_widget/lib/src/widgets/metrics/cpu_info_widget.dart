import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/model/system_info/cpu_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class CpuInfoWidget extends StatelessWidget {
  final CpuInfo model;
  CpuInfoWidget({@required this.model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: FlutterIcons.cpu_fea,
      backgroundColor: Colors.orangeAccent,
      child: Column(children: <Widget>[
        Row(children: [MetricsDetails('cpu')]),
        Row(children: [MetricsDetails('model', value: model.model)]),
        Row(children: [MetricsDetails('hardware', value: model.hardware)]),
        Row(children: [MetricsDetails('revision', value: model.revision)]),
        Row(children: [MetricsDetails('cores', value: model.cores)]),
      ]),
    );
  }
}
