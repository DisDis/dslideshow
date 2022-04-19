import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_bloc.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_event.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_state.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:xterm/flutter.dart';
import 'package:xterm/terminal/terminal.dart';
import 'package:xterm/terminal/terminal_backend.dart';
import 'package:xterm/theme/terminal_style.dart';

class OTAPage extends StatelessWidget {
  late Terminal terminal = Terminal(backend: backend, maxLines: 3000);
  final ProcessTerminalBackend backend = ProcessTerminalBackend();
  OTAPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => OtaBloc(frontendService: injector.get<FrontendService>(), backend: backend)
          ..add(const OtaEvent.initialization()),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: OTAView(
              terminal: terminal,
            )));
  }

  static void processingOTAReady(BuildContext context, bool isReady) {
    if (isReady) {
      context.read<RouteBloc>().add(ChangePageEvent(RoutePage.ota));
    } else {
      context.read<RouteBloc>().add(ChangePageEvent(RoutePage.welcome));
    }
  }
}

class ProcessTerminalBackend extends TerminalBackend {
  final _exitCodeCompleter = Completer<int>();
  final _outStream = StreamController<String>();

  ProcessTerminalBackend();

  @override
  Future<int> get exitCode => _exitCodeCompleter.future;

  void onWrite(String data) {
    _outStream.sink.add(data);
  }

  @override
  void init() async {}

  @override
  Stream<String> get out => _outStream.stream;

  @override
  void resize(int width, int height, int pixelWidth, int pixelHeight) {}

  @override
  void terminate() {}

  @override
  void write(String input) {}

  @override
  void ackProcessed() {}
}

class OTAView extends StatelessWidget {
  static final Logger _log = Logger('OTAView');
  final Terminal terminal;

  const OTAView({Key? key, required this.terminal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = context.watch<OtaBloc>().state;
    final header = [
      // Text(
      //   "OTA - ${state.info.status}",
      //   style: const TextStyle(color: Colors.white),
      // ),
      const Text(
        "Version: v${ApplicationInfo.frontendVersion}",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      Text(
        "Code: ${state.info.code}",
        style: const TextStyle(color: Colors.white, fontSize: 60),
      ),
    ];
    final terminalView = Expanded(
        flex: 2,
        child: TerminalView(
          terminal: terminal,
          style: const TerminalStyle(fontFamily: ['Cascadia Mono']),
        ));
    return state.when(
      exit: (info) {
        Future.microtask(() => OTAPage.processingOTAReady(context, false));
        return const CircularProgressIndicator();
      },
      initial: (info) => const CircularProgressIndicator(),
      failure: (info) => Column(children: [
        ...header,
        Text(
          "Error${state.info.errorText == null ? '' : '$state.info.errorText'}",
          style: const TextStyle(color: Colors.red, fontSize: 50),
        ),
        terminalView
      ]),
      progress: (info) => Column(children: [
        ...header,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            value: state.info.uploadingPercent / 100,
            semanticsLabel: 'OTA progress',
            minHeight: 15,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config));
          },
          child: const Text('Config'),
        ),
        terminalView
      ]),
      ready: (info) => Column(children: [
        ElevatedButton(
          onPressed: () {
            context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config));
          },
          child: const Text('Config'),
        ),
        ...header,
      ]),
      success: (info) => Column(children: [
        ...header,
        const Text(
          "Finished",
          style: TextStyle(color: Colors.green, fontSize: 50),
        ),
        terminalView
      ]),
    );
  }
}
