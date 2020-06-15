import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/model/system_info/cpu_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class CpuInfoWidget extends StatelessWidget {
  CpuInfoWidget({@required CpuInfo model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 0,
          child: Icon(
            FlutterIcons.cpu_fea,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
            color: Colors.orangeAccent,
            child: Column(children: <Widget>[
              Row(children: [MetricsDetails(' cpu:')]),
            ]),
          ),
        ),
      ],
    );
  }
}
