import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class UptimeInfoWidget extends StatefulWidget {
  final String uptime;

  UptimeInfoWidget({@required String model, Key key})
      : uptime = model,
        super(key: key);

  @override
  _UptimeInfoWidgetState createState() => _UptimeInfoWidgetState();
}

class _UptimeInfoWidgetState extends State<UptimeInfoWidget> {
  Timer _timer;
  DateFormat _dateFormatter = DateFormat('yMMMMEEEEd');
  DateFormat _timeFormatter = DateFormat('Hms');

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return MetricsContainerWidget(
      iconData: FlutterIcons.activity_fea,
      backgroundColor: Colors.teal,
      child: Container(
        color: Colors.teal,
        child: Column(children: <Widget>[
          Row(children: [MetricsDetails('${_dateFormatter.format(now)}')]),
          Row(children: [MetricsDetails('${_timeFormatter.format(now)}')]),
          Row(children: [MetricsDetails('${widget.uptime}')]),
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
