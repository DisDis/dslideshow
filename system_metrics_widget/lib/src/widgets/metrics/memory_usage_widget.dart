import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/widgets/metrics/usage_indicator/memory_usage_indicator_widget.dart';

class MemoryUsageWidget extends StatelessWidget {
  final int totalMemory;
  final int usedMemory;

  MemoryUsageWidget({@required this.totalMemory, @required this.usedMemory});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Icon(
            FlutterIcons.data_usage_mdi,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        Flexible(
          flex: 6,
          child: MemoryUsageIndicatorWidget(
            totalMemory: totalMemory,
            usedMemory: usedMemory,
          ),
        ),
      ],
    );
  }
}
