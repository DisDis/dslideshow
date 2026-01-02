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
  final FrontendService _frontendService = injector();
  SystemInfo? _systemInfo;

  StreamSubscription<SystemInfo>? _streamSubscription;
  @override
  Widget build(BuildContext context) {
    if (_systemInfo == null) {
      return Container(color: Colors.transparent);
    }
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
