import 'dart:async';
import 'dart:math';

import 'package:logging/logging.dart';

import '../../../app_storage.dart';
import '../../command/drive_command.dart';
import '../storage/cloud_storage_transfer.dart';
import 'yandex_drive_api.dart';
import 'yandex_drive_models.dart';
import 'yandex_drive_paths.dart';

/// Owns the small private connection store independently of selected Storage.
/// Folder choices and sync intervals remain in AppConfig, never in this store.
class YandexDriveService {
  YandexDriveService(this._storage, {YandexDriveApi? api, DateTime Function()? now})
    : api = api ?? YandexDriveApi(),
      _now = now ?? DateTime.now {
    final raw = _storage.getRaw(_accountsKey);
    if (raw is Map) {
      for (final value in raw.values.take(32)) {
        try {
          if (value is! Map<String, dynamic>) continue;
          final credential = YandexDriveCredential.fromJson(value);
          if (YandexDrivePaths.validAccountId(credential.accountId) && credential.accessToken.isNotEmpty) {
            _credentials[credential.accountId] = credential;
          }
        } catch (_) {
          _log.warning('Connection load rejected reason=invalidRecord');
        }
      }
    }
  }

  static final _log = Logger('YandexDriveService');
  static final _applicationId = RegExp(r'^[A-Za-z0-9_-]{1,200}$');
  static const _clientIdKey = 'YandexDrive.clientId';
  static const _clientSecretKey = 'YandexDrive.clientSecret';
  static const _accountsKey = 'YandexDrive.accounts';
  final AppStorage _storage;
  final YandexDriveApi api;
  final DateTime Function() _now;
  final _random = Random.secure();
  final _credentials = <String, YandexDriveCredential>{};
  final _refreshing = <String, Future<YandexDriveCredential>>{};
  final _requests = <Future<dynamic>>{};
  _AuthorizationSession? _session;
  bool _closed = false;

  /// Returns whether [accountId] still has credentials on this frame.
  bool isConnected(String accountId) => _credentials.containsKey(accountId);

  String get clientId => _storage.getRaw(_clientIdKey) is String ? _storage.getRaw(_clientIdKey) as String : '';
  String get _clientSecret =>
      _storage.getRaw(_clientSecretKey) is String ? _storage.getRaw(_clientSecretKey) as String : '';

  DriveState state({DriveRuntime runtime = const DriveRuntime()}) => DriveState(
    clientId: clientId,
    clientSecretConfigured: _clientSecret.isNotEmpty,
    connections: _credentials.values
        .map((value) => DriveConnection(accountId: value.accountId, label: value.label))
        .toList(),
    runtime: runtime,
  );

  void configureApplication(String identifier, String? secret) {
    _ensureOpen();
    if (_session?.state.status == DriveAuthorizationStatus.pending) {
      throw const CloudStorageException(DriveFailure.busy);
    }
    final clean = identifier.trim();
    if (!_applicationId.hasMatch(clean) || (secret?.length ?? 0) > 2000) {
      throw const CloudStorageException(DriveFailure.invalidRequest);
    }
    if (_credentials.isNotEmpty && clean != clientId) {
      throw const CloudStorageException(DriveFailure.busy);
    }
    final oldId = clientId;
    final oldSecret = _clientSecret;
    try {
      _storage.setValue(_clientIdKey, clean);
      _storage.setValue(
        _clientSecretKey,
        secret?.isNotEmpty == true
            ? secret
            : clean == oldId
            ? oldSecret
            : '',
      );
      _storage.save();
    } catch (_) {
      _storage.setValue(_clientIdKey, oldId);
      _storage.setValue(_clientSecretKey, oldSecret);
      _log.warning('Application configuration failed reason=storage');
      throw const CloudStorageException(DriveFailure.storage);
    }
    _log.info('Application configuration completed');
  }

  Future<DriveAuthorization> startAuthorization() => _track(_startAuthorization());

  Future<DriveAuthorization> _startAuthorization() async {
    _ensureOpen();
    if (clientId.isEmpty) throw const CloudStorageException(DriveFailure.notConfigured);
    final previous = _session;
    if (previous != null && previous.state.status == DriveAuthorizationStatus.pending) {
      return previous.state;
    }
    if (_credentials.length >= 32) throw const CloudStorageException(DriveFailure.busy);
    final session = _AuthorizationSession(
      List.generate(16, (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0')).join(),
    );
    _session = session;
    _log.info('Authorization started');
    try {
      final response = await api.startDevice(clientId);
      if (!_isCurrentPending(session)) return session.state;
      session.deviceCode = response.deviceCode;
      session.interval = Duration(seconds: response.interval);
      session.state = session.state.copyWith(
        userCode: response.userCode,
        verificationUrl: response.verificationUrl,
        expiresAt: _now().toUtc().add(Duration(seconds: response.expiresIn)),
      );
      session.expiry = Timer(Duration(seconds: response.expiresIn), () => _expire(session));
      _schedule(session);
      return session.state;
    } catch (error) {
      if (!_isCurrentPending(session)) return session.state;
      final code = failureCode(error);
      session.state = session.state.copyWith(status: DriveAuthorizationStatus.failed, error: code);
      session.stopTimers();
      _log.warning('Authorization failed reason=${code.name}');
      return session.state;
    }
  }

  DriveAuthorization authorization(String sessionId) {
    _ensureOpen();
    final session = _session;
    if (session == null || session.state.sessionId != sessionId) {
      throw const CloudStorageException(DriveFailure.invalidRequest);
    }
    return session.state;
  }

  DriveAuthorization cancelAuthorization(String sessionId) {
    final current = authorization(sessionId);
    final session = _session!;
    if (current.status == DriveAuthorizationStatus.pending) {
      session.state = current.copyWith(
        status: DriveAuthorizationStatus.cancelled,
        userCode: null,
        verificationUrl: null,
      );
      session.stopTimers();
      _log.info('Authorization cancelled');
    }
    return session.state;
  }

  void _expire(_AuthorizationSession session) {
    if (!_isCurrentPending(session)) return;
    session.state = session.state.copyWith(
      status: DriveAuthorizationStatus.expired,
      error: DriveFailure.authorizationExpired,
      userCode: null,
      verificationUrl: null,
    );
    session.stopTimers();
    _log.info('Authorization expired');
  }

  void _schedule(_AuthorizationSession session) {
    if (!_isCurrentPending(session)) return;
    session.timer = Timer(session.interval, () {
      unawaited(_track(_poll(session)));
    });
  }

  bool _isCurrentPending(_AuthorizationSession session) =>
      !_closed && _session == session && session.state.status == DriveAuthorizationStatus.pending;

  Future<void> _poll(_AuthorizationSession session) async {
    if (!_isCurrentPending(session)) return;
    try {
      final response = await api.token({
        'grant_type': 'device_code',
        'code': session.deviceCode,
        'client_id': clientId,
        if (_clientSecret.isNotEmpty) 'client_secret': _clientSecret,
      });
      if (!_isCurrentPending(session)) return;
      if (response.error == 'authorization_pending') {
        _schedule(session);
        return;
      }
      if (response.error == 'slow_down') {
        session.interval += const Duration(seconds: 5);
        _schedule(session);
        return;
      }
      if (response.error != null) throw CloudStorageException(_tokenFailure(response.error!));
      final token = _accessToken(response);
      final user = await api.identity(token);
      if (!_isCurrentPending(session)) return;
      if (session.disconnectedAccounts.contains(user.uid)) {
        cancelAuthorization(session.state.sessionId);
        return;
      }
      final credential = YandexDriveCredential(
        accountId: user.uid,
        label: user.displayName.isNotEmpty
            ? user.displayName
            : user.login.isNotEmpty
            ? user.login
            : user.uid,
        accessToken: token,
        refreshToken: response.refreshToken ?? '',
        expiresAt: _expires(response),
      );
      _storeCredential(credential);
      session.state = session.state.copyWith(
        status: DriveAuthorizationStatus.connected,
        accountId: user.uid,
        userCode: null,
        verificationUrl: null,
        error: null,
      );
      session.stopTimers();
      _log.info('Authorization completed accounts=${_credentials.length}');
    } catch (error) {
      if (!_isCurrentPending(session)) return;
      final code = failureCode(error);
      if ({DriveFailure.network, DriveFailure.rateLimited, DriveFailure.serviceUnavailable}.contains(code)) {
        if (session.state.error != code) _log.warning('Authorization waiting reason=${code.name}');
        session.state = session.state.copyWith(error: code);
        _schedule(session);
      } else {
        session.state = session.state.copyWith(
          status: DriveAuthorizationStatus.failed,
          error: code,
          userCode: null,
          verificationUrl: null,
        );
        session.stopTimers();
        _log.warning('Authorization failed reason=${code.name}');
      }
    }
  }

  DateTime _expires(YandexDriveTokenResponse response) {
    final seconds = response.expiresIn;
    if (seconds == null || seconds < 1) throw const CloudStorageException(DriveFailure.invalidResponse);
    return _now().toUtc().add(Duration(seconds: seconds));
  }

  static String _accessToken(YandexDriveTokenResponse response) {
    final token = response.accessToken;
    if (token == null || token.isEmpty) throw const CloudStorageException(DriveFailure.invalidResponse);
    return token;
  }

  static DriveFailure _tokenFailure(String value) => switch (value) {
    'access_denied' => DriveFailure.authorizationDenied,
    'expired_token' => DriveFailure.authorizationExpired,
    'invalid_grant' => DriveFailure.authorizationRequired,
    'invalid_client' || 'unauthorized_client' => DriveFailure.notConfigured,
    'temporarily_unavailable' => DriveFailure.serviceUnavailable,
    _ => DriveFailure.invalidResponse,
  };

  void _storeCredential(YandexDriveCredential value) {
    final old = _credentials[value.accountId];
    _credentials[value.accountId] = value;
    try {
      _saveConnections();
    } catch (_) {
      if (old == null) {
        _credentials.remove(value.accountId);
      } else {
        _credentials[value.accountId] = old;
      }
      _storage.setValue(_accountsKey, _connectionJson());
      throw const CloudStorageException(DriveFailure.storage);
    }
  }

  Map<String, dynamic> _connectionJson() => _credentials.map((key, value) => MapEntry(key, value.toJson()));
  void _saveConnections() {
    _storage.setValue(_accountsKey, _connectionJson());
    _storage.save();
  }

  void disconnect(String accountId) {
    _ensureOpen();
    final old = _credentials.remove(accountId);
    if (old == null) throw const CloudStorageException(DriveFailure.invalidRequest);
    try {
      _saveConnections();
    } catch (_) {
      _credentials[accountId] = old;
      _storage.setValue(_accountsKey, _connectionJson());
      throw const CloudStorageException(DriveFailure.storage);
    }
    // Identity can still be in flight. Ignore its late reply only if it belongs
    // to this account, so disconnecting A does not discard a connection of B.
    final session = _session;
    if (session?.state.status == DriveAuthorizationStatus.pending) {
      session!.disconnectedAccounts.add(accountId);
    }
    _log.info('Account disconnected accounts=${_credentials.length}');
  }

  /// Runs [action] with valid credentials and waits for its accepted request.
  ///
  /// Successful actions complete after disconnect or shutdown. Those state
  /// changes prevent starting a refresh or another action afterward.
  Future<T> withAccess<T>(String accountId, Future<T> Function(String token) action) =>
      _track(_withAccess(accountId, action));

  Future<T> _track<T>(Future<T> request) {
    _requests.add(request);
    unawaited(
      request.then<void>(
        (_) => _requests.remove(request),
        onError: (Object _, StackTrace __) => _requests.remove(request),
      ),
    );
    return request;
  }

  Future<T> _withAccess<T>(String accountId, Future<T> Function(String token) action) async {
    _ensureOpen();
    var credential = _credentials[accountId];
    if (credential == null) throw const CloudStorageException(DriveFailure.authorizationRequired);
    if (!credential.expiresAt.isAfter(_now().toUtc().add(const Duration(seconds: 30)))) {
      credential = await _refresh(accountId);
      _ensureRequestActive(accountId);
    }
    try {
      return await action(credential.accessToken);
    } on CloudStorageException catch (error) {
      if (error.code != DriveFailure.authorizationRequired) rethrow;
      _ensureRequestActive(accountId);
      credential = await _refresh(accountId);
      _ensureRequestActive(accountId);
      return await action(credential.accessToken);
    }
  }

  void _ensureRequestActive(String accountId) {
    if (_closed || !isConnected(accountId)) throw const CloudStorageException(DriveFailure.cancelled);
  }

  Future<YandexDriveCredential> _refresh(String accountId) {
    final current = _refreshing[accountId];
    if (current != null) return current;
    final refresh = _refreshAccount(accountId).whenComplete(() {
      _refreshing.remove(accountId);
    });
    _refreshing[accountId] = refresh;
    return refresh;
  }

  Future<YandexDriveCredential> _refreshAccount(String accountId) async {
    try {
      final original = _credentials[accountId];
      if (original == null || original.refreshToken.isEmpty) {
        throw const CloudStorageException(DriveFailure.authorizationRequired);
      }
      _log.info('Token refresh started');
      final response = await api.token({
        'grant_type': 'refresh_token',
        'refresh_token': original.refreshToken,
        'client_id': clientId,
        if (_clientSecret.isNotEmpty) 'client_secret': _clientSecret,
      });
      _ensureRequestActive(accountId);
      if (_credentials[accountId] != original) {
        final current = _credentials[accountId];
        if (current == null) throw const CloudStorageException(DriveFailure.cancelled);
        _log.info('Token refresh completed reason=credentialsReplaced');
        return current;
      }
      if (response.error != null) throw CloudStorageException(_tokenFailure(response.error!));
      final updated = original.copyWith(
        accessToken: _accessToken(response),
        refreshToken: response.refreshToken ?? original.refreshToken,
        expiresAt: _expires(response),
      );
      _storeCredential(updated);
      _log.info('Token refresh completed');
      return updated;
    } catch (error) {
      final code = _closed || !isConnected(accountId) ? DriveFailure.cancelled : failureCode(error);
      _log.log(
        code == DriveFailure.cancelled ? Level.INFO : Level.WARNING,
        'Token refresh ${code == DriveFailure.cancelled ? 'discarded' : 'failed'} reason=${code.name}',
      );
      throw CloudStorageException(code);
    }
  }

  Future<DriveFolderPage> folders(String accountId, String remotePath, int offset) async {
    final normalized = YandexDrivePaths.normalize(remotePath);
    final resource = await withAccess(accountId, (token) => api.resources(token, normalized, offset));
    if (resource.type != YandexDriveResourceType.dir || resource.children == null) {
      throw const CloudStorageException(DriveFailure.invalidRequest);
    }
    final list = resource.children!;
    final consumed = offset + list.items.length;
    if (list.items.isEmpty && consumed < list.total) throw const CloudStorageException(DriveFailure.invalidResponse);
    return DriveFolderPage(
      path: normalized,
      folders: list.items
          .where((item) => item.type == YandexDriveResourceType.dir)
          .map((item) => DriveFolder(name: item.name, path: item.path))
          .toList(),
      offset: offset,
      nextOffset: consumed < list.total ? consumed : null,
    );
  }

  static DriveFailure failureCode(Object error) => error is CloudStorageException
      ? error.code
      : error is FormatException || error is ArgumentError
      ? DriveFailure.invalidRequest
      : DriveFailure.storage;
  void _ensureOpen() {
    if (_closed) throw const CloudStorageException(DriveFailure.cancelled);
  }

  /// Marks authorization cancelled and waits for accepted requests before closing resources.
  ///
  /// [pendingTransfer] also keeps the API transport open until the current
  /// media file finishes. OAuth, metadata, and refresh HTTP run to completion;
  /// cancelled sessions ignore their replies and start no further requests.
  Future<void> close({Future<void>? pendingTransfer}) async {
    _closed = true;
    final session = _session;
    if (session?.state.status == DriveAuthorizationStatus.pending) {
      session!.state = session.state.copyWith(
        status: DriveAuthorizationStatus.cancelled,
        userCode: null,
        verificationUrl: null,
      );
      _log.info('Authorization cancelled reason=closed');
    }
    session?.stopTimers();
    try {
      await Future.wait<void>([
        if (pendingTransfer != null) pendingTransfer,
        for (final request in _requests.toList()) request.then<void>((_) {}, onError: (Object _, StackTrace __) {}),
      ]);
    } finally {
      api.close();
      await Future.wait(
        _refreshing.values.map((future) => future.then<void>((_) {}, onError: (Object _, StackTrace __) {})),
      );
    }
  }
}

class _AuthorizationSession {
  _AuthorizationSession(String id)
    : state = DriveAuthorization(sessionId: id, status: DriveAuthorizationStatus.pending);
  DriveAuthorization state;
  String deviceCode = '';
  Duration interval = const Duration(seconds: 5);
  final disconnectedAccounts = <String>{};
  Timer? timer;
  Timer? expiry;
  void stopTimers() {
    timer?.cancel();
    expiry?.cancel();
  }
}
