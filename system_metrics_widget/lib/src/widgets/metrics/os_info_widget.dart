import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/model/system_info/os_info.dart';

class OSInfoWidget extends StatelessWidget {
  final OSInfo _model;

  OSInfoWidget({@required OSInfo model, Key key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Text('os info: ${_model.name}, ${_model.osType}'),
      ),
    );
  }
}
