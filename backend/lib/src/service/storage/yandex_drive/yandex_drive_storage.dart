import 'dart:async';

import 'package:dslideshow_common/file_settings.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import '../../../../app_storage.dart';
import '../../../command/drive_command.dart';
import '../../yandex_drive/yandex_drive_api.dart' show YandexDriveDownload;
import '../../yandex_drive/yandex_drive_models.dart';
import '../../yandex_drive/yandex_drive_paths.dart';
import '../../yandex_drive/yandex_drive_service.dart';
import '../cloud_storage.dart';
import '../cloud_storage_transfer.dart';
import '../storages_config.dart' as storage_config show StorageType;
import 'yandex_drive_storage_config.dart';

class YandexDriveStorage extends CloudStorage {
  YandexDriveStorage(
    this.config,
    YandexDriveService connections,
    this.appStorage, {
    super.folder,
    super.hidden,
    DateTime Function()? now,
  }) : _connections = connections,
       _now = now ?? DateTime.now,
       super(config) {
    _runtime = DriveRuntime(lastSync: _readLastSync());
  }

  static final _log = Logger('YandexDriveStorage');
  static const _lastSyncKey = 'YandexDrive.lastSync';
  final YandexDriveStorageConfig config;
  final YandexDriveService _connections;
  final AppStorage appStorage;
  final DateTime Function() _now;
  late DriveRuntime _runtime;
  final _started = StreamController<DateTime>.broadcast();
  final _ended = StreamController<DateTime>.broadcast();
  Timer? _timer;
  Future<void>? _sync;
  bool _closed = false;

  @override
  Stream<DateTime> get onStartSync => _started.stream;
  @override
  Stream<DateTime> get onEndSync => _ended.stream;
  @override
  DateTime get lastSync => _runtime.lastSync ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  DriveRuntime get runtime => _runtime;

  DateTime? _readLastSync() {
    final value = appStorage.getRaw(_lastSyncKey);
    return value is String ? DateTime.tryParse(value) : null;
  }

  @override
  Future<void> init() async {
    if (_closed) return;
    await folder.create(recursive: true);
    if (_closed) return;
    await super.init();
    if (_closed) return;
    _runtime = _runtime.copyWith(active: true);
    _scheduleNext();
    _log.info('Storage initialized accounts=${config.accounts.where((account) => account.enabled).length}');
  }

  void _scheduleNext({Duration? delay}) {
    _timer?.cancel();
    _timer = null;
    if (_closed || !_runtime.active || _runtime.paused || _sync != null) return;
    final previous = _runtime.lastSync;
    final requestedDelay =
        delay ?? (previous == null ? Duration.zero : config.syncPeriod - _now().toUtc().difference(previous));
    // RTC/NTP correction cannot accelerate an already scheduled monotonic timer.
    final remaining = requestedDelay > config.syncPeriod ? config.syncPeriod : requestedDelay;
    if (remaining <= Duration.zero) {
      _start();
    } else {
      _timer = Timer(remaining, () {
        _timer = null;
        _start();
      });
    }
  }

  void _start() {
    if (_closed || !_runtime.active || _runtime.paused || _sync != null) return;
    _timer?.cancel();
    _timer = null;
    final operation = _performSync();
    _sync = operation;
    unawaited(
      operation.then((_) {
        _sync = null;
        _scheduleNext(delay: config.syncPeriod);
      }),
    );
  }

  void syncNow() {
    if (_closed || !_runtime.active) throw const CloudStorageException(DriveFailure.notActive);
    if (_runtime.paused) throw const CloudStorageException(DriveFailure.busy);
    _start();
  }

  void setPaused(bool value) {
    if (_closed || !_runtime.active) throw const CloudStorageException(DriveFailure.notActive);
    _runtime = _runtime.copyWith(paused: value);
    if (value) {
      _timer?.cancel();
      _timer = null;
    } else {
      _scheduleNext();
    }
    _log.info('Synchronization ${value ? 'paused' : 'resumed'}');
  }

  @override
  Future<Null> sync() async {
    if (_closed || !_runtime.active) throw const CloudStorageException(DriveFailure.notActive);
    _start();
    await _sync;
    return null;
  }

  @override
  Future<DriveResult> executeDriveCommand(DriveCommand command) async {
    DriveState state() => _connections.state(runtime: _runtime);
    if (_closed) return DriveResult(id: command.id, state: state(), error: DriveFailure.notActive);
    if (command.provider != storage_config.StorageType.YandexDriveStorage) {
      return DriveResult(id: command.id, state: state(), error: DriveFailure.invalidRequest);
    }
    try {
      DriveAuthorization? authorization;
      DriveFolderPage? folderPage;
      switch (command.action) {
        case DriveAction.state:
          break;
        case DriveAction.configureApplication:
          _connections.configureApplication(command.clientId ?? '', command.clientSecret);
          break;
        case DriveAction.startAuthorization:
          authorization = await _connections.startAuthorization();
          break;
        case DriveAction.authorization:
          authorization = _connections.authorization(command.sessionId ?? '');
          break;
        case DriveAction.cancelAuthorization:
          authorization = _connections.cancelAuthorization(command.sessionId ?? '');
          break;
        case DriveAction.disconnectAccount:
          _connections.disconnect(command.accountId ?? '');
          break;
        case DriveAction.folders:
          folderPage = await _connections.folders(command.accountId ?? '', command.path ?? 'disk:/', command.offset);
          break;
        case DriveAction.syncNow:
          syncNow();
          break;
        case DriveAction.setPaused:
          if (command.paused == null) throw const CloudStorageException(DriveFailure.invalidRequest);
          setPaused(command.paused!);
          break;
        case DriveAction.unknown:
          throw const CloudStorageException(DriveFailure.invalidRequest);
      }
      return DriveResult(id: command.id, state: state(), authorization: authorization, folderPage: folderPage);
    } catch (error) {
      final failure = YandexDriveService.failureCode(error);
      _log.log(
        failure == DriveFailure.cancelled ? Level.FINE : Level.WARNING,
        'Drive action failed action=${command.action.name} reason=${failure.name}',
      );
      return DriveResult(id: command.id, state: state(), error: failure);
    }
  }

  Future<void> _performSync() async {
    final started = _now().toUtc();
    _runtime = _runtime.copyWith(running: true, downloaded: 0, skipped: 0, failed: 0, error: null);
    _started.add(started);
    var stopped = false;
    _log.info('Synchronization started accounts=${config.accounts.where((account) => account.enabled).length}');
    try {
      final seenAccounts = <String>{};
      for (final account in config.accounts) {
        if (_closed || _runtime.paused) {
          stopped = true;
          break;
        }
        if (!account.enabled || !seenAccounts.add(account.accountId)) continue;
        try {
          if (!YandexDrivePaths.validAccountId(account.accountId))
            throw const CloudStorageException(DriveFailure.invalidRequest);
          if (!_connections.isConnected(account.accountId)) continue;
          for (final selected in YandexDrivePaths.distinctRoots(account.paths)) {
            if (!await _walk(account.accountId, selected, 0) || !_canContinue(account.accountId)) {
              stopped = true;
              break;
            }
          }
          if (stopped) break;
        } catch (error) {
          if (!_canContinue(account.accountId)) {
            stopped = true;
            break;
          }
          final reason = YandexDriveService.failureCode(error);
          _runtime = _runtime.copyWith(failed: _runtime.failed + 1, error: reason);
          _log.warning('Account synchronization failed reason=${reason.name}');
        }
      }
      if (!_closed && !stopped && _runtime.failed == 0) {
        final completed = _now().toUtc();
        appStorage.setValue(_lastSyncKey, completed.toIso8601String());
        appStorage.save();
        _runtime = _runtime.copyWith(lastSync: completed);
      }
    } catch (error) {
      _runtime = _runtime.copyWith(failed: _runtime.failed + 1, error: YandexDriveService.failureCode(error));
    } finally {
      _runtime = _runtime.copyWith(running: false);
      if (!_closed) _ended.add(_now().toUtc());
      _log.log(
        _runtime.failed > 0 ? Level.WARNING : Level.INFO,
        'Synchronization ${stopped || _closed ? 'stopped' : 'completed'} '
        'downloaded=${_runtime.downloaded} skipped=${_runtime.skipped} failed=${_runtime.failed} '
        'reason=${_runtime.error?.name ?? 'none'}',
      );
    }
  }

  bool _canContinue(String accountId) => !_closed && !_runtime.paused && _connections.isConnected(accountId);

  Future<T?> _readWithAccess<T>(String accountId, Future<T> Function(String token) action) async {
    if (!_canContinue(accountId)) return null;
    return _connections.withAccess<T?>(accountId, (token) async {
      if (!_canContinue(accountId)) return null;
      try {
        return await action(token);
      } on CloudStorageException catch (error) {
        if (error.code == DriveFailure.authorizationRequired && !_canContinue(accountId)) return null;
        rethrow;
      }
    });
  }

  Future<bool> _walk(String accountId, String remotePath, int depth) async {
    if (!_canContinue(accountId)) return false;
    if (depth > 64) throw const CloudStorageException(DriveFailure.invalidResponse);
    var offset = 0;
    while (true) {
      if (!_canContinue(accountId)) return false;
      final resource = await _readWithAccess<YandexDriveResource>(
        accountId,
        (token) => _connections.api.resources(token, remotePath, offset),
      );
      if (!_canContinue(accountId) || resource == null) return false;
      if (resource.type != YandexDriveResourceType.dir || resource.children == null) {
        throw const CloudStorageException(DriveFailure.invalidRequest);
      }
      final children = resource.children!;
      for (final item in children.items) {
        if (!_canContinue(accountId)) return false;
        if (item.type == YandexDriveResourceType.dir) {
          if (!await _walk(accountId, item.path, depth + 1)) return false;
        } else if (item.type == YandexDriveResourceType.file &&
            FileSettings.isSupportFile(path.posix.extension(item.path))) {
          try {
            final relative = YandexDrivePaths.relative(item.path, accountId);
            final exists = await mediaExists(relative);
            if (!_canContinue(accountId)) return false;
            if (exists) {
              _runtime = _runtime.copyWith(skipped: _runtime.skipped + 1);
            } else {
              YandexDriveDownload? download;
              try {
                download = await _readWithAccess<YandexDriveDownload>(
                  accountId,
                  (token) => _connections.api.download(token, item.path),
                );
              } catch (_) {
                if (!_canContinue(accountId)) return false;
                rethrow;
              }
              if (download == null) return false;
              try {
                final published = await publishDownloadedMedia(
                  download.response.stream,
                  relative,
                  expectedBytes: item.size,
                  contentLength: download.response.contentLength,
                  expectedMd5: item.md5,
                  expectedSha256: item.sha256,
                );
                _runtime = published
                    ? _runtime.copyWith(downloaded: _runtime.downloaded + 1)
                    : _runtime.copyWith(skipped: _runtime.skipped + 1);
              } finally {
                download.close();
              }
            }
          } catch (error) {
            _runtime = _runtime.copyWith(failed: _runtime.failed + 1, error: YandexDriveService.failureCode(error));
            _log.fine('Media import failed reason=${YandexDriveService.failureCode(error).name}');
          }
          if (!_canContinue(accountId)) return false;
        } else {
          _runtime = _runtime.copyWith(skipped: _runtime.skipped + 1);
        }
      }
      final consumed = offset + children.items.length;
      if (consumed >= children.total) return true;
      if (children.items.isEmpty) throw const CloudStorageException(DriveFailure.invalidResponse);
      offset = consumed;
    }
  }

  @override
  Future<void> release() async {
    _closed = true;
    _runtime = _runtime.copyWith(active: false);
    _timer?.cancel();
    await Future.wait<void>([super.release(), _connections.close(pendingTransfer: _sync)]);
    unawaited(_started.close());
    unawaited(_ended.close());
    _log.info('Storage released');
  }
}
