import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_metrics_widget/src/environment/android.dart';
import 'package:system_metrics_widget/src/model/system_info/os_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class OSInfoWidget extends StatelessWidget {
  final OSInfo _model;

  OSInfoWidget({@required OSInfo model, Key key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Column(children: <Widget>[
        MetricsDetails('os info: ${_model.name}, ${_model.osType}'),
        Image(
          image: AssetImage(isLinuxEmbedded ? 'assets/images/linux.png' : 'assets/images/android.png'),
          width: 50,
          height: 50,
          fit: BoxFit.scaleDown,
        )
      ]),
    );
  }
}
