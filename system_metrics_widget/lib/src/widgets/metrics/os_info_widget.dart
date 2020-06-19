import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:system_metrics_widget/src/environment/android.dart';
import 'package:system_metrics_widget/src/model/system_info/os_info.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class OSInfoWidget extends StatelessWidget {
  final OSInfo _model;

  OSInfoWidget({@required OSInfo model, Key key})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: isLinuxEmbedded ? FlutterIcons.linux_faw : FlutterIcons.logo_android_ion,
      backgroundColor: Colors.deepPurpleAccent,
      child: Column(children: <Widget>[
        MetricsDetails('os info: ${_model.name}, ${_model.osType}'),
        Icon(
          isLinuxEmbedded ? FlutterIcons.linux_faw : FlutterIcons.logo_android_ion,
          color: Colors.white,
          size: 50.0,
        ),
      ]),
    );
  }
}
