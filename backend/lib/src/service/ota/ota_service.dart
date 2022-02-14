// import 'dart:io' as io;
import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/env/default.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/form_data.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:path/path.dart' as path;

class OTAService implements RpcService {
  static final Logger _log = new Logger('OTAService');
  static const _webPort = 8282;
  String _code = _generateCode();
  String get code => _code;

  final io.Directory _folder = new io.Directory(path.join(externalStorage.path, 'firmwares'));
  static final math.Random _rnd = math.Random();

  bool _enabled = false;
  bool get enabled => _enabled;

  OTAInfo _info = OTAInfo((b) {
    b.status = OTAStatus.disabled;
    b.code = "-";
    b.uploadingPercent = 0;
  });

  void set enabled(bool newvalue) {
    if (_autostop != null && _autostop!.isActive) {
      _autostop!.cancel();
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

  Router _router = Router();
  Timer? _autostop;
  final AppConfig config;
  final RemoteService _frontendService;

  OTAService(this.config, this._frontendService) {
    _router.get('/ota_start', _getOTAStart);
    _router.get('/ota_stop', _getOTAStop);
    _router.get('/ota_download_config', _getOTAGetConfig);
    _router.post('/ota_download_config', _postOTAGetConfig);
    _router.get('/ota_upload_config', _getOTAUploadConfig);
    _router.post('/ota_upload_config', _postOTAUploadConfig);
    _router.post('/ota_upload', _postOTAUploadPackage);

    enabled = true;
    _autostop = new Timer(const Duration(seconds: 30), () {
      enabled = false;
    });
    _info = _info.rebuild((p0) => p0.code = code);
  }

  static String _generateCode() {
    var sb = new StringBuffer();
    var count = 8;
    while (count > 0) {
      sb.write(_rnd.nextInt(10));
      count--;
    }
    return sb.toString();
  }

  void updateCode() {
    _code = _generateCode();
    _updateInfo(_info.rebuild((b) => b.code = code));
    _log.info('New code: $_code');
  }

  io.HttpServer? _server;

  void _startWebServer() async {
    _log.info('_startServer');
    if (_server != null) {
      _log.info('Is the server running?');
      _stopWebServer();
    }
    io.HttpServer server = await io.serve(_router, '0.0.0.0', _webPort);
    _server = server;
    // Enable content compression
    server.autoCompress = true;
    _info = _info.rebuild((b) => b.status = OTAStatus.ready);

    _log.info('Serving at http://${server.address.host}:${server.port} authCode:$_code');
  }

  void _stopWebServer() {
    _log.info('_stopServer');
    if (_server != null) {
      _server?.close(force: true);
      _server = null;
    }
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    switch (command.type) {
      case EchoCommand.TYPE:
        return new Future.value(_executeEchoCommand(command as EchoCommand));
      case OTAGetInfoCommand.TYPE:
        return new Future.value(_executeOTAGetInfoCommand(command as OTAGetInfoCommand));
      default:
        return new Future.value(_generateErrorResult(new Exception("Unknown command: ${command.type}"), command));
    }
  }

  RpcResult _executeEchoCommand(EchoCommand command) {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return new EchoCommandResult((b) {
      b.id = command.id;
      b.resultText = "${command.text} Service ${new DateTime.now()}";
    });
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    return new ErrorResult((b) => b
      ..id = command.id
      ..error = "$e");
  }

  Future<RpcResult> _executeOTAGetInfoCommand(OTAGetInfoCommand command) async {
    return new OTAGetInfoCommandResult((b) {
      b.id = command.id;
      b.info = _info.toBuilder();
    });
  }

  void _updateInfo(OTAInfo newValue) {
    _info = newValue;
    _frontendService.send(new OTAGetInfoCommand((b) => b
      ..id = RpcCommand.generateId()
      ..info = _info.toBuilder()));
  }

  Future<Response> _postOTAUploadPackage(Request request) async {
    String filename = '';
    int uploadedSize = 0;
    String code = '';
    final io.BytesBuilder firmwareData = new io.BytesBuilder();
    if (!request.isMultipart) {
      _updateInfo(_info.rebuild((b) => b
        ..uploadingPercent = 0
        ..status = OTAStatus.ready));
      return Response.ok('Not a multipart request');
    } else if (!request.isMultipartForm) {
      return Response.forbidden('Need multipart request');
    }
    _log.info('Parsed form multipart request');
    var fullSize = request.contentLength!;
    //200Mb
    if (fullSize > 200 * 1024 * 1024) {
      return Response.ok('Too big size');
    }
    _updateInfo(_info.rebuild((b) => b
      ..uploadingPercent = 0
      ..status = OTAStatus.uploading));
    await for (final formData in request.multipartFormData) {
      _log.info('${formData.name}');
      if (formData.name == 'code') {
        code = await formData.part.readString();
        _log.info('code="$code"');
      } else if (formData.name == 'file') {
        filename = formData.filename!;
        _log.info('Filename "$filename"');
        await formData.part.forEach((bytes) {
          firmwareData.add(bytes);
          uploadedSize += bytes.length;
          _updateInfo(_info.rebuild((b) => b..uploadingPercent = (uploadedSize / fullSize * 100)));
        });
      }
    }
    _log.info('file size: ${firmwareData.length}');
    if (code != _code) {
      _updateInfo(_info.rebuild((b) => b
        ..uploadingPercent = 0
        ..status = OTAStatus.ready));
      return Response.forbidden('Code error');
    }
    if (path.extension(filename) != '.deb') {
      _updateInfo(_info.rebuild((b) => b
        ..uploadingPercent = 0
        ..status = OTAStatus.ready));
      return Response.forbidden('Support only deb package');
    }
    _updateInfo(_info.rebuild((b) => b
      ..uploadingPercent = 100
      ..status = OTAStatus.uploading));
    _processFirmware(filename, firmwareData);
    return Response.ok('Firmware uploaded');

    /*else {
      final description = StringBuffer('Regular multipart request\n');

      await for (final part in request.parts) {
        description.writeln('new part');

        part.headers
            .forEach((key, value) => description.writeln('Header $key=$value'));
        final content = await part.readString();
        description.writeln('content: $content');

        description.writeln('end of part');
      }

      return Response.ok(description.toString());
    }*/
  }

  static const _uploadForm = """
<html>
<head>
<title>OTA</title>
</head>
<body>
<form method="post" enctype="multipart/form-data" action="ota_upload">
 <div>
    <p><b>OTA ready</b></p>
   <label for="code">Code</label><Br>
   <input id="code" name="code" ><Br>
   <label for="file">Choose file to upload</label><Br>
   <input type="file" id="file" name="file" multiple>
 </div>
 <div>
   <button>Submit</button>
 </div>
</form>
</body>
</html>
""";

  Response _getOTAStop(Request request) {
    _frontendService.send(new OTAReadyCommand((b) => b
      ..id = RpcCommand.generateId()
      ..ready = false));
    return Response.ok('Return to normal mode');
  }

  Response _getOTAStart(Request request) {
    if (_autostop != null && _autostop!.isActive) {
      _autostop!.cancel();
    }
    _frontendService.send(new OTAReadyCommand((b) => b
      ..id = RpcCommand.generateId()
      ..ready = true));
    return Response.ok(_uploadForm, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  void _processFirmware(String filename, io.BytesBuilder firmwareData) async {
    _log.info('_processFirmware "${filename}" [${firmwareData.length}]');
    if (!_folder.existsSync()) {
      await _folder.create();
    }
    final fullFilename = path.join(_folder.path, filename);
    await io.File(fullFilename).openWrite()
      ..add(firmwareData.toBytes())
      ..close();

    _frontendService.send(new OTAOutputCommand((b) => b
      ..id = RpcCommand.generateId()
      ..output = '\n\rSave firmware to "$fullFilename"\n\r'));
    _updateInfo(_info.rebuild((b) => b
      ..uploadingPercent = 100
      ..status = OTAStatus.instaling));

    var process = await io.Process.start('sudo', ['dpkg', '-i', '$fullFilename'],
        environment: {'LC_ALL': 'C', 'TERM': 'xterm-256color', 'COLUMNS': '120'});
    process.stdout.transform(utf8.decoder).forEach((str) {
      _frontendService.send(new OTAOutputCommand((b) => b
        ..id = RpcCommand.generateId()
        ..output = str));
    });
    process.stderr.transform(utf8.decoder).forEach((str) {
      _frontendService.send(new OTAOutputCommand((b) => b
        ..id = RpcCommand.generateId()
        ..output = str));
    });
    var exitCode = await process.exitCode;
    _frontendService.send(new OTAOutputCommand((b) => b
      ..id = RpcCommand.generateId()
      ..output = '\n\rExit code: $exitCode'));
    _updateInfo(_info.rebuild((b) => b
      ..uploadingPercent = 100
      ..exitCode = exitCode
      ..status = exitCode == 0 ? OTAStatus.finished : OTAStatus.issue));
    if (exitCode == 0) {
      Timer(const Duration(seconds: 5), () {
        _updateInfo(_info.rebuild((b) => b
          ..uploadingPercent = 100
          ..exitCode = 0
          ..status = OTAStatus.preReboot));
        Timer(const Duration(seconds: 5), () {
          io.Process.start('pkill', ['flutter']);
        });
      });
    }
  }

  Response _getOTAGetConfig(Request request) {
    return Response.ok(_downloadConfigForm, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  static const _downloadConfigForm = """
<html>
<head>
<title>OTA get config.json</title>
</head>
<body>
<form method="post" >
 <div>
    <p><b>OTA get config.json</b></p>
   <label for="code">Code</label><Br>
   <input id="code" name="code" ><Br>
 </div>
 <div>
   <button>Submit</button>
 </div>
</form>
</body>
</html>
""";

  Future<Response> _postOTAGetConfig(Request request) async {
    var content = await request.readAsString(); //.transform(utf8.decoder).join();
    var queryParams = Uri(query: content).queryParameters;
    if (queryParams['code'] != _code) {
      return Response.forbidden('Incorrect code');
    }
    return Response.ok(io.File(config.fullConfigFilename).readAsStringSync(),
        headers: {'Content-Type': 'text/plain; charset=utf-8'});
  }

  static const _uploadConfigForm = """
<html>
<head>
<title>OTA upload config.json</title>
</head>
<body>
<form method="post" enctype="multipart/form-data" >
 <div>
    <p><b>OTA upload config.json</b></p>
   <label for="code">Code</label><Br>
   <input id="code" name="code" ><Br>
   <label for="file">Choose file to upload config</label><Br>
   <input type="file" id="file" name="file" multiple>
 </div>
 <div>
   <button>Submit</button>
 </div>
</form>
</body>
</html>
""";

  Response _getOTAUploadConfig(Request request) {
    return Response.ok(_uploadConfigForm, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  Future<Response> _postOTAUploadConfig(Request request) async {
    String code = '';
    String configData = '';
    if (!request.isMultipart) {
      return Response.ok('Not a multipart request');
    }
    if (!request.isMultipartForm) {
      return Response.forbidden('Need multipart request');
    }
    _log.info('Parsed form multipart request');
    var fullSize = request.contentLength!;
    //200Mb
    if (fullSize > 20 * 1024 * 1024) {
      return Response.ok('Too big size');
    }

    await for (final formData in request.multipartFormData) {
      _log.info('${formData.name}');
      if (formData.name == 'code') {
        code = await formData.part.readString();
        _log.info('code="$code"');
      } else if (formData.name == 'file') {
        _log.info('Filename "${formData.filename!}}"');
        configData = await formData.part.readString();
      }
    }
    _log.info('file size: ${configData.length}');
    if (code != _code) {
      return Response.forbidden('Code error');
    }
    try {
      AppConfig.json(configData);
      io.File(config.fullConfigFilename)
        ..openWrite()
        ..writeAsStringSync(configData);
    } catch (e, st) {
      _log.warning("Parse & save config to '${config.fullConfigFilename}'", e, st);
      return Response.forbidden('Error: $e');
    }
    _log.info('Config updated');
    return Response.ok('Config updated');
  }
}
