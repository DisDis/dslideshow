import 'dart:async';
import 'dart:math';

import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  static final Logger _log = Logger('_ConfigPageState');
  bool isReady = false;
  String _urlData = '';
  final AppConfig _appConfig = injector.get<AppConfig>();
  final FrontendService _frontendService = injector.get<FrontendService>();
  // ignore: constant_identifier_names
  static const INIT_CODE = r'_$_$_';

  String _accessCode = INIT_CODE;
  StreamSubscription? _onPushSubscription;
  SystemInfo? _systemInfo;

  void createUrl() async {
    if (_systemInfo == null || _accessCode == INIT_CODE) {
      return;
    }
    try {
      final interface = _systemInfo!.networkInfo.interfaces!.firstWhere(
        (item) =>
            item.status == NetworkInterfaceStatus.running &&
            item.ip4.isNotEmpty &&
            !item.ip4.startsWith('127.'),
      );
      _urlData = 'http://${interface.ip4}:${_appConfig.webServer.port}';
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        isReady = true;
      });
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _log.info('initState');
    _frontendService.startWebServer().then((value) {
      _accessCode = value;
      createUrl();
    });

    _frontendService.getSystemInfo().then((value) {
      _systemInfo = value;
      createUrl();
    });
    _onPushSubscription = _frontendService.onButtonEvent.listen(_pushButton);
  }

  @override
  void dispose() {
    _frontendService.stopWebServer();
    _onPushSubscription?.cancel();
    _onPushSubscription = null;
    super.dispose();
  }

  void _pushButton(ButtonEvent event) {
    if (event.event == ButtonEventType.released &&
        event.button == ButtonType.button0) {
      context.read<RouteBloc>().add(ChangePageEvent(RoutePage.slideshow));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: isReady
                ? Column(
                    children: <Widget>[
                      const CommonHeaderWidget(),
                      QrImageView(
                        backgroundColor: Colors.white,
                        data: _urlData,
                        size: 300.0,
                      ),
                      Text(_urlData),
                      Text("Code: $_accessCode"),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
          if (!isLinuxEmbedded)
            BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
              builder: (context, state) {
                return DebugWidget(_frontendService, _appConfig);
              },
            ),
        ],
      ),
    );
  }
}
