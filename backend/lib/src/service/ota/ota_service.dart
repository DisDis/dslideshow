import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;
import 'dart:typed_data' as io;
import 'dart:typed_data';

import 'package:dslideshow_backend/src/service/ota/release_info.dart';
import 'package:http/http.dart' as http;
import 'package:pub_semver/pub_semver.dart';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/env/default.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:path/path.dart' as path;

class OTAService implements RpcService {
  static final Logger _log = new Logger('OTAService');
  static const _webPort = 8282;
  String _code = _generateCode();
  String get code => _code;

  final io.Directory _folder = new io.Directory(
    path.join(externalStorage.path, 'firmwares'),
  );
  static final math.Random _rnd = math.Random();

  bool _enabled = false;
  bool get enabled => _enabled;

  OTAInfo _info = OTAInfo(
    status: OTAStatus.disabled,
    code: "-",
    uploadingPercent: 0,
  );

  void set enabled(bool newvalue) {
    if (config.ota.alwaysEnabled) {
      newvalue = true;
    }
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

  OTAService({required this.config, required RemoteService frontendService})
    : this._frontendService = frontendService {
    _router.get('/ota_start', _getOTAStart);
    _router.get('/ota_stop', _getOTAStop);
    _router.get('/ota_download_config', _getOTAGetConfig);
    _router.post('/ota_download_config', _postOTAGetConfig);
    _router.get('/ota_upload_config', _getOTAUploadConfig);
    _router.post('/ota_upload_config', _postOTAUploadConfig);
    _router.post('/ota_upload', _postOTAUploadPackage);

    enabled = true;
    _autostop = Timer(const Duration(seconds: 60 * 5), () {
      enabled = false;
    });
    _info = _info.copyWith(code: code);
    if (config.ota.alwaysEnabled) {
      enabled = config.ota.alwaysEnabled;
      _log.warning('OTA server always on');
    }
    if (config.ota.autoUpdateEnabled) {
      Timer.periodic(const Duration(minutes: 60), (timer) {
        _checkLatestRelease();
      });
    }
  }

  void _checkLatestRelease() async {
    _log.info("Checking new version...");
    final releaseInfo = await _fetchLatestDebRelease();
    if (releaseInfo != null) {
      final currentVersion = Version.parse(ApplicationInfo.frontendVersion);
      if (currentVersion >= releaseInfo.version) {
        _log.info(
          'The current version "${ApplicationInfo.frontendVersion}" is the latest',
        );
        return;
      }
      _log.info("Found new version '${releaseInfo.version}'");
      if (!enabled) {
        enabled = true;
      }
      _log.info('Try to download "${releaseInfo.debUrl}"');
      try {
        final fWait = Future.delayed(Duration(seconds: 1));
        await _switchFrontendToOTAScreen();
        await fWait;
        _updateInfo(
          _info.copyWith(uploadingPercent: 0, status: OTAStatus.uploading),
        );
        _frontendService.send(
          OTAOutputCommand(
            id: RpcCommand.generateId(),
            output: "Try to download new version '${releaseInfo.version}'\n\r",
          ),
        );

        final debUri = Uri.parse(releaseInfo.debUrl);
        final fileName = path.basename(Uri.decodeFull(releaseInfo.debUrl));
        final httpClient = io.HttpClient();
        httpClient.connectionTimeout = const Duration(seconds: 60);
        httpClient.idleTimeout = const Duration(seconds: 60);
        final request = await httpClient.get(
          debUri.host,
          debUri.port,
          debUri.path,
        );
        request.headers.add('User-Agent', 'dslideshow-flutter-app');
        var response = await request.close();
        if (response.statusCode != io.HttpStatus.ok) {
          throw io.HttpException(
            'Failed to download file. Status: ${response.statusCode} ${response.reasonPhrase}',
          );
        }
        final firmwareData = await downloadFileToMemory(
          response: response,
          onProgress: (uploadedSize, fullSize) {
            _updateInfo(
              _info.copyWith(uploadingPercent: (uploadedSize / fullSize * 100)),
            );
          },
        );

        // final response = await http.get(debUri,headers: {'User-Agent': 'dslideshow-flutter-app'});
        //_processFirmware(fileName, response.bodyBytes);
        _updateInfo(_info.copyWith(uploadingPercent: 100));
        _processFirmware(fileName, firmwareData);
      } catch (e) {
        _log.warning("checkLatestRelease error: $e");
      } finally {
        Timer(const Duration(seconds: 60), () {
          _switchFrontendToSlideshowScreen();
        });
      }
    } else {
      _log.warning("Not found last release info, no Internet?");
    }
  }

  /// Downloads a file to memory and returns Uint8List with progress tracking
  Future<Uint8List> downloadFileToMemory({
    required void Function(int receivedBytes, int totalBytes) onProgress,
    required io.HttpClientResponse response,
  }) async {
    final contentLength = response.headers.contentLength;
    if (contentLength == -1) {
      throw io.HttpException('Content-Length header is missing or invalid');
    }

    BytesBuilder buffer = BytesBuilder();
    int receivedBytes = 0;
    final completer = Completer<Uint8List>();

    response.listen(
      (List<int> data) {
        buffer.add(data);
        receivedBytes += data.length;

        onProgress(receivedBytes, contentLength);
      },
      onError: (error) {
        completer.completeError(error);
      },
      onDone: () {
        completer.complete(buffer.takeBytes());
      },
    );
    return completer.future;
  }

  Future<ReleaseInfo?> _fetchLatestDebRelease() async {
    final url = Uri.parse(
      'https://api.github.com/repos/DisDis/dslideshow/releases/latest',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'Flutter-App',
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      if (response.statusCode != 200) {
        _log.warning(
          'Ошибка получения релиза: ${response.statusCode} - ${response.body}',
        );
        return null;
      }

      final releaseData = json.decode(response.body);
      return parseReleaseData(releaseData);
    } catch (e) {
      _log.warning('Ошибка при выполнении запроса: $e');
      return null;
    }
  }

  static ReleaseInfo? parseReleaseData(Map<String, dynamic> releaseData) {
    // Получаем тег версии и преобразуем в SemVer
    final tagName = releaseData['tag_name'] as String?;
    if (tagName == null) {
      _log.warning('Тег версии не найден в ответе');
      return null;
    }

    // Очищаем тег от префикса 'v' если он есть и парсим в SemVer
    final cleanVersion = tagName.startsWith('v')
        ? tagName.substring(1)
        : tagName;

    try {
      final version = Version.parse(cleanVersion);

      // Ищем .deb файл среди assets
      final assets = releaseData['assets'] as List?;
      if (assets == null || assets.isEmpty) {
        _log.warning('Assets не найдены в релизе');
        return null;
      }

      final debAsset = assets.firstWhere((asset) {
        final name = asset['name'] as String?;
        return name != null && name.endsWith('.deb');
      }, orElse: () => null);

      if (debAsset == null) {
        _log.warning('DEB пакет не найден среди assets');
        return null;
      }

      final debUrl = debAsset['browser_download_url'] as String?;
      if (debUrl == null) {
        _log.warning('URL для скачивания не найден');
        return null;
      }

      return ReleaseInfo(version: version, debUrl: debUrl);
    } catch (e) {
      _log.warning('Ошибка парсинга версии $cleanVersion: $e');
      return null;
    }
  }

  static String _generateCode() {
    var sb = StringBuffer();
    var count = 5;
    while (count > 0) {
      sb.write(_rnd.nextInt(10));
      count--;
    }
    return sb.toString();
  }

  void updateCode() {
    _code = _generateCode();
    _updateInfo(_info.copyWith(code: code));
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
    _info = _info.copyWith(status: OTAStatus.ready);

    _log.info(
      'Serving at http://${server.address.host}:${server.port} authCode:$_code',
    );
  }

  Future<void> _stopWebServer() async {
    _log.info('_stopServer');
    if (_server != null) {
      await _server?.close(force: true);
      _server = null;
    }
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    switch (command.type) {
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      case OTAGetInfoCommand.TYPE:
        return _executeOTAGetInfoCommand(command as OTAGetInfoCommand);
      default:
        return _generateErrorResult(
          new Exception("Unknown command: ${command.type}"),
          command,
        );
    }
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return new EchoCommandResult(
      id: command.id,
      resultText: "${command.text} Service ${new DateTime.now()}",
    );
  }

  Future<RpcErrorResult> _generateErrorResult(
    Object e,
    RpcCommand command,
  ) async {
    return ErrorResult(id: command.id, error: "$e");
  }

  Future<RpcResult> _executeOTAGetInfoCommand(OTAGetInfoCommand command) async {
    return OTAGetInfoCommandResult(id: command.id, info: _info);
  }

  void _updateInfo(OTAInfo newValue) {
    _info = newValue;
    _frontendService.send(
      OTAGetInfoCommand(id: RpcCommand.generateId(), info: _info),
    );
  }

  Future<Response> _postOTAUploadPackage(Request request) async {
    String filename = '';
    int uploadedSize = 0;
    String code = '';

    final firmwareData = new io.BytesBuilder();
    var multiPartR = request.multipart();
    if (multiPartR == null /*!request.isMultipart*/ ) {
      _updateInfo(_info.copyWith(uploadingPercent: 0, status: OTAStatus.ready));
      return Response.ok('Not a multipart request');
    }

    var multipartFormData = request.formData();
    if ( /*!request.isMultipartForm*/ multipartFormData == null) {
      return Response.forbidden('Need multipart request');
    }
    _log.info('Parsed form multipart request');
    var fullSize = request.contentLength!;
    //200Mb
    if (fullSize > 200 * 1024 * 1024) {
      return Response.ok('Too big size');
    }
    _updateInfo(
      _info.copyWith(uploadingPercent: 0, status: OTAStatus.uploading),
    );
    await for (final formData
        in multipartFormData.formData /*request.multipartFormData*/ ) {
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
          _updateInfo(
            _info.copyWith(uploadingPercent: (uploadedSize / fullSize * 100)),
          );
        });
      }
    }
    _log.info('file size: ${firmwareData.length}');
    if (code != _code) {
      _updateInfo(_info.copyWith(uploadingPercent: 0, status: OTAStatus.ready));
      return Response.forbidden('Code error');
    }
    if (path.extension(filename) != '.deb') {
      _updateInfo(_info.copyWith(uploadingPercent: 0, status: OTAStatus.ready));
      return Response.forbidden('Support only deb package');
    }
    _updateInfo(
      _info.copyWith(uploadingPercent: 100, status: OTAStatus.uploading),
    );
    _processFirmware(filename, firmwareData.toBytes());
    return Response.ok('Firmware uploaded');
  }

  static const _uploadForm =
      """
<html>
<head>
<title>OTA</title>
</head>
<body>
<form method="post" enctype="multipart/form-data" action="ota_upload">
 <div>
    <p>v${ApplicationInfo.frontendVersion}</p> 
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
    _switchFrontendToSlideshowScreen();
    return Response.ok('Return to normal mode');
  }

  Future _switchFrontendToSlideshowScreen() {
    return _frontendService.send(
      OTAReadyCommand(id: RpcCommand.generateId(), ready: false),
    );
  }

  Future _switchFrontendToOTAScreen() {
    return _frontendService.send(
      OTAReadyCommand(id: RpcCommand.generateId(), ready: true),
    );
  }

  Response _getOTAStart(Request request) {
    if (_autostop != null && _autostop!.isActive) {
      _autostop!.cancel();
    }

    _switchFrontendToOTAScreen();
    if (request.url.queryParameters.isNotEmpty &&
        request.url.queryParameters['format'] == 'json') {
      return Response.ok(
        '{"version":{"frontend":"${ApplicationInfo.frontendVersion}","backend":"${ApplicationInfo.backendVersion}"},"status":"${_info.status.name}"}',
        headers: {'content-type': 'text/json; charset=utf-8'},
      );
    }
    return Response.ok(
      _uploadForm,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
  }

  void _processFirmware(String filename, io.Uint8List firmwareData) async {
    _log.info('_processFirmware "${filename}" [${firmwareData.length}]');
    if (!_folder.existsSync()) {
      await _folder.create();
    }
    final fullFilename = path.join(_folder.path, filename);
    await io.File(fullFilename).openWrite()
      ..add(firmwareData)
      ..close();

    _frontendService.send(
      OTAOutputCommand(
        id: RpcCommand.generateId(),
        output: '\n\rSave firmware to "$fullFilename"\n\r',
      ),
    );
    _updateInfo(
      _info.copyWith(uploadingPercent: 100, status: OTAStatus.instaling),
    );

    var process = await io.Process.start(
      'sudo',
      ['apt-get', '-f', '-y', 'install', '$fullFilename'],
      environment: {'LC_ALL': 'C', 'TERM': 'xterm-256color', 'COLUMNS': '120'},
    );
    process.stdout.cast<List<int>>().transform(utf8.decoder).listen((str) {
      _frontendService.send(
        OTAOutputCommand(id: RpcCommand.generateId(), output: str),
      );
    });
    process.stderr.cast<List<int>>().transform(utf8.decoder).listen((str) {
      _frontendService.send(
        OTAOutputCommand(id: RpcCommand.generateId(), output: str),
      );
    });
    var exitCode = await process.exitCode;
    _frontendService.send(
      OTAOutputCommand(
        id: RpcCommand.generateId(),
        output: '\n\rExit code: $exitCode',
      ),
    );
    _updateInfo(
      _info.copyWith(
        uploadingPercent: 100,
        exitCode: exitCode,
        status: exitCode == 0 ? OTAStatus.finished : OTAStatus.issue,
      ),
    );
    if (exitCode == 0) {
      Timer(const Duration(seconds: 5), () {
        _updateInfo(
          _info.copyWith(
            uploadingPercent: 100,
            exitCode: 0,
            status: OTAStatus.preReboot,
          ),
        );
        Timer(const Duration(seconds: 5), () {
          io.Process.start('sudo', ['service', 'dslideshow', 'restart']);
        });
      });
    }
  }

  Response _getOTAGetConfig(Request request) {
    return Response.ok(
      _downloadConfigForm,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
  }

  static const _downloadConfigForm =
      """
<html>
<head>
<title>OTA get config.json</title>
</head>
<body>
<form method="post" >
 <div>
    <p>v${ApplicationInfo.frontendVersion}</p>
    <p><b>OTA get config.json </b></p>
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
    var content = await request
        .readAsString(); //.transform(utf8.decoder).join();
    var queryParams = Uri(query: content).queryParameters;
    if (queryParams['code'] != _code) {
      return Response.forbidden('Incorrect code');
    }
    return Response.ok(
      io.File(config.fullConfigFilename).readAsStringSync(),
      headers: {'Content-Type': 'text/plain; charset=utf-8'},
    );
  }

  static const _uploadConfigForm =
      """
<html>
<head>
<title>OTA upload config.json</title>
</head>
<body>
<form method="post" enctype="multipart/form-data" >
 <div>
   <p>v${ApplicationInfo.frontendVersion}</p>
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
    return Response.ok(
      _uploadConfigForm,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
  }

  Future<Response> _postOTAUploadConfig(Request request) async {
    String code = '';
    String configData = '';
    var multipart = request.multipart();
    if (multipart == null /*!request.isMultipart*/ ) {
      return Response.ok('Not a multipart request');
    }
    var multipartForm = request.formData();
    if (multipartForm == null /*!request.isMultipartForm*/ ) {
      return Response.forbidden('Need multipart request');
    }
    _log.info('Parsed form multipart request');
    var fullSize = request.contentLength!;
    //200Mb
    if (fullSize > 20 * 1024 * 1024) {
      return Response.ok('Too big size');
    }

    await for (final formData
        in multipartForm.formData /*request.multipartFormData*/ ) {
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
      AppConfig.fromJson((json.decode(configData)) as Map<String, dynamic>);
      io.File(config.fullConfigFilename)
        ..openWrite()
        ..writeAsStringSync(configData);
    } catch (e, st) {
      _log.warning(
        "Parse & save config to '${config.fullConfigFilename}'",
        e,
        st,
      );
      return Response.forbidden('Error: $e');
    }
    _log.info('Config updated');
    return Response.ok('Config updated');
  }
}
