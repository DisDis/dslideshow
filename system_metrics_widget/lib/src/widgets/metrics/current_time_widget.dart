import 'dart:async';

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class CurrentTimeWidget extends StatefulWidget {
  const CurrentTimeWidget({Key? key}) : super(key: key);

  @override
  _CurrentTimeWidgetState createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  late Timer _timer;
  final _dateFormatter = DateFormat('yMMMMEEEEd');
  final _timeFormatter = DateFormat('Hms');

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return MetricsContainerWidget(
      iconData: FeatherIcons.activity,
      backgroundColor: Colors.black,
      child: Container(
        color: Colors.black,
        child: Column(children: <Widget>[
          Row(children: [MetricsDetails(_timeFormatter.format(now), value: null, style: Settings.metricsClockTextDigitalStyle)]),
          Row(children: [MetricsDetails(_dateFormatter.format(now), value: null, style: Settings.metricsClockTextDigitalStyle.copyWith(fontSize: 14))]),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {},
      ),
    );
  }
}
