import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:io' as io;
import 'package:path/path.dart' as path;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/command/web_server_commands.dart';
import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf_virtual_directory/shelf_virtual_directory.dart';

class WebService {
  static final Logger _log = new Logger('WebService');
  static final math.Random _rnd = math.Random();
  final RemoteService _remoteBackendService;
  String _code = '__';
  String get code => _code;
  final WebServerConfig _config;
  final AppConfig _appConfig;

  Router _router = Router();

  bool _enabled = false;
  bool get enabled => _enabled;

  void set enabled(bool newvalue) {
    if (_config.alwaysEnabled) {
      newvalue = true;
    }
    if (newvalue == _enabled) {
      return;
    }
    _enabled = newvalue;
    if (newvalue) {
      _startWebServer();
    } else {
      _stopWebServer();
    }
  }

  String _generateCode() {
    var sb = new StringBuffer();
    var count = 8;
    while (count > 0) {
      sb.write(_rnd.nextInt(10));
      count--;
    }
    if (_config.permanentCode != null) {
      return _config.permanentCode.toString();
    }
    return sb.toString();
  }

  void updateCode() {
    _code = _generateCode();
    _log.info('New code: $_code');
  }

  WebService(this._appConfig, this._config, this._remoteBackendService) {
    updateCode();
    _router.get('/info', _getInfo);
    _router.get("/ws", _webSocketHandler);

    final fsPath = path.join(io.Directory.current.path, 'web'); // path to server
    final virtualDir = ShelfVirtualDirectory(
      fsPath,
      defaultFile: 'index.html',
      default404File: '404.html',
    );
    _router.mount('/', virtualDir.router);

    enabled = _config.alwaysEnabled;
    if (_config.alwaysEnabled) {
      _log.warning('Web server always on');
    }
    if (_config.permanentCode != null) {
      _log.severe('Permanent code enabled = "$_code"');
    }
  }

  io.HttpServer? _server;

  Response _getInfo(Request request) {
    return Response.ok(_infoHtml, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  static const _infoHtml = """
<html>
<head>
<title>DSlideShow v${ApplicationInfo.frontendVersion}</title>
</head>
<body>
 <div>
    <p><b>DSlideShow</b></p>
    <p>frontend: v${ApplicationInfo.frontendVersion}</p> 
    <p>backend: v${ApplicationInfo.backendVersion}</p> 
 </div>
</body>
</html>
""";

  final _activeUsers = <WebSocketUser>[];
  FutureOr<Response> _webSocketHandler(Request request) {
    return webSocketHandler((WebSocketChannel webSocket) {
      final newUser = new WebSocketUser(_appConfig, _code, webSocket, request.headers, this._remoteBackendService);
      _activeUsers.add(newUser);
      newUser.onDisconnect.then((dynamic value) {
        _activeUsers.remove(newUser);
      });
    })(request);
  }

  void _startWebServer() async {
    _log.info('_startServer');
    if (_server != null) {
      _log.info('Is the server running?');
      _stopWebServer();
    }
    io.HttpServer server = await io.serve(_router, '0.0.0.0', _config.port);
    _server = server;
    // Enable content compression
    server.autoCompress = true;

    _log.info('Serving at http://${server.address.host}:${server.port} authCode:$_code');
  }

  void _stopWebServer() {
    _log.info('_stopServer');
    if (_server != null) {
      final tmpUsers = <WebSocketUser>[]..addAll(_activeUsers);
      _activeUsers.clear();
      tmpUsers.forEach((element) {
        element.disconnect();
      });
      _server?.close(force: true);
      _server = null;
    }
  }
}

class WebSocketUser {
  static int _id = 0;
  final Logger _log = new Logger('WebSocketUser [${_id++}]');
  final String _code;
  // final AppConfig _appConfig = injector.get();
  final WebSocketChannel _webSocket;
  final Map<String, String> _headers;
  final AppConfig _appConfig;
  final _onDisconnect = new Completer<void>();
  bool _isAuth = false;
  Future get onDisconnect => _onDisconnect.future;
  final RemoteService _remoteBackendService;

  void disconnect() {
    _webSocket.sink.close();
  }

  WebSocketUser(this._appConfig, this._code, this._webSocket, this._headers, this._remoteBackendService) {
    _log.info('User connected');
    // now we have access to request argument
    // that key is being generated by the websocket itself, every connection has a unique key.
    _webSocket.stream.listen(_parseCommand).onDone(_onDisconnected);
    send(new WSAuthReqCommand());
  }

  void send(WebSocketCommand cmd) {
    final message = json.encode(serializers.serialize(cmd));
    _log.info('user< "$message"');
    _webSocket.sink.add(message);
  }

  void _onDisconnected() {
    _log.info('User disconnected');
    _onDisconnect.complete(); // client disconnected.
  }

  void _parseCommand(dynamic message) {
    try {
      _log.info('user> "$message"');
      final msg = serializers.deserialize(json.decode(message.toString())) as WebSocketCommand;
      if (!_isAuth) {
        _parseAnonymousUserCommand(msg);
        return;
      }
      switch (msg.type) {
        case WSConfigDownloadCommand.TYPE:
          _executeWSConfigDownloadCommand(msg as WSConfigDownloadCommand);
          break;
        case WSConfigUploadCommand.TYPE:
          _executeWSConfigUploadCommand(msg as WSConfigUploadCommand);
          break;
        case WSRestartApplicationCommand.TYPE:
          _executeWSRestartApplicationCommand(msg as WSRestartApplicationCommand);
          break;
        case WSSendRpcCommand.TYPE:
          _executeWSSendRpcCommand(msg as WSSendRpcCommand);
          break;
        default:
      }
    } catch (e, st) {
      _log.severe(e.toString(), e, st);
    }
  }

  void _executeWSAuthCommand(WSAuthCommand msg) {
    if (msg.code != _code) {
      _isAuth = false;
      _log.warning('Incorrect code=${msg.code}');
      disconnect();
    } else {
      _log.info('User auth!');
      _isAuth = true;
      send(new WSHelloCommand());
    }
  }

  void _parseAnonymousUserCommand(WebSocketCommand msg) {
    switch (msg.type) {
      case WSAuthCommand.TYPE:
        _executeWSAuthCommand(msg as WSAuthCommand);
        break;
      default:
        disconnect();
        return;
    }
  }

  void _executeWSConfigDownloadCommand(WSConfigDownloadCommand msg) {
    send(new WSConfigContentCommand((b) => b.content = json.encode(_appConfig.toJson())));
  }

  void _executeWSConfigUploadCommand(WSConfigUploadCommand msg) {
    var _newAppConfig = AppConfig.fromJson(json.decode(msg.content) as Map<String, dynamic>);
    _newAppConfig.toFile(_appConfig.fullConfigFilename);
    send(new WSResultOk());
  }

  void _executeWSRestartApplicationCommand(WSRestartApplicationCommand msg) {
    _log.info('Restart application');
    io.Process.run('sudo', ['systemctl', 'restart', 'dslideshow'], environment: {'LC_ALL': 'C'});
  }

  void _executeWSSendRpcCommand(WSSendRpcCommand msg) async {
    final result = await _remoteBackendService.send(msg.command);
    send(new WSRpcResult((b) => b.result = result));
  }
}
