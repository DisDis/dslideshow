import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class CurrentTimeWidget extends StatefulWidget {
  CurrentTimeWidget({Key? key}) : super(key: key);

  @override
  _CurrentTimeWidgetState createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  late Timer _timer;
  DateFormat _dateFormatter = DateFormat('yMMMMEEEEd');
  DateFormat _timeFormatter = DateFormat('Hms');

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return MetricsContainerWidget(
      iconData: FlutterIcons.activity_fea,
      backgroundColor: Colors.black,
      child: Container(
        color: Colors.black,
        child: Column(children: <Widget>[
          Row(children: [
            MetricsDetails('${_timeFormatter.format(now)}', value: null, style: Settings.metricsClockTextDigitalStyle)
          ]),
          Row(children: [
            MetricsDetails('${_dateFormatter.format(now)}',
                value: null, style: Settings.metricsClockTextDigitalStyle.copyWith(fontSize: 14))
          ]),
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
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {},
      ),
    );
  }
}
