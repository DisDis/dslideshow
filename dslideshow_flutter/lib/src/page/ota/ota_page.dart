import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'dart:io' as io;

import 'package:xterm/flutter.dart';
import 'package:xterm/terminal/terminal.dart';
import 'package:xterm/terminal/terminal_backend.dart';
import 'package:xterm/theme/terminal_style.dart';

class OTAPage extends StatefulWidget {
  OTAPage({Key? key}) : super(key: key);

  @override
  State<OTAPage> createState() => _OTAPageState();
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
  void init() async {
    // _process = await io.Process.start(command, [],
    //     environment: {'LC_ALL': 'C', 'TERM': 'xterm-256color'},
    //     runInShell: true);
    // _process.exitCode.then((value) => _exitCodeCompleter.complete(value));
    // _process.stdout.transform(utf8.decoder).listen(onWrite);
    // _process.stderr.transform(utf8.decoder).listen(onWrite);
  }

  @override
  Stream<String> get out => _outStream.stream;

  @override
  void resize(int width, int height, int pixelWidth, int pixelHeight) {}

  @override
  void terminate() {
    // _process.kill();
  }

  @override
  void write(String input) {}

  @override
  void ackProcessed() {
    // TODO: implement ackProcessed
  }
}

class _OTAPageState extends State<OTAPage> {
  static final Logger _log = Logger('_OTAPageState');
  late Terminal terminal;
  late ProcessTerminalBackend backend;
  final FrontendService _frontendService = injector.get<FrontendService>();
  final List<StreamSubscription> _subs = <StreamSubscription>[];

  OTAInfo _info = OTAInfo((b) {
    b.uploadingPercent = 0;
    b.status = OTAStatus.disabled;
    b.code = '-';
    b.errorText = '';
    b.exitCode = 0;
  });
  @override
  void initState() {
    super.initState();

    backend = ProcessTerminalBackend();
    terminal = Terminal(backend: backend, maxLines: 10000);
    _frontendService.getOTAInfo().then((value) => setState(() {
          _info = value;
        }));
    _subs.add(_frontendService.onOTAInfo.listen((event) {
      setState(() {
        _info = event;
      });
    }));
    _subs.add(_frontendService.onOTAOutput.listen((event) {
      backend.onWrite(event);
    }));
  }

  @override
  void dispose() {
    _subs.forEach((element) {
      element.cancel();
    });
    _subs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            children: [
              Text(
                "OTA - ${_info.status}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Code: ${_info.code}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: _info.uploadingPercent / 100,
                  semanticsLabel: 'OTA progress',
                  minHeight: 15,
                ),
              ),
              ElevatedButton(
                onPressed: _runTestCommand,
                child: Text('TEST'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/config');
                },
                child: Text('Config'),
              ),
              Container(
                  height: 300,
                  //width: 300,
                  child: //SingleChildScrollView(

                      // for Vertical scrolling
                      //scrollDirection: Axis.vertical,
                      //child:
                      //SafeArea(
                      //child:
                      TerminalView(
                    terminal: terminal,
                    // style: TerminalStyle(fontFamily: ['Cascadia Mono']),
                    //)
                  )),
            ],
          ),
        ));
  }

  void _runTestCommand() async {
    _log.info('Test run');
    var result = await io.Process.start('./test_console.sh', [], environment: {
      'LC_ALL': 'C',
      'TERM': 'xterm-256color',
      'COLUMNS': '120'
    });
    result.stdout.transform(utf8.decoder).forEach((str) {
      backend.onWrite(str);
      // setState(() {});
    });
    result.stderr.transform(utf8.decoder).forEach((str) {
      backend.onWrite(str);
    });
    var exitCode = await result.exitCode;
    backend.onWrite('Exit code: $exitCode');
  }
}
