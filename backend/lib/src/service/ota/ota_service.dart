import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dslideshow_backend/src/service/ota/ota_config_transfer.dart';
import 'package:dslideshow_backend/src/service/ota/ota_download_config_page.dart';
import 'package:dslideshow_backend/src/service/ota/ota_installer.dart';
import 'package:dslideshow_backend/src/service/ota/ota_page.dart';
import 'package:dslideshow_backend/src/service/ota/ota_page_localizations.dart';
import 'package:dslideshow_backend/src/service/ota/ota_upload_config_page.dart';
import 'package:dslideshow_backend/src/service/ota/ota_upload_page.dart';
import 'package:dslideshow_backend/src/service/ota/ota_upload_script.dart';
import 'package:dslideshow_backend/src/service/ota/release_info.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/env/default.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf/shelf.dart';
import 'package:path/path.dart' as path;

class OTAService implements RpcService {
  static final Logger _log = new Logger('OTAService');
  String _code = _generateCode();
  String get code => _code;

  final io.Directory _folder;
  final FirmwareInstaller _installer;
  final StreamingUploadReceiver _uploadReceiver;
  final OtaConfigTransfer _configTransfer;
  final Future<ReleaseInfo?> Function()? _latestRelease;
  final io.HttpClient Function() _downloadClientFactory;
  final int _port;
  final Duration _restartDelay;
  final Duration _autostopDelay;
  final Duration _networkTimeout;
  final bool _automaticallyStartServer;
  final Set<io.HttpClient> _clients = {};
  final Set<void Function()> _closeListeners = {};
  _OTAOperation? _operation;
  bool get busy => _operation != null;
  OTAInfo get info => _info;
  Handler get handler => _handleRequest;
  bool _closed = false;
  bool _disableWhenIdle = false;
  Future<void> _serverChanges = Future<void>.value();
  Timer? _initialCheck;
  Timer? _periodicCheck;
  Timer? _restartTimer;
  bool _notificationInFlight = false;
  OTAGetInfoCommand? _pendingInfo;
  final BytesBuilder _pendingOutput = BytesBuilder(copy: false);
  _QueuedScreen? _pendingScreen;
  _QueuedScreen? _activeScreen;
  bool _outputTruncatedWithoutOperation = false;
  static const _maxPendingOutputBytes = 64 * 1024;
  static final math.Random _rnd = math.Random();

  bool _enabled = false;
  bool get enabled => _enabled;
  int? get boundPort => _server?.port;

  OTAInfo _info = OTAInfo(status: OTAStatus.disabled, code: "-", uploadingPercent: 0);

  void set enabled(bool newvalue) {
    unawaited(_setEnabled(newvalue));
  }

  Router _router = Router();
  Timer? _autostop;
  final AppConfig config;
  final RemoteService _frontendService;

  OTAService({
    required this.config,
    required RemoteService frontendService,
    bool startServer = true,
    io.Directory? firmwareDirectory,
    FirmwareInstaller? installer,
    StreamingUploadReceiver? uploadReceiver,
    StreamingUploadReceiver? configUploadReceiver,
    Future<ReleaseInfo?> Function()? latestRelease,
    io.HttpClient Function()? downloadClientFactory,
    int port = 8282,
    Duration restartDelay = const Duration(seconds: 5),
    Duration autostopDelay = const Duration(minutes: 5),
    Duration networkTimeout = const Duration(seconds: 60),
  }) : _frontendService = frontendService,
       _folder = firmwareDirectory ?? io.Directory(path.join(externalStorage.path, 'firmwares')),
       _installer = installer ?? const ProcessFirmwareInstaller(),
       _uploadReceiver =
           uploadReceiver ?? StreamingUploadReceiver(limits: const UploadLimits(maxFiles: 1, maxParts: 2)),
       _configTransfer = OtaConfigTransfer(filename: config.fullConfigFilename, uploadReceiver: configUploadReceiver),
       _latestRelease = latestRelease,
       _downloadClientFactory = downloadClientFactory ?? io.HttpClient.new,
       _port = port,
       _restartDelay = restartDelay,
       _autostopDelay = autostopDelay,
       _networkTimeout = networkTimeout,
       _automaticallyStartServer = startServer {
    _router.get('/ota_start', _getOTAStart);
    _router.get('/ota_stop', _getOTAStop);
    _router.get('/ota_download_config', _getOTAGetConfig);
    _router.post('/ota_download_config', _postOTAGetConfig);
    _router.get('/ota_upload_config', _getOTAUploadConfig);
    _router.post('/ota_upload_config', _postOTAUploadConfig);
    _router.post('/ota_upload', _postOTAUploadPackage);

    _info = _info.copyWith(code: code);
    if (startServer) {
      unawaited(_setEnabled(true));
    }
  }

  Future<void> _setEnabled(bool value) async {
    try {
      if (value || config.ota.alwaysEnabled) {
        await start();
      } else {
        await stop();
      }
    } catch (e, st) {
      if (!_closed) _recordFailure(e, st);
    }
  }

  /// Own the release lookup as well as its download, so scheduled checks and
  /// manual uploads cannot each start an installation.
  Future<void> checkLatestRelease() async {
    if (_closed || busy) return;
    final operation = _beginOperation();
    StagedUploadFile? staged;
    io.HttpClient? client;
    try {
      _log.info('Checking new version...');
      final releaseInfo = await _untilClosed(
        (_latestRelease?.call() ?? _fetchLatestDebRelease()).timeout(_networkTimeout),
      );
      _checkOpen(operation);
      if (releaseInfo == null) return;
      final currentVersion = Version.parse(ApplicationInfo.frontendVersion);
      if (currentVersion >= releaseInfo.version) {
        _log.info('The current version "${ApplicationInfo.frontendVersion}" is the latest');
        return;
      }
      if (!enabled && _automaticallyStartServer) await start();
      _checkOpen(operation);
      await _untilClosed(_requestScreen(true));
      _beginUpload(operation);
      _output("Try to download new version '${releaseInfo.version}'\n\r");
      final debUri = Uri.parse(releaseInfo.debUrl);
      final filename = path.basename(Uri.decodeFull(releaseInfo.debUrl));
      if (path.extension(filename) != '.deb') {
        throw UploadFailure(415, 'Support only deb package');
      }
      client = _createHttpClient();
      final request = await _network(client.getUrl(debUri));
      request.headers.add('User-Agent', 'dslideshow-flutter-app');
      final response = await _network(request.close());
      if (response.statusCode != io.HttpStatus.ok) {
        throw io.HttpException('Download failed: HTTP ${response.statusCode}');
      }
      await _folder.create(recursive: true);
      staged = await _uploadReceiver.receiveStream(
        response,
        filename: filename,
        destination: path.join(_folder.path, filename),
        contentLength: response.contentLength < 0 ? null : response.contentLength,
        cancellation: operation.cancellation,
        onProgress: (received, total) => _uploadProgress(operation, received, total),
      );
      await _acceptFirmware(operation, staged);
    } catch (e, st) {
      if (!_closed) _recordFailure(e, st);
    } finally {
      await staged?.cleanup();
      if (client != null) _closeClient(client);
      _finishInput(operation);
    }
  }

  Future<ReleaseInfo?> _fetchLatestDebRelease() async {
    final url = Uri.parse('https://api.github.com/repos/DisDis/dslideshow/releases/latest');
    final client = _createHttpClient();
    try {
      final request = await _network(client.getUrl(url));
      request.headers.set('User-Agent', 'Flutter-App');
      request.headers.set('Accept', 'application/vnd.github.v3+json');
      final response = await _network(request.close());

      if (response.statusCode != 200) {
        _log.warning('Ошибка получения релиза: ${response.statusCode}');
        return null;
      }

      final body = await _network(utf8.decoder.bind(response).join());
      final releaseData = json.decode(body) as Map<String, dynamic>;
      return parseReleaseData(releaseData);
    } finally {
      _closeClient(client);
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
    final cleanVersion = tagName.startsWith('v') ? tagName.substring(1) : tagName;

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
    } catch (e, stack) {
      _log.warning('Ошибка парсинга версии $cleanVersion: $e', e, stack);
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
    _log.info('OTA access code updated');
  }

  io.HttpServer? _server;

  Future<void> start() => _changeServer(true);

  Future<void> _changeServer(bool value) {
    final change = _serverChanges.then((_) async {
      if (_closed) {
        if (value) throw StateError('OTA service is closed');
        return;
      }
      if (value) {
        _disableWhenIdle = false;
        _enabled = true;
        if (_server == null) {
          try {
            await _startWebServer();
          } catch (_) {
            _enabled = false;
            rethrow;
          }
        }
      } else if (!config.ota.alwaysEnabled) {
        if (busy) {
          _disableWhenIdle = true;
          return;
        }
        _enabled = false;
        _autostop?.cancel();
        final server = _server;
        _server = null;
        await server?.close(force: true);
        if (!_closed && !busy) _updateInfo(_info.copyWith(status: OTAStatus.disabled));
      }
    });
    // Retain the original error for the caller without poisoning the next
    // lifecycle request or leaving a failed queue future unobserved.
    _serverChanges = change.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return change;
  }

  Future<void> _startWebServer() async {
    final server = await shelf_io.serve(handler, '0.0.0.0', _port);
    if (_closed || !_enabled) {
      await server.close(force: true);
      return;
    }
    _server = server;
    server.autoCompress = true;
    if (!busy) _updateInfo(_info.copyWith(status: OTAStatus.ready, errorText: null, exitCode: null));
    _autostop?.cancel();
    _autostop = Timer(_autostopDelay, () => unawaited(_setEnabled(false)));
    if (config.ota.autoUpdateEnabled && _periodicCheck == null) {
      _initialCheck = Timer(const Duration(seconds: 30), () {
        unawaited(checkLatestRelease());
      });
      _periodicCheck = Timer.periodic(const Duration(hours: 1), (_) {
        unawaited(checkLatestRelease());
      });
    }
    _log.info('Serving at http://${server.address.host}:${server.port}');
  }

  Future<void> stop() => _changeServer(false);

  /// Cancel incoming transfers and timers. An already running package manager
  /// is allowed to finish; closing never kills apt and never schedules a restart.
  Future<void> close() async {
    _closed = true;
    _enabled = false;
    for (final listener in _closeListeners.toList()) {
      listener();
    }
    _closeListeners.clear();
    _completeScreen(_activeScreen, const UploadFailure(503, 'OTA service is closed'));
    _completeScreen(_pendingScreen, const UploadFailure(503, 'OTA service is closed'));
    _pendingScreen = null;
    _pendingInfo = null;
    _pendingOutput.clear();
    _autostop?.cancel();
    _initialCheck?.cancel();
    _periodicCheck?.cancel();
    _restartTimer?.cancel();
    final operation = _operation;
    operation?.cancellation.cancel('OTA service closed');
    for (final client in _clients.toList()) {
      _closeClient(client);
    }
    await _serverChanges;
    final server = _server;
    _server = null;
    await server?.close(force: true);
    await operation?.inputFinished.future;
    _operation = null;
    _info = _info.copyWith(status: OTAStatus.disabled);
  }

  _OTAOperation _beginOperation() {
    final operation = _OTAOperation();
    _operation = operation;
    return operation;
  }

  void _checkOpen(_OTAOperation operation) {
    if (_closed || !identical(_operation, operation)) {
      throw UploadFailure(503, 'OTA service is closed');
    }
  }

  Future<T> _network<T>(Future<T> future) => _untilClosed(future.timeout(_networkTimeout));

  Future<T> _untilClosed<T>(Future<T> future) {
    final result = Completer<T>();
    void closed() {
      if (!result.isCompleted) result.completeError(const UploadFailure(503, 'OTA service is closed'));
    }

    if (_closed) {
      closed();
    } else {
      _closeListeners.add(closed);
    }
    future.then<void>(
      (value) {
        _closeListeners.remove(closed);
        if (!result.isCompleted) result.complete(value);
      },
      onError: (Object error, StackTrace stack) {
        _closeListeners.remove(closed);
        if (!result.isCompleted) result.completeError(error, stack);
      },
    );
    return result.future;
  }

  io.HttpClient _createHttpClient() {
    final client = _downloadClientFactory();
    client.connectionTimeout = const Duration(seconds: 60);
    client.idleTimeout = const Duration(seconds: 60);
    _clients.add(client);
    return client;
  }

  void _closeClient(io.HttpClient client) {
    _clients.remove(client);
    client.close(force: true);
  }

  void _beginUpload(_OTAOperation operation) {
    _checkOpen(operation);
    operation.uploading = true;
    operation.progressWatch.start();
    _updateInfo(_info.copyWith(uploadingPercent: 0, exitCode: null, errorText: null, status: OTAStatus.uploading));
  }

  void _uploadProgress(_OTAOperation operation, int received, int? total) {
    if (_closed || !identical(_operation, operation) || !operation.uploading) return;
    final elapsed = operation.progressWatch.elapsedMicroseconds;
    if (elapsed - operation.lastProgressMicros < 250000) return;
    final percent = total != null && total > 0 ? (received / total * 100).clamp(0.0, 99.0).toDouble() : 0.0;
    if (percent == _info.uploadingPercent) return;
    operation.lastProgressMicros = elapsed;
    _updateInfo(_info.copyWith(uploadingPercent: percent));
  }

  void _finishInput(_OTAOperation operation) {
    if (!operation.inputFinished.isCompleted) operation.inputFinished.complete();
    if (!operation.accepted || operation.releaseAfterInput) _releaseOperation(operation);
  }

  void _releaseOperation(_OTAOperation operation) {
    if (!identical(_operation, operation)) return;
    if (!operation.inputFinished.isCompleted) {
      operation.releaseAfterInput = true;
      return;
    }
    _operation = null;
    if (_disableWhenIdle && !_closed) unawaited(_setEnabled(false));
  }

  void _recordFailure(Object error, StackTrace stackTrace) {
    _log.warning('OTA operation failed type=${error.runtimeType}', error, stackTrace);
    _updateInfo(_info.copyWith(status: OTAStatus.issue, errorText: '$error', exitCode: null));
  }

  void _output(String output) {
    _notify(OTAOutputCommand(id: RpcCommand.generateId(), output: output));
  }

  void _notify(RpcCommand command) {
    if (_closed) return;
    if (command is OTAGetInfoCommand) {
      _pendingInfo = command;
    } else if (command is OTAOutputCommand) {
      final bytes = utf8.encode(command.output);
      final remaining = _maxPendingOutputBytes - _pendingOutput.length;
      if (remaining > 0) {
        _pendingOutput.add(bytes.length <= remaining ? bytes : bytes.sublist(0, remaining));
      }
      if (bytes.length > remaining) {
        final operation = _operation;
        if (!(operation?.outputTruncated ?? _outputTruncatedWithoutOperation)) {
          _log.warning('OTA frontend output queue full; truncating pending output');
          if (operation != null) {
            operation.outputTruncated = true;
          } else {
            _outputTruncatedWithoutOperation = true;
          }
        }
      }
    }
    _drainNotifications();
  }

  _QueuedScreen _queueScreen(bool ready) {
    final pending = _pendingScreen;
    if (pending?.command.ready == ready) return pending!;
    _completeScreen(pending, const UploadFailure(409, 'OTA screen request superseded'));
    _pendingScreen = null;
    final active = _activeScreen;
    if (active?.command.ready == ready) return active!;
    final screen = _QueuedScreen(OTAReadyCommand(id: RpcCommand.generateId(), ready: ready));
    if (_closed) {
      _completeScreen(screen, const UploadFailure(503, 'OTA service is closed'));
    } else {
      _pendingScreen = screen;
      _drainNotifications();
    }
    return screen;
  }

  Future<void> _requestScreen(bool ready) {
    final screen = _queueScreen(ready);
    if (screen.completed) {
      return screen.error == null ? Future<void>.value() : Future<void>.error(screen.error!);
    }
    final waiter = Completer<void>();
    screen.waiters.add(waiter);
    return waiter.future;
  }

  void _completeScreen(_QueuedScreen? screen, [Object? error, StackTrace? stack]) {
    if (screen == null || screen.completed) return;
    screen.completed = true;
    screen.error = error;
    for (final waiter in screen.waiters) {
      if (error == null) {
        waiter.complete();
      } else {
        waiter.completeError(error, stack);
      }
    }
    screen.waiters.clear();
  }

  /// Applies flow control to installer output and progress notifications.
  /// Progress coalesces to the latest state; output has a fixed memory budget.
  void _drainNotifications() {
    if (_closed || _notificationInFlight) return;
    RpcCommand command;
    final screen = _pendingScreen;
    if (screen != null) {
      _pendingScreen = null;
      _activeScreen = screen;
      command = screen.command;
    } else if (_pendingInfo != null) {
      command = _pendingInfo!;
      _pendingInfo = null;
    } else if (_pendingOutput.isNotEmpty) {
      command = OTAOutputCommand(
        id: RpcCommand.generateId(),
        output: utf8.decode(_pendingOutput.takeBytes(), allowMalformed: true),
      );
    } else {
      return;
    }
    _notificationInFlight = true;
    Future<RpcResult>.sync(() => _frontendService.send(command))
        .then<void>(
          (_) {
            _completeScreen(screen);
          },
          onError: (Object error, StackTrace stack) {
            _log.log(
              _closed ? Level.FINE : Level.WARNING,
              'OTA frontend notification ${_closed ? 'cancelled' : 'failed'} type=${error.runtimeType}',
              error,
              stack,
            );
            _completeScreen(screen, error, stack);
          },
        )
        .whenComplete(() {
          if (screen != null && identical(_activeScreen, screen)) _activeScreen = null;
          _notificationInFlight = false;
          _drainNotifications();
        });
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    switch (command.type) {
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      case OTAGetInfoCommand.TYPE:
        return _executeOTAGetInfoCommand(command as OTAGetInfoCommand);
      default:
        return _generateErrorResult(new Exception("Unknown command: ${command.type}"), command);
    }
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return new EchoCommandResult(id: command.id, resultText: "${command.text} Service ${new DateTime.now()}");
  }

  Future<RpcErrorResult> _generateErrorResult(Object e, RpcCommand command) async {
    return ErrorResult(id: command.id, error: "$e");
  }

  Future<RpcResult> _executeOTAGetInfoCommand(OTAGetInfoCommand command) async {
    return OTAGetInfoCommandResult(id: command.id, info: _info);
  }

  void _updateInfo(OTAInfo newValue) {
    if (_closed) return;
    _info = newValue;
    _notify(OTAGetInfoCommand(id: RpcCommand.generateId(), info: _info));
  }

  Future<Response> _handleRequest(Request request) async {
    if (_closed) return _failureResponse(request, const UploadFailure(503, 'OTA service is closed'));
    try {
      return await _router.call(request);
    } catch (error, stack) {
      _log.warning('OTA HTTP request failed', error, stack);
      return _failureResponse(request, uploadFailureFor(error));
    }
  }

  static const _responseHeaders = {'cache-control': 'no-store', 'x-content-type-options': 'nosniff'};
  static const _htmlHeaders = {
    ..._responseHeaders,
    'content-type': 'text/html; charset=utf-8',
    'content-security-policy':
        "default-src 'none'; style-src 'unsafe-inline'; form-action 'self'; base-uri 'none'; frame-ancestors 'none'",
  };
  static final _uploadHtmlHeaders = {
    ..._htmlHeaders,
    'content-security-policy': "${_htmlHeaders['content-security-policy']}; script-src '$otaUploadScriptHash'",
  };

  OtaPageLanguage _language(Request request) => otaPageLanguage(request.headers['accept-language']);

  OtaPageLocalizations _strings(Request request) => OtaPageLocalizations(_language(request));

  bool _wantsHtml(Request request) {
    for (final value in (request.headers['accept'] ?? '').split(',')) {
      try {
        final type = io.HeaderValue.parse(value);
        if (type.value.toLowerCase() == 'text/html' && (double.tryParse(type.parameters['q'] ?? '1') ?? 0) > 0)
          return true;
      } on FormatException {
        // An invalid Accept value must not prevent recovery through plain HTTP.
      }
    }
    return false;
  }

  Response _resultResponse(
    Request request, {
    int statusCode = 200,
    required String text,
    required String title,
    required String message,
    bool showCancel = true,
  }) {
    if (!_wantsHtml(request)) {
      return Response(
        statusCode,
        body: text,
        headers: {..._responseHeaders, 'content-type': 'text/plain; charset=utf-8'},
      );
    }
    return Response(
      statusCode,
      body: renderOtaResultPage(
        frontendVersion: ApplicationInfo.frontendVersion,
        backendVersion: ApplicationInfo.backendVersion,
        language: _language(request),
        title: title,
        message: message,
        error: statusCode >= 400,
        showCancel: showCancel,
      ),
      headers: _htmlHeaders,
    );
  }

  Response _failureResponse(
    Request request,
    UploadFailure failure, {
    _OtaTransferKind kind = _OtaTransferKind.firmware,
  }) {
    final strings = _strings(request);
    final message = switch (failure.statusCode) {
      400 => kind == _OtaTransferKind.configImport ? strings.invalidConfig : strings.invalidRequest,
      403 => strings.invalidCode,
      404 => strings.configUnavailable,
      408 => strings.transferTimedOut,
      409 => strings.operationBusy,
      413 => strings.transferTooLarge,
      415 => strings.unsupportedFirmware,
      503 => strings.serviceUnavailable,
      507 => strings.insufficientStorage,
      500 when kind == _OtaTransferKind.configExport => strings.configUnavailable,
      _ => strings.transferFailed,
    };
    return _resultResponse(
      request,
      statusCode: failure.statusCode,
      text: failure.message,
      title: strings.errorTitle,
      message: message,
    );
  }

  void _keepWebSession() => _autostop?.cancel();

  Future<Response> _postOTAUploadPackage(Request request) async {
    if (busy) return _failureResponse(request, const UploadFailure(409, 'An OTA operation is already active'));
    final operation = _beginOperation();
    StagedUploadBatch? batch;
    var authorized = false;
    try {
      batch = await _uploadReceiver.receiveMultipart(
        request,
        cancellation: operation.cancellation,
        rejectionPolicy: request.canHijack ? UploadRejectionPolicy.drain : UploadRejectionPolicy.cancel,
        onField: (name, value) {
          if (name != 'code' || authorized) {
            throw UploadFailure(400, 'Expected one code field before the file');
          }
          if (value != _code) throw UploadFailure(403, 'Code error');
          authorized = true;
        },
        beforeFile: (filename) {
          if (!authorized) throw UploadFailure(403, 'Code must precede the file');
          if (operation.uploading) throw UploadFailure(400, 'Expected one firmware file');
          if (path.extension(filename) != '.deb') {
            throw UploadFailure(415, 'Support only deb package');
          }
          _beginUpload(operation);
        },
        destinationFor: (filename) async {
          await _folder.create(recursive: true);
          return path.join(_folder.path, filename);
        },
        onProgress: (received, total) => _uploadProgress(operation, received, total),
      );
      if (!authorized || batch.files.length != 1) {
        throw UploadFailure(400, 'Expected a code and one firmware file');
      }
      await _acceptFirmware(operation, batch.files.single);
      final strings = _strings(request);
      return _resultResponse(
        request,
        text: 'Firmware uploaded; installation accepted',
        title: strings.firmwareAcceptedTitle,
        message: strings.firmwareAcceptedMessage,
        showCancel: false,
      );
    } catch (e, st) {
      if (!_closed && operation.uploading) _recordFailure(e, st);
      final failure = uploadFailureFor(e);
      return _failureResponse(request, failure);
    } finally {
      await batch?.cleanup();
      _finishInput(operation);
    }
  }

  Response _getOTAStop(Request request) {
    _queueScreen(false);
    final strings = _strings(request);
    return _resultResponse(
      request,
      text: 'Return to normal mode',
      title: strings.slideshowTitle,
      message: strings.slideshowMessage,
      showCancel: false,
    );
  }

  Response _getOTAStart(Request request) {
    _keepWebSession();
    _queueScreen(true);
    if (request.url.queryParameters.isNotEmpty && request.url.queryParameters['format'] == 'json') {
      return Response.ok(
        '{"version":{"frontend":"${ApplicationInfo.frontendVersion}","backend":"${ApplicationInfo.backendVersion}"},"status":"${_info.status.name}"}',
        headers: {..._responseHeaders, 'content-type': 'text/json; charset=utf-8'},
      );
    }
    return Response.ok(
      renderOtaUploadPage(
        frontendVersion: ApplicationInfo.frontendVersion,
        backendVersion: ApplicationInfo.backendVersion,
        language: _language(request),
        busy: busy,
      ),
      headers: _uploadHtmlHeaders,
    );
  }

  Future<void> _acceptFirmware(_OTAOperation operation, StagedUploadFile staged) async {
    _checkOpen(operation);
    if (await staged.temporary.length() == 0) {
      throw UploadFailure(400, 'Firmware file is empty');
    }
    final package = await staged.publish();
    _checkOpen(operation);
    _output('\n\rSave firmware to "${package.path}"\n\r');
    _updateInfo(_info.copyWith(uploadingPercent: 100));
    operation.accepted = true;
    unawaited(_installFirmware(operation, package));
  }

  Future<void> _installFirmware(_OTAOperation operation, io.File package) async {
    var awaitingRestart = false;
    try {
      _updateInfo(_info.copyWith(uploadingPercent: 100, status: OTAStatus.instaling));
      final exitCode = await _installer.install(
        package,
        onOutput: (output) {
          if (!_closed) _output(output);
        },
      );
      if (_closed) return;
      _output('\n\rExit code: $exitCode');
      _updateInfo(
        _info.copyWith(
          uploadingPercent: 100,
          exitCode: exitCode,
          errorText: exitCode == 0 ? null : 'Installer exited with code $exitCode',
          status: exitCode == 0 ? OTAStatus.finished : OTAStatus.issue,
        ),
      );
      if (exitCode == 0) {
        awaitingRestart = true;
        _restartTimer = Timer(_restartDelay, () {
          if (_closed) return;
          _updateInfo(_info.copyWith(status: OTAStatus.preReboot));
          _restartTimer = Timer(_restartDelay, () {
            unawaited(_restart(operation));
          });
        });
      }
    } catch (e, st) {
      if (!_closed) _recordFailure(e, st);
    } finally {
      if (!awaitingRestart) _releaseOperation(operation);
    }
  }

  Future<void> _restart(_OTAOperation operation) async {
    try {
      if (!_closed) await _installer.restart();
    } catch (e, st) {
      if (!_closed) _recordFailure(e, st);
    } finally {
      _releaseOperation(operation);
    }
  }

  Response _getOTAGetConfig(Request request) {
    _keepWebSession();
    return Response.ok(
      renderOtaDownloadConfigPage(
        frontendVersion: ApplicationInfo.frontendVersion,
        backendVersion: ApplicationInfo.backendVersion,
        language: _language(request),
        busy: busy,
      ),
      headers: _htmlHeaders,
    );
  }

  Future<String> _readConfigDownloadCode(Request request) async {
    const maxBytes = 8 * 1024;
    if ((request.contentLength ?? 0) > maxBytes) {
      throw const UploadFailure(413, 'Form exceeds size limit');
    }
    final body = BytesBuilder(copy: false);
    final input = StreamIterator(request.read());
    final watch = Stopwatch()..start();
    try {
      while (true) {
        final remaining = _networkTimeout - watch.elapsed;
        if (remaining <= Duration.zero) throw const UploadFailure(408, 'Request timed out');
        if (!await _untilClosed(input.moveNext().timeout(remaining))) break;
        if (body.length + input.current.length > maxBytes) {
          throw const UploadFailure(413, 'Form exceeds size limit');
        }
        body.add(input.current);
      }
      final values = Uri(query: utf8.decode(body.takeBytes())).queryParametersAll;
      if (values.length != 1 || values['code']?.length != 1) {
        throw const UploadFailure(400, 'Expected one code field');
      }
      return values['code']!.single;
    } on FormatException {
      throw const UploadFailure(400, 'Invalid form data');
    } finally {
      // Closing HTTP must not wait for an unresponsive request body's onCancel.
      unawaited(input.cancel().catchError((Object _) {}));
    }
  }

  Future<Response> _postOTAGetConfig(Request request) async {
    try {
      if (await _readConfigDownloadCode(request) != _code) {
        throw const UploadFailure(403, 'Incorrect code');
      }
      final bytes = await _untilClosed(_configTransfer.download());
      return Response.ok(
        bytes,
        headers: {
          ..._responseHeaders,
          'content-type': 'application/json',
          'content-disposition': 'attachment; filename="config.json"',
        },
      );
    } catch (error) {
      return _failureResponse(request, uploadFailureFor(error), kind: _OtaTransferKind.configExport);
    }
  }

  Response _getOTAUploadConfig(Request request) {
    _keepWebSession();
    return Response.ok(
      renderOtaUploadConfigPage(
        frontendVersion: ApplicationInfo.frontendVersion,
        backendVersion: ApplicationInfo.backendVersion,
        language: _language(request),
        busy: busy,
      ),
      headers: _htmlHeaders,
    );
  }

  Future<Response> _postOTAUploadConfig(Request request) async {
    if (busy) return _failureResponse(request, const UploadFailure(409, 'An OTA operation is already active'));
    final operation = _beginOperation();
    try {
      await _configTransfer.upload(request, code: _code, cancellation: operation.cancellation);
      _checkOpen(operation);
      final strings = _strings(request);
      return _resultResponse(
        request,
        text: 'Config updated',
        title: strings.configSavedTitle,
        message: strings.configSavedMessage,
      );
    } catch (error, stack) {
      final failure = uploadFailureFor(error);
      if (failure.statusCode >= 500 && !_closed) _log.warning('Could not import OTA configuration', error, stack);
      return _failureResponse(request, failure, kind: _OtaTransferKind.configImport);
    } finally {
      _finishInput(operation);
    }
  }
}

enum _OtaTransferKind { firmware, configImport, configExport }

class _OTAOperation {
  final UploadCancellationToken cancellation = UploadCancellationToken();
  final Completer<void> inputFinished = Completer<void>();
  final Stopwatch progressWatch = Stopwatch();
  int lastProgressMicros = 0;
  bool uploading = false;
  bool accepted = false;
  bool releaseAfterInput = false;
  bool outputTruncated = false;
}

class _QueuedScreen {
  final OTAReadyCommand command;
  final Set<Completer<void>> waiters = {};
  bool completed = false;
  Object? error;

  _QueuedScreen(this.command);
}
