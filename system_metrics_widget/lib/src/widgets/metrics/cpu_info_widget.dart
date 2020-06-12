import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/model/system_info/cpu_info.dart';

class CpuInfoWidget extends StatelessWidget {
  CpuInfoWidget({@required CpuInfo model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Text('cpu'),
      ),
    );
  }
}
