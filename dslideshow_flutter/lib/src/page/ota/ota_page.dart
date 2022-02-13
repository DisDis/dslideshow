import 'dart:async';
import 'dart:convert';

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
  double _progress = 0.45;
  late Terminal terminal;
  late ProcessTerminalBackend backend;

  @override
  void initState() {
    super.initState();
    backend = ProcessTerminalBackend();
    terminal = Terminal(backend: backend, maxLines: 10000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            children: [
              Text("OTA"),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: _progress,
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
