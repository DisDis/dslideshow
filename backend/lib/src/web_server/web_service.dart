import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:io' as io;
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/web_server/web_server_routes.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart' as hp;
import 'package:shelf_multipart/shelf_multipart.dart';

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
import 'package:dslideshow_backend/environment.dart';
import 'package:mime/mime.dart' as mime;

class WebService {
  static final Logger _log = new Logger('WebService');
  static final math.Random _rnd = math.Random();
  final _cacheFolder = new io.Directory(
    path.join(externalStorage.path, DiskStorage.CACHE_FOLDER_NAME),
  );
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
    var count = 5;
    while (count > 0) {
      sb.write(_rnd.nextInt(10));
      count--;
    }
    if (_config.permanentCode != null || _config.permanentCode != '') {
      return _config.permanentCode.toString();
    }
    return sb.toString();
  }

  void updateCode() {
    _code = _generateCode();
    _log.info('New code: $_code');
  }

  Future<Map<String, Object>> _defaultFileheaderParser(io.File file) async {
    final fileType = mime.lookupMimeType(file.path);

    // collect file data
    final fileStat = file.statSync();

    // check file permission
    if (fileStat.modeString()[0] != 'r') return {};

    return {
      io.HttpHeaders.contentTypeHeader: fileType ?? 'application/octet-stream',
      io.HttpHeaders.contentLengthHeader: fileStat.size.toString(),
      io.HttpHeaders.lastModifiedHeader: hp.formatHttpDate(fileStat.modified),
      io.HttpHeaders.acceptRangesHeader: 'bytes',
    };
  }

  WebService(this._appConfig, this._config, this._remoteBackendService) {
    updateCode();
    _router.get(WebServerRoutes.info, _getInfo);
    _router.get(WebServerRoutes.webSocket, _webSocketHandler);
    _router.get(WebServerRoutes.getMedialItemsList, _getItemsList);
    _router.get(WebServerRoutes.getMediaItem, _getItem);
    _router.post(WebServerRoutes.uploadMedia, _postUploadMedia);
    _router.get(WebServerRoutes.uploadMedia, _getUploadForm);

    final fsPath = path.join(
      io.Directory.current.path,
      'web',
    ); // path to server
    _log.info("WebServer root: $fsPath");
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
    if (_config.permanentCode != null || _config.permanentCode != '') {
      _log.severe('Permanent code enabled = "$_code"');
    }
  }

  io.HttpServer? _server;

  Response _getUploadForm(Request request) {
    return Response.ok(_uploadMediaForm, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  static const _uploadMediaForm =
      """
<html>
<head>
<title>Upload media file</title>
</head>
<body>
<form method="post" enctype="multipart/form-data">
 <div>
    <p>v${ApplicationInfo.frontendVersion}</p> 
    <p><b>Upload media file</b></p>
   <label for="file">Choose file to upload</label><Br>
   <input type="file" id="file" name="file" multiple>
 </div>
 <div>
   <button>Upload</button>
 </div>
</form>
</body>
</html>
""";

  Response _getInfo(Request request) {
    if (request.params.isNotEmpty && request.params.containsKey("format")) {
      if (request.params['format'] == 'json') {
        return Response.ok(
          _infoJSON,
          headers: {'content-type': 'text/json; charset=utf-8'},
        );
      }
    }
    return Response.ok(
      _infoHtml,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
  }

  static const _infoJSON =
      '{"version":{"frontend":"${ApplicationInfo.frontendVersion}","backend":"${ApplicationInfo.backendVersion}"}}';
  static const _infoHtml =
      """
<html>
<head>
<title>DSlideShow v${ApplicationInfo.frontendVersion}</title>
</head>
<body>
 <div>
    <p><b>DSlideShow</b></p>
    <p>frontend: v${ApplicationInfo.frontendVersion}</p> 
    <p>backend: v${ApplicationInfo.backendVersion}</p> 
    <p>Use ?format=json for JSON data</p>
 </div>
</body>
</html>
""";

  final _activeUsers = <WebSocketUser>[];
  Future<Response> _webSocketHandler(Request request) async {
    _log.info('_webSocketHandler');
    return webSocketHandler((WebSocketChannel webSocket, _) {
      final newUser = new WebSocketUser(
        _appConfig,
        _code,
        webSocket,
        request.headers,
        this._remoteBackendService,
      );
      _activeUsers.add(newUser);
      newUser.onDisconnect.then((dynamic value) {
        _activeUsers.remove(newUser);
      });
    })(request);
  }

  Future<Response> _postUploadMedia(
    Request request,
    final String code,
    String itemPath,
  ) async {
    if (code != _code) {
      return Response.forbidden('Code is incorrect');
    }
    String filename = '';
    int uploadedSize = 0;

    final mediaData = io.BytesBuilder();
    var multiPartR = request.multipart();
    if (multiPartR == null /*!request.isMultipart*/ ) {
      return Response.badRequest(body: 'Not a multipart request');
    }

    var multipartFormData = request.formData();
    if ( /*!request.isMultipartForm*/ multipartFormData == null) {
      return Response.forbidden('Need multipart request');
    }
    _log.info('Parsed form multipart request');
    var fullSize = request.contentLength!;
    //200Mb
    if (fullSize > 200 * 1024 * 1024) {
      return Response.ok('Too big size (200Mb>)');
    }
    await for (final formData
        in multipartFormData.formData /*request.multipartFormData*/ ) {
      // if (formData.name == 'code') {
      //   code = await formData.part.readString();
      //   _log.info('code="$code"');
      // } else
      if (formData.name == 'file') {
        filename = formData.filename!;
        _log.info('Filename "$filename"');
        await formData.part.forEach((bytes) {
          mediaData.add(bytes);
          uploadedSize += bytes.length;
          _log.info(
            "Uploading '$itemPath' - ${(uploadedSize / fullSize * 100).toStringAsFixed(1)}",
          );
        });
      }
    }
    _log.info('file size: ${mediaData.length}');
    // if (code != _code) {
    //   return Response.forbidden('Code error');
    // }

    try {
      _processMediaFile(itemPath, filename, mediaData);
    } catch (e) {
      return Response.forbidden('Upload error: $e');
    }
    return Response.ok('File uploaded');
  }

  void _startWebServer() async {
    _log.info('_startServer');
    if (_server != null) {
      _log.info('Is the server running?');
      _stopWebServer();
    }
    //HTTPS? securityContext: io.SecurityContext()
    io.HttpServer server = await io.serve(
      _router,
      io.InternetAddress.anyIPv4,
      _config.port,
    );
    _server = server;
    // Enable content compression
    server.autoCompress = true;

    _log.info(
      'Serving at http://${server.address.host}:${server.port} authCode:$_code',
    );
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

  Response _getItemsList(Request request, String code) {
    if (code != _code) {
      return Response.forbidden('Code is incorrect');
    }
    final StringBuffer sb = StringBuffer();
    sb.writeln('{"items":[');
    final cachePath = _cacheFolder.path;
    var items = _cacheFolder.listSync(recursive: true);
    bool isFirst = true;
    items.forEach((imageUri) {
      if (isFirst) {
        isFirst = false;
      } else {
        sb.write(',');
      }
      sb.writeln('"${path.relative(imageUri.path, from: cachePath)}"');
    });
    sb.writeln(']}');
    return Response.ok(
      sb.toString(),
      headers: {'content-type': 'text/json; charset=utf-8'},
    );
  }

  Future<Response> _getItem(Request req, String code, String itemPath) async {
    if (code != _code) {
      return Response.forbidden('Code is incorrect');
    }
    itemPath = Uri.decodeFull(itemPath);
    _log.info("get item: '$itemPath'");
    itemPath = path.absolute(path.join(_cacheFolder.path, itemPath));
    final file = io.File(itemPath);
    if (!file.existsSync() || !itemPath.startsWith(_cacheFolder.path)) {
      return Response.notFound('$itemPath');
    }

    // collect file data
    final fileStat = file.statSync();

    // check file permission of
    if (fileStat.modeString()[0] != 'r') return Response.forbidden('Forbidden');
    final length = fileStat.size;
    final range = req.headers[io.HttpHeaders.rangeHeader];
    var headerParser = _defaultFileheaderParser;
    final headers = await headerParser(file);

    if (range != null) {
      final matches = RegExp(r'^bytes=(\d*)\-(\d*)$').firstMatch(range);
      if (matches != null) {
        final startMatch = matches[1] ?? '';
        final endMatch = matches[2] ?? '';
        if (startMatch.isNotEmpty || endMatch.isNotEmpty) {
          int start;
          int end;
          if (startMatch.isEmpty) {
            start = length - int.parse(endMatch);
            if (start < 0) start = 0;
            end = length - 1;
          } else {
            start = int.parse(startMatch);
            end = endMatch.isEmpty ? length - 1 : int.parse(endMatch);
          }
          // If the range is syntactically invalid the Range header
          // MUST be ignored (RFC 2616 section 14.35.1).
          if (start <= end) {
            if (end >= length) {
              end = length - 1;
            }
            if (start >= length) {
              return Response(
                io.HttpStatus.requestedRangeNotSatisfiable,
                // headers: headers,
              );
            }

            // Override Content-Length with the actual bytes sent.
            headers[io.HttpHeaders.contentLengthHeader] = (end - start + 1)
                .toString();

            // Set 'Partial Content' status code.
            headers[io.HttpHeaders.contentRangeHeader] =
                'bytes $start-$end/$length';
            // Pipe the 'range' of the file.

            return Response(
              io.HttpStatus.partialContent,
              body: req.method == 'HEAD' ? null : file.openRead(start, end + 1),
              headers: headers,
            );
          }
        }
      }
    }

    return Response(
      200,
      body: req.method == 'HEAD' ? null : file.openRead(),
      headers: headers,
    );
  }

  Future<Future<io.File>> _processMediaFile(
    String itemPath,
    String filename,
    io.BytesBuilder mediaData,
  ) async {
    itemPath = Uri.decodeFull(itemPath);
    _log.info('_processMediaFile "${itemPath}" size:${mediaData.length}');
    final fullFilename = path.absolute(path.join(_cacheFolder.path, itemPath));
    if (!fullFilename.startsWith(_cacheFolder.path)) {
      throw Exception('Outside cache folder');
    }
    final file = io.File(fullFilename);

    await file.parent.create(recursive: true);

    return file.writeAsBytes(mediaData.toBytes(), flush: true);
  }
}

enum WebSocketUserStatus { anonymous, authorization, authorized }

class WebSocketUser {
  static int _id = 0;
  final Logger _log = new Logger('WebSocketUser [${_id++}]');
  final String _code;
  // final AppConfig _appConfig = injector.get();
  final WebSocketChannel _webSocket;
  // ignore: unused_field
  final Map<String, String> _headers;
  final AppConfig _appConfig;
  final _onDisconnect = new Completer<void>();
  WebSocketUserStatus _status = WebSocketUserStatus.anonymous;
  Future get onDisconnect => _onDisconnect.future;
  final RemoteService _remoteBackendService;

  final _resultQueue = Map<int, Completer<WebSocketResult>>();

  void disconnect() {
    _webSocket.sink.close();
    _resultQueue.forEach((key, value) {
      value.completeError(WSErrorResult.byId('disconnect', key));
    });
    _resultQueue.clear();
  }

  WebSocketUser(
    this._appConfig,
    this._code,
    this._webSocket,
    this._headers,
    this._remoteBackendService,
  ) {
    _log.info('User connected');
    // now we have access to request argument
    // that key is being generated by the websocket itself, every connection has a unique key.
    _webSocket.stream.listen(_parseMessage).onDone(_onDisconnected);
    // send(new WSAuthReqCommand());
  }

  Future<WebSocketResult> send(WebSocketCommand cmd) {
    sendOneWay(cmd);
    return _addMessageToQueue(cmd.id);
  }

  void sendOneWay(WebSocketCommand cmd) {
    final message = json.encode(serializers.serialize(cmd));
    _log.info('user< "$message"');
    _webSocket.sink.add(message);
  }

  void response(WebSocketResult result) {
    final message = json.encode(serializers.serialize(result));
    _log.info('user< result "$message"');
    _webSocket.sink.add(message);
  }

  void _onDisconnected() {
    _log.info('User disconnected');
    _onDisconnect.complete(); // client disconnected.
  }

  void _parseMessage(dynamic message) {
    try {
      _log.info('user> "$message"');
      final msg =
          serializers.deserialize(json.decode(message.toString()))
              as WebSocketResult;
      if (msg is WebSocketCommand) {
        _execCommand(msg);
      } else {
        _processResult(msg);
      }
    } catch (e, st) {
      _log.severe(e.toString(), e, st);
    }
  }

  void _execCommand(WebSocketCommand command) async {
    try {
      if (_status != WebSocketUserStatus.authorized) {
        _parseAnonymousUserCommand(command);
        return;
      }
      WebSocketResult result;
      switch (command.type) {
        case WSConfigDownloadCommand.TYPE:
          result = _executeWSConfigDownloadCommand(
            command as WSConfigDownloadCommand,
          );
          break;
        case WSConfigUploadCommand.TYPE:
          result = _executeWSConfigUploadCommand(
            command as WSConfigUploadCommand,
          );
          break;
        case WSRestartApplicationCommand.TYPE:
          result = _executeWSRestartApplicationCommand(
            command as WSRestartApplicationCommand,
          );
          break;
        case WSSendRpcCommand.TYPE:
          result = await _executeWSSendRpcCommand(command as WSSendRpcCommand);
          break;
        case WSEchoCommand.TYPE:
          result = await _executeWSEchoCommand(command as WSEchoCommand);
          break;
        default:
          result = WSErrorResult.byCommand('Unknown command', command);
          break;
      }
      response(result);
    } catch (e, st) {
      _log.severe(e.toString(), e, st);
      response(WSErrorResult.byCommand(e.toString(), command));
    }
  }

  Future<WebSocketResult> _executeWSAuthCommand(WSAuthCommand msg) async {
    _status = WebSocketUserStatus.authorization;
    await Future<void>.delayed(const Duration(seconds: 1));
    if (msg.code != _code) {
      _status = WebSocketUserStatus.anonymous;
      _log.warning('Incorrect user="${msg.userName}" or code="${msg.code}"');
      disconnect();
      return WSErrorResult.byCommand("Incorrect user or code", msg);
    } else {
      _log.info('User auth!');
      _status = WebSocketUserStatus.authorized;
      sendOneWay(WSHelloCommand(id: WebSocketCommand.generateId()));
      return WSResultOk.byCommand(msg);
    }
  }

  void _parseAnonymousUserCommand(WebSocketCommand msg) async {
    if (_status == WebSocketUserStatus.authorization) {
      _log.info('User tries to send auth again');
      disconnect();
      return;
    }
    switch (msg.type) {
      case WSAuthCommand.TYPE:
        response(await _executeWSAuthCommand(msg as WSAuthCommand));
        break;
      default:
        disconnect();
        return;
    }
  }

  WSConfigDownloadResult _executeWSConfigDownloadCommand(
    WSConfigDownloadCommand msg,
  ) {
    return WSConfigDownloadResult(
      content: json.encode(_appConfig.toJson()),
      id: msg.id,
    );
  }

  WebSocketResult _executeWSConfigUploadCommand(WSConfigUploadCommand msg) {
    var _newAppConfig = AppConfig.fromJson(
      json.decode(msg.content) as Map<String, dynamic>,
    );
    _newAppConfig.toFile(_appConfig.fullConfigFilename);
    return WSResultOk.byCommand(msg);
  }

  WebSocketResult _executeWSRestartApplicationCommand(
    WSRestartApplicationCommand msg,
  ) {
    _log.info('Restart application');
    io.Process.run(
      'sudo',
      ['systemctl', 'restart', 'dslideshow'],
      environment: {'LC_ALL': 'C'},
    );
    return WSResultOk.byCommand(msg);
  }

  Future<WSRpcResult> _executeWSSendRpcCommand(WSSendRpcCommand msg) async {
    final result = await _remoteBackendService.send(
      serializers.deserialize(msg.commandData)! as RpcCommand,
    );
    return WSRpcResult.byCommand(result, msg);
  }

  Future<WebSocketResult> _addMessageToQueue(int id) {
    final result = _resultQueue.putIfAbsent(
      id,
      () => Completer<WebSocketResult>(),
    );
    return result.future;
  }

  void _processResult(WebSocketResult msg) {
    final completer = _resultQueue.remove(msg.id);
    if (completer != null) {
      if (msg is WebSocketErrorResult) {
        completer.completeError(msg);
      } else {
        completer.complete(msg);
      }
    }
  }

  Future<WebSocketResult> _executeWSEchoCommand(WSEchoCommand command) async {
    if (command.msg.toUpperCase() == 'ERROR') {
      throw command.msg;
    }
    return WSEchoResult(id: command.id, msg: command.msg);
  }
}
