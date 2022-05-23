import 'dart:math';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_bloc.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_event.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  static final Logger _log = Logger('_ConfigPageState');
  static final String _urlData = "http://localhost:8181/test";
  static final rnd = Random();
  final AppConfig _appConfig = injector.get<AppConfig>();
  final FrontendService _frontendService = injector.get<FrontendService>();
  static const INIT_CODE = r'_$_$_';
  bool _enabled = false;
  String _accessCode = INIT_CODE;

  @override
  void initState() {
    super.initState();
    _log.info('initState');
    _frontendService.startWebServer().then((value) {
      _accessCode = value;
      _enabled = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _frontendService.stopWebServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const CommonHeaderWidget(),
          QrImage(
            backgroundColor: Colors.white,
            data: _urlData,
            size: 300.0,
          ),
          Text(_urlData),
          ElevatedButton(
            onPressed: () {
              final bloc = context.read<SlideshowBloc>();
              bloc.add(SlideshowChangeStorageStatusEvent(
                  StorageStatusEnum.values.elementAt(rnd.nextInt(StorageStatusEnum.values.length))));
            },
            child: const Text('StorageChange'),
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
        ],
      ),
    );
  }
}
