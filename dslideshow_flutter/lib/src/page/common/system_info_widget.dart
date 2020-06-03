import 'dart:async';

import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';

class SystemInfoWidget extends StatefulWidget {
  SystemInfoWidget({Key key}) : super(key: key);

  @override
  _SystemInfoWidgetState createState() => _SystemInfoWidgetState();
}

class _SystemInfoWidgetState extends State<SystemInfoWidget> {
  final FrontendService _frontendService = injector.get(FrontendService) as FrontendService;
  SystemInfo _systemInfo;
  final TextStyle _style = TextStyle(
      color: Colors.black,
      fontSize: 10.0 );

  StreamSubscription<SystemInfo> _streamSubscription;
  @override
  void initState() {
    _streamSubscription = _frontendService.onSystemInfoUpdate.listen((event) {
      setState(() {
        _systemInfo = event;
      });
    });
    _frontendService.getSystemInfo().then((value) {
      setState(() {
        _systemInfo = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_streamSubscription!=null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_systemInfo == null){
      return new Container(
          color: Color.fromARGB(150, 133, 133, 133),
      );
    }

    List<Widget> sensors = <Widget>[];
    _systemInfo.updateInfo.sensors.forEach((item) {
      sensors.add(Text(
        '${item.name}: ${item.value}',
        style: _style,
      ));
    });

    return new Container(
      color: Color.fromARGB(150, 133, 133, 133),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '-----=== Hardware ===-----',
            style: _style,
          ),
          Text(
            'CPU: ${_systemInfo.cpuInfo.model}(${_systemInfo.cpuInfo.hardware} rev ${_systemInfo.cpuInfo.revision})',
            style: _style,
          ),
          Text(
            'Core(s): ${_systemInfo.cpuInfo.cores}',
            style: _style,
          ),
          Text(
            'Mem: ${_systemInfo.updateInfo.memTotal}/${_systemInfo.updateInfo.memUsed}(${(_systemInfo.updateInfo.memUsed*100/_systemInfo.updateInfo.memTotal).truncate()}%)  ${_systemInfo.updateInfo.swapTotal}/${_systemInfo.updateInfo.swapUsed}(${(_systemInfo.updateInfo.swapUsed*100/_systemInfo.updateInfo.swapTotal).truncate()}%)',
            style: _style,
          ),
          Text(
            'Disk used: ${_systemInfo.updateInfo.diskUsed}(${_systemInfo.updateInfo.diskUsedPercent}), free: ${_systemInfo.updateInfo.diskAvail}',
            style: _style,
          ),
          Text(
            '-----=== System ===-----',
            style: _style,
          ),
          Text(
            'kernel: ${_systemInfo.osInfo.name}',
            style: _style,
          ),
          Text(
            'uptime: ${_systemInfo.updateInfo.uptime}',
            style: _style,
          ),
          Text(
            // Load average 1min, 5min, 15min
            'cpu load: ${_systemInfo.updateInfo.cpuLoad1} ${_systemInfo.updateInfo.cpuLoad5} ${_systemInfo.updateInfo.cpuLoad15}',
            style: _style,
          ),
          Text(
            '-----=== Sensors ===-----',
            style: _style,
          ),

        ]..addAll(sensors),
      )

    )
    );
  }
}