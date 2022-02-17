import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class UptimeInfoWidget extends StatefulWidget {
  final String? uptime;

  UptimeInfoWidget({required String? model, Key? key})
      : uptime = model,
        super(key: key);

  @override
  _UptimeInfoWidgetState createState() => _UptimeInfoWidgetState();
}

class _UptimeInfoWidgetState extends State<UptimeInfoWidget> {
  DateFormat _timeFormatter = DateFormat('Hms');

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: FlutterIcons.clock_fast_mco,
      backgroundColor: Colors.teal,
      child: Container(
        color: Colors.teal,
        child: Column(children: <Widget>[
          Row(children: [
            MetricsDetails('${widget.uptime}last updated ${_timeFormatter.format(DateTime.now())}', value: null)
          ]),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
