import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/model/system_info/os_info.dart';

class OSInfoWidget extends StatelessWidget {
  OSInfoWidget({@required OSInfo model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Text('os info'),
      ),
    );
  }
}
