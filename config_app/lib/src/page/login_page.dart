import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static final Logger _log = Logger('_LoginPageState');
  final codeTextController = TextEditingController(text: '123');
  final urlTextController = TextEditingController(
    text: 'ws://${Uri.base.host}:8080/ws',
  );

  final _client = ClientService();
  final List<StreamSubscription> _subs = <StreamSubscription>[];

  @override
  void initState() {
    _subs.add(_client.onCommand.listen(_parseCommand));
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _client.disconnect();
    urlTextController.dispose();
    codeTextController.dispose();
    for (var element in _subs) {
      element.cancel();
    }
    _subs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: urlTextController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.urlInputText,
              ),
            ),
            TextField(
              obscureText: true,
              controller: codeTextController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.codeInputText,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _clientAuth(urlTextController.text, codeTextController.text);
              },
              child: Text(AppLocalizations.of(context)!.connectButtonText),
            ),
            ElevatedButton(
              onPressed: () {
                _clientGetConfig();
              },
              child: const Text('GetConfig'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/config');
              },
              child: Text('Config - test'),
            ),
          ],
        ),
      ),
    );
  }

  void _clientAuth(String urlStr, String code) {
    _client.connect(Uri.parse(urlStr), code);
  }

  void _clientGetConfig() {
    _client.send(WSConfigDownloadCommand());
  }

  void _parseCommand(WebSocketCommand msg) {
    switch (msg.type) {
      case WSConfigContentCommand.TYPE:
        executeWSConfigContentCommand(msg as WSConfigContentCommand);
        break;
      default:
    }
  }

  static const prettyPrintJSONEncode = JsonEncoder.withIndent('  ');
  void executeWSConfigContentCommand(WSConfigContentCommand msg) {
    _log.info('Recived config:');
    _log.info(prettyPrintJSONEncode.convert(json.decode(msg.content)));
  }
}

class ClientService {
  static int _id = 0;
  final _log = Logger('ClientService [${_id++}]');
  WebSocketChannel? channel;
  bool _isAuth = false;
  bool get isAuth => _isAuth;
  final _onDisconnect = StreamController.broadcast();
  final _onConnect = StreamController.broadcast();
  final _onCommand = StreamController<WebSocketCommand>.broadcast();
  Stream<WebSocketCommand> get onCommand => _onCommand.stream;
  Stream get onDisconnect => _onDisconnect.stream;
  Stream get onConnect => _onConnect.stream;
  String _authCode = '';
  ClientService();
  void connect(Uri uri, String code) {
    if (channel != null) {
      disconnect();
    }
    _authCode = code;
    channel = WebSocketChannel.connect(uri);
    channel!.stream.listen(_parseCommand).onDone(disconnect);
    _log.info('User connected');
  }

  void disconnect() {
    _isAuth = false;
    if (channel == null) {
      return;
    }
    channel!.sink.close(status.goingAway);
    channel = null;
    _onDisconnect.add(null);
    _log.info('User disconnected');
  }

  void send(WebSocketCommand cmd) {
    final message = json.encode(serializers.serialize(cmd));
    _log.info('user> "$message"');
    if (channel == null) {
      return;
    }
    channel!.sink.add(message);
  }

  void _parseCommand(dynamic message) {
    try {
      _log.info('user< "$message"');
      final msg = serializers.deserialize(json.decode(message.toString())) as WebSocketCommand;
      switch (msg.type) {
        case WSHelloCommand.TYPE:
          _executeWSHelloCommand(msg as WSHelloCommand);
          break;
        case WSAuthReqCommand.TYPE:
          executeWSAuthReqCommand(msg as WSAuthReqCommand);
          break;
        default:
      }
      _onCommand.add(msg);
    } catch (e, st) {
      _log.severe(e.toString(), e, st);
    }
  }

  void _executeWSHelloCommand(WSHelloCommand msg) {
    _isAuth = true;
  }

  void executeWSAuthReqCommand(WSAuthReqCommand msg) {
    _isAuth = false;
    send(WSAuthCommand((b) => b.code = _authCode));
  }
}
