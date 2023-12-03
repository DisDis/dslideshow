import 'dart:math';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          QrImageView(
            backgroundColor: Colors.white,
            data: _urlData,
            size: 300.0,
          ),
          const Text(_urlData),
          ElevatedButton(
            onPressed: () {
              final SlideshowStatusBloc bloc = injector();
              bloc.add(SlideshowChangeStorageStatusEvent(StorageStatusEnum.values.elementAt(rnd.nextInt(StorageStatusEnum.values.length))));
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
