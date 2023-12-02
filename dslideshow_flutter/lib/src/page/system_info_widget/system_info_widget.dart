import 'dart:async';

import 'package:dslideshow_backend/system_info.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/system_metrics_widget.dart';

@immutable
class SystemInfoWidget extends StatefulWidget {
  const SystemInfoWidget({super.key});

  @override
  SystemInfoWidgetState createState() => SystemInfoWidgetState();
}

class SystemInfoWidgetState extends State<SystemInfoWidget> {
  final FrontendService _frontendService = injector.get<FrontendService>();
  SystemInfo? _systemInfo;

  StreamSubscription<SystemInfo>? _streamSubscription;
  @override
  Widget build(BuildContext context) {
    if (_systemInfo == null) {
      return Container(color: Colors.transparent);
    }

    // if (_systemInfo!.cpuInfo.cores == 0) {
    //   const cores = 4;
    //   _systemInfo = _systemInfo!.rebuild((builder) {
    //     builder.cpuInfo.cores = cores;
    //     builder.updateInfo.cpuLoad1 = math.Random().nextDouble() * cores;
    //     builder.updateInfo.cpuLoad5 = math.Random().nextDouble() * cores;
    //     builder.updateInfo.cpuLoad15 = math.Random().nextDouble() * cores;
    //   });
    // }

    return SystemInfoMetrics(model: _systemInfo!);
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

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
}
