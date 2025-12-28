import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
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
  static const String _urlData = "http://localhost:8181/test";
  static final rnd = Random();
  final AppConfig _appConfig = injector.get<AppConfig>();
  final FrontendService _frontendService = injector.get<FrontendService>();
  // ignore: constant_identifier_names
  static const INIT_CODE = r'_$_$_';
  // ignore: unused_field
  bool _enabled = false;
  // ignore: unused_field
  String _accessCode = INIT_CODE;
  StreamSubscription? _onPushSubscription;

  @override
  void initState() {
    super.initState();
    _log.info('initState');
    _frontendService.startWebServer().then((value) {
      _accessCode = value;
      _enabled = true;
      setState(() {});
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
    if (event.event == ButtonEventType.released && event.button == ButtonType.button0) {
      context.read<RouteBloc>().add(ChangePageEvent(RoutePage.slideshow));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const CommonHeaderWidget(),
            ButtonsHintWidget(buttons: _appConfig.slideshow.buttons),
            QrImageView(
              backgroundColor: Colors.white,
              data: _urlData,
              size: 300.0,
            ),
            const Text(_urlData),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final SlideshowStatusBloc bloc = injector();
                    bloc.add(SlideshowChangeStorageStatusEvent(StorageStatusEnum.values.elementAt(rnd.nextInt(StorageStatusEnum.values.length))));
                  },
                  child: const Text('StorageChange'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final SlideshowStatusBloc bloc = injector();
                    bloc.add(SlideshowStatusEvent.changeInternetConnection(rnd.nextBool()));
                  },
                  child: const Text('Internet'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final SlideshowStatusBloc bloc = injector();
                    bloc.add(SlideshowStatusEvent.pause(rnd.nextBool()));
                  },
                  child: const Text('Pause'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RouteBloc>().add(ChangePageEvent(RoutePage.slideshow));
              },
              child: const Text('SlideShow'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RouteBloc>().add(ChangePageEvent(RoutePage.ota));
              },
              child: const Text('OTA'),
            ),
            ElevatedButton(
              onPressed: () {
                _appConfig.toFile();
              },
              child: const Text('Save config'),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _frontendService.emulatePushButton(ButtonType.button0),
                  child: Text("B0"),
                ),
                ElevatedButton(
                  onPressed: () => _frontendService.emulatePushButton(ButtonType.button1),
                  child: Text("B1"),
                ),
                ElevatedButton(
                  onPressed: () => _frontendService.emulatePushButton(ButtonType.button2),
                  child: Text("B2"),
                ),
                ElevatedButton(
                  onPressed: () => _frontendService.emulatePushButton(ButtonType.button3),
                  child: Text("B3"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
