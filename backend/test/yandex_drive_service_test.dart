// Test fixtures deliberately use small real files while network calls are fake.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_api.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_models.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_service.dart';
import 'package:fake_async/fake_async.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

http.Response _json(Object value, [int status = 200, Map<String, String>? headers]) =>
    http.Response(jsonEncode(value), status, headers: {'content-type': 'application/json', ...?headers});

Map<String, Object> _device({int expiresIn = 120}) => {
  'device_code': 'private-device-code',
  'user_code': 'family-code',
  'verification_url': 'https://oauth.yandex.ru/device',
  'interval': 5,
  'expires_in': expiresIn,
};

Map<String, Object> _tokens(String access) => {
  'access_token': access,
  'refresh_token': 'private-refresh',
  'expires_in': 3600,
};

enum _AccessStop { none, disconnect, close }

enum _OAuthStage { device, token, identity }

class _HeldOAuthApi extends YandexDriveApi {
  _HeldOAuthApi(this.stage, {this.expiresIn = 60});
  final _OAuthStage stage;
  final int expiresIn;
  final devices = <Completer<YandexDriveDeviceResponse>>[];
  final tokens = <Completer<YandexDriveTokenResponse>>[];
  final identities = <Completer<YandexDriveUser>>[];
  int deviceCalls = 0;
  int tokenCalls = 0;
  int identityCalls = 0;
  int closeCalls = 0;
  int get requests => deviceCalls + tokenCalls + identityCalls;

  @override
  Future<YandexDriveDeviceResponse> startDevice(String clientId) async {
    deviceCalls++;
    if (stage != _OAuthStage.device) return YandexDriveDeviceResponse.fromJson(_device(expiresIn: expiresIn));
    final pending = Completer<YandexDriveDeviceResponse>();
    devices.add(pending);
    return pending.future;
  }

  @override
  Future<YandexDriveTokenResponse> token(Map<String, String> form) async {
    tokenCalls++;
    if (stage != _OAuthStage.token) return YandexDriveTokenResponse.fromJson(_tokens('late-private-access'));
    final pending = Completer<YandexDriveTokenResponse>();
    tokens.add(pending);
    return pending.future;
  }

  @override
  Future<YandexDriveUser> identity(String token) async {
    identityCalls++;
    final pending = Completer<YandexDriveUser>();
    identities.add(pending);
    return pending.future;
  }

  void complete({bool error = false, int index = 0}) {
    if (error) {
      final failure = StateError('private-late-http-error');
      switch (stage) {
        case _OAuthStage.device:
          devices[index].completeError(failure);
        case _OAuthStage.token:
          tokens[index].completeError(failure);
        case _OAuthStage.identity:
          identities[index].completeError(failure);
      }
    } else {
      switch (stage) {
        case _OAuthStage.device:
          devices[index].complete(YandexDriveDeviceResponse.fromJson(_device(expiresIn: expiresIn)));
        case _OAuthStage.token:
          tokens[index].complete(YandexDriveTokenResponse.fromJson(_tokens('late-private-access')));
        case _OAuthStage.identity:
          identities[index].complete(const YandexDriveUser(uid: '123', displayName: 'Late identity'));
      }
    }
  }

  @override
  void close() {
    closeCalls++;
    super.close();
  }
}

void _seedAccount(AppStorage storage, {bool expired = false}) {
  storage.setValue('YandexDrive.clientId', 'application');
  storage.setValue('YandexDrive.accounts', {
    '123': {
      'accountId': '123',
      'label': 'Family',
      'accessToken': 'old',
      'refreshToken': 'refresh',
      'expiresAt': expired ? '2000-01-01T00:00:00Z' : '2099-01-01T00:00:00Z',
    },
  });
  storage.save();
}

class _ReadApi extends YandexDriveApi {
  final reached = Completer<void>();
  final metadata = Completer<YandexDriveResource>();
  final refresh = Completer<YandexDriveTokenResponse>();
  int closeCalls = 0;
  int metadataCalls = 0;
  int refreshCalls = 0;
  @override
  Future<YandexDriveResource> resources(String token, String remotePath, int offset) {
    metadataCalls++;
    reached.complete();
    return metadata.future;
  }

  @override
  Future<YandexDriveTokenResponse> token(Map<String, String> form) {
    refreshCalls++;
    reached.complete();
    return refresh.future;
  }

  @override
  void close() {
    closeCalls++;
    super.close();
  }
}

class _ReauthorizationApi extends YandexDriveApi {
  final refresh = Completer<YandexDriveTokenResponse>();
  int refreshCalls = 0;
  @override
  Future<YandexDriveDeviceResponse> startDevice(String clientId) async => YandexDriveDeviceResponse.fromJson(_device());
  @override
  Future<YandexDriveTokenResponse> token(Map<String, String> form) {
    if (form['grant_type'] == 'refresh_token') {
      refreshCalls++;
      return refresh.future;
    }
    return Future.value(YandexDriveTokenResponse.fromJson(_tokens('new-authorization-access')));
  }

  @override
  Future<YandexDriveUser> identity(String token) async => const YandexDriveUser(uid: '123', displayName: 'Reconnected');
}

class _DeviceApi extends YandexDriveApi {
  _DeviceApi({required this.onToken, this.expiresIn = 120, this.onIdentity});
  final Future<YandexDriveTokenResponse> Function() onToken;
  final int expiresIn;
  final Future<YandexDriveUser> Function()? onIdentity;
  int closeCalls = 0;
  @override
  void close() {
    closeCalls++;
    super.close();
  }

  @override
  Future<YandexDriveDeviceResponse> startDevice(String clientId) async =>
      YandexDriveDeviceResponse.fromJson(_device(expiresIn: expiresIn));
  @override
  Future<YandexDriveTokenResponse> token(Map<String, String> form) => onToken();
  @override
  Future<YandexDriveUser> identity(String token) async => onIdentity == null
      ? const YandexDriveUser(uid: '123', login: 'family', displayName: 'Family')
      : await onIdentity!();
}

class _FailingStorage extends AppStorage {
  _FailingStorage(super.rootPath);
  bool fail = false;
  int saves = 0;
  @override
  void save() {
    saves++;
    if (fail) throw const FileSystemException('Write failed');
    super.save();
  }
}

void main() {
  late Directory directory;
  late AppStorage storage;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('yandex-auth-');
    storage = AppStorage(directory.path);
  });
  tearDown(() async {
    storage.save();
    await directory.delete(recursive: true);
  });

  test('config defaults to one hour and keeps only non-secret account choices', () {
    final config = YandexDriveStorageConfig.fromJson({});
    expect(config.syncPeriod, const Duration(hours: 1));
    final withAccount = config.copyWith(
      accounts: [
        const YandexDriveAccountConfig(accountId: '123', label: 'Family', paths: ['disk:/Camera']),
      ],
    );
    final container = StoragesConfig.fromJson({
      'selected': 'YandexDriveStorage',
      'storages': {'YandexDriveStorage': withAccount.toJson()},
    });
    expect(container.selected, StorageType.YandexDriveStorage);
    expect(container.getOrCreateEmpty<YandexDriveStorageConfig>(StorageType.YandexDriveStorage), withAccount);
    expect(jsonEncode(container.toJson()), isNot(contains('Token')));
    expect(YandexDriveStorageConfig.fromJson({'syncPeriod': 0}).syncPeriod, const Duration(hours: 1));
  });

  test('device authorization polls without exposing credentials and persists actual identity', () {
    fakeAsync((clock) {
      var polls = 0;
      final logs = <LogRecord>[];
      final subscription = Logger.root.onRecord.listen(logs.add);
      final api = _DeviceApi(
        onToken: () async {
          polls++;
          return polls == 1
              ? const YandexDriveTokenResponse(error: 'authorization_pending')
              : YandexDriveTokenResponse.fromJson(_tokens('private-access'));
        },
      );
      final service = YandexDriveService(storage, api: api, now: () => DateTime.utc(2026).add(clock.elapsed));
      service.configureApplication('application-id', 'private-client-secret');
      DriveAuthorization? start;
      unawaited(service.startAuthorization().then((value) => start = value));
      clock.elapse(Duration.zero);
      expect(start?.userCode, 'family-code');
      expect(polls, 0);
      clock.elapse(const Duration(seconds: 5));
      expect(polls, 1);
      expect(service.authorization(start!.sessionId).status, DriveAuthorizationStatus.pending);
      clock.elapse(const Duration(seconds: 5));
      expect(service.authorization(start!.sessionId).status, DriveAuthorizationStatus.connected);
      expect(service.state().connections.single.accountId, '123');
      expect(service.state().connections.single.label, 'Family');
      final publicJson = jsonEncode(service.state().toJson());
      expect(publicJson, isNot(contains('private-')));
      expect(logs.map((entry) => entry.message).join(' '), isNot(contains('private-')));
      expect(
        logs.any(
          (entry) => entry.loggerName == 'YandexDriveService' && entry.message.startsWith('Authorization completed'),
        ),
        isTrue,
      );
      unawaited(service.close());
      clock.elapse(Duration.zero);
      unawaited(subscription.cancel());
      final reloaded = AppStorage(directory.path);
      final next = YandexDriveService(reloaded);
      expect(next.state().connections.single.accountId, '123');
      expect(next.state().clientSecretConfigured, isTrue);
      unawaited(next.close());
      clock.elapse(Duration.zero);
    });
  });

  test('expiry and cancellation ignore late token responses and never connect an account', () {
    fakeAsync((clock) {
      final pending = Completer<YandexDriveTokenResponse>();
      final api = _DeviceApi(expiresIn: 6, onToken: () => pending.future);
      final service = YandexDriveService(storage, api: api);
      service.configureApplication('application', null);
      DriveAuthorization? start;
      unawaited(service.startAuthorization().then((value) => start = value));
      clock.flushMicrotasks();
      expect(
        () => service.configureApplication('other', null),
        throwsA(isA<CloudStorageException>().having((e) => e.code, 'code', DriveFailure.busy)),
      );
      clock.elapse(const Duration(seconds: 6));
      expect(service.authorization(start!.sessionId).status, DriveAuthorizationStatus.expired);
      pending.complete(YandexDriveTokenResponse.fromJson(_tokens('late-private-access')));
      clock.flushMicrotasks();
      expect(service.state().connections, isEmpty);
      unawaited(service.close());
      clock.flushMicrotasks();
    });
  });

  test('explicit cancel stops polling and keeps existing connections intact', () {
    fakeAsync((clock) {
      var polls = 0;
      final service = YandexDriveService(
        storage,
        api: _DeviceApi(
          onToken: () async {
            polls++;
            return YandexDriveTokenResponse.fromJson(_tokens('should-not-be-requested'));
          },
        ),
      );
      service.configureApplication('application', null);
      DriveAuthorization? start;
      unawaited(service.startAuthorization().then((value) => start = value));
      clock.flushMicrotasks();
      expect(service.cancelAuthorization(start!.sessionId).status, DriveAuthorizationStatus.cancelled);
      clock.elapse(const Duration(minutes: 3));
      expect(polls, 0);
      expect(service.state().connections, isEmpty);
      unawaited(service.close());
      clock.flushMicrotasks();
    });
  });

  test('disconnect lets refresh finish without resurrecting the removed account', () async {
    storage.setValue('YandexDrive.clientId', 'application');
    storage.setValue('YandexDrive.accounts', {
      '123': {
        'accountId': '123',
        'label': 'Family',
        'accessToken': 'old',
        'refreshToken': 'old-refresh',
        'expiresAt': '2000-01-01T00:00:00.000Z',
      },
    });
    storage.save();
    final reached = Completer<void>();
    final response = Completer<http.Response>();
    final service = YandexDriveService(
      storage,
      api: YandexDriveApi(
        clientFactory: () => MockClient((request) {
          reached.complete();
          return response.future;
        }),
      ),
    );
    var finished = false;
    final action = service.withAccess('123', (token) async => token);
    unawaited(action.then<void>((_) => finished = true, onError: (Object _, StackTrace __) => finished = true));
    final expectation = expectLater(action, throwsA(isA<CloudStorageException>()));
    await reached.future;
    service.disconnect('123');
    await Future<void>.delayed(Duration.zero);
    expect(finished, isFalse);
    response.complete(_json(_tokens('late-new')));
    await expectation;
    expect(service.state().connections, isEmpty);
    expect(jsonEncode(storage.getRaw('YandexDrive.accounts')), isNot(contains('late-new')));
    await service.close();
  });

  for (final identifiedAccount in ['123', '456']) {
    test('disconnect during identity cancels only the disconnected account $identifiedAccount', () {
      storage.setValue('YandexDrive.clientId', 'application');
      storage.setValue('YandexDrive.accounts', {
        '123': {
          'accountId': '123',
          'label': 'Old',
          'accessToken': 'old',
          'refreshToken': 'refresh',
          'expiresAt': '2030-01-01T00:00:00Z',
        },
      });
      storage.save();
      fakeAsync((clock) {
        final identity = Completer<YandexDriveUser>();
        var identityRequested = false;
        final service = YandexDriveService(
          storage,
          api: _DeviceApi(
            onToken: () async => YandexDriveTokenResponse.fromJson(_tokens('new-private')),
            onIdentity: () {
              identityRequested = true;
              return identity.future;
            },
          ),
        );
        DriveAuthorization? start;
        unawaited(service.startAuthorization().then((value) => start = value));
        clock.flushMicrotasks();
        clock.elapse(const Duration(seconds: 5));
        expect(identityRequested, isTrue);
        service.disconnect('123');
        identity.complete(YandexDriveUser(uid: identifiedAccount, displayName: 'Connected'));
        clock.flushMicrotasks();
        expect(
          service.authorization(start!.sessionId).status,
          identifiedAccount == '123' ? DriveAuthorizationStatus.cancelled : DriveAuthorizationStatus.connected,
        );
        expect(
          service.state().connections.map((connection) => connection.accountId),
          identifiedAccount == '123' ? isEmpty : ['456'],
        );
        unawaited(service.close());
        clock.flushMicrotasks();
      });
    });
  }

  test('failed application save rolls back and preserves autosave of unrelated edits after recovery', () {
    final failing = _FailingStorage(directory.path);
    fakeAsync((clock) {
      final service = YandexDriveService(failing);
      service.configureApplication('old-id', 'old-secret');
      failing.setValue('unrelated', 'retained');
      failing.fail = true;
      expect(
        () => service.configureApplication('new-id', 'new-secret'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.storage)),
      );
      expect(service.state().clientId, 'old-id');
      expect(failing.getRaw('YandexDrive.clientSecret'), 'old-secret');
      final saves = failing.saves;
      failing.fail = false;
      clock.elapse(const Duration(seconds: 20));
      expect(failing.saves, saves + 1);
      final recovered = AppStorage(directory.path);
      expect(recovered.getRaw('YandexDrive.clientId'), 'old-id');
      expect(recovered.getRaw('YandexDrive.clientSecret'), 'old-secret');
      expect(recovered.getRaw('unrelated'), 'retained');
      unawaited(service.close());
      clock.flushMicrotasks();
    });
  });

  for (final stop in _AccessStop.values) {
    test('401 after $stop starts a refresh only for an active account', () async {
      _seedAccount(storage);
      var refreshes = 0;
      final service = YandexDriveService(
        storage,
        api: _DeviceApi(
          onToken: () async {
            refreshes++;
            return const YandexDriveTokenResponse(accessToken: 'new', expiresIn: 3600);
          },
        ),
      );
      Future<void>? closing;
      addTearDown(() async => closing == null ? await service.close() : await closing);
      var reads = 0;
      final reached = Completer<void>();
      final first = Completer<String>();
      final read = service.withAccess('123', (token) {
        if (++reads == 1) {
          reached.complete();
          return first.future;
        }
        return Future.value(token);
      });
      await reached.future;
      if (stop == _AccessStop.disconnect) service.disconnect('123');
      if (stop == _AccessStop.close) closing = service.close();
      first.completeError(const CloudStorageException(DriveFailure.authorizationRequired));
      if (stop != _AccessStop.none) {
        await expectLater(
          read,
          throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.cancelled)),
        );
      } else {
        expect(await read, 'new');
      }
      expect(refreshes, stop == _AccessStop.none ? 1 : 0);
      expect(reads, stop == _AccessStop.none ? 2 : 1);
    });
  }

  for (final stop in [_AccessStop.disconnect, _AccessStop.close]) {
    test('$stop waits for accepted metadata and returns its successful result', () async {
      _seedAccount(storage);
      final api = _ReadApi();
      final service = YandexDriveService(storage, api: api);
      Future<void>? closing;
      addTearDown(() async => closing == null ? await service.close() : await closing);
      final request = service.folders('123', 'disk:/', 0);
      await api.reached.future;
      if (stop == _AccessStop.disconnect) service.disconnect('123');
      var closed = false;
      if (stop == _AccessStop.close) closing = service.close().then((_) => closed = true);
      await Future<void>.delayed(Duration.zero);
      expect(api.closeCalls, 0);
      expect(closed, isFalse);
      api.metadata.complete(
        const YandexDriveResource(
          path: 'disk:/',
          type: YandexDriveResourceType.dir,
          children: YandexDriveResourceList(),
        ),
      );
      expect((await request).path, 'disk:/');
      await closing;
      expect(api.metadataCalls, 1);
      if (stop == _AccessStop.close) expect(api.closeCalls, 1);
      if (stop == _AccessStop.disconnect) expect(service.isConnected('123'), isFalse);
    });

    test('$stop lets refresh finish without storing tokens or starting the next action', () async {
      _seedAccount(storage, expired: true);
      final records = <LogRecord>[];
      final subscription = Logger.root.onRecord.listen(records.add);
      addTearDown(subscription.cancel);
      final api = _ReadApi();
      final service = YandexDriveService(storage, api: api);
      Future<void>? closing;
      addTearDown(() async => closing == null ? await service.close() : await closing);
      var actions = 0;
      final request = service.withAccess('123', (token) async {
        actions++;
        return token;
      });
      final expectation = expectLater(
        request,
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.cancelled)),
      );
      await api.reached.future;
      if (stop == _AccessStop.disconnect) service.disconnect('123');
      var closed = false;
      if (stop == _AccessStop.close) closing = service.close().then((_) => closed = true);
      await Future<void>.delayed(Duration.zero);
      expect(api.closeCalls, 0);
      expect(closed, isFalse);
      api.refresh.complete(YandexDriveTokenResponse.fromJson(_tokens('late-new')));
      await expectation;
      await closing;
      expect(actions, 0);
      expect(api.refreshCalls, 1);
      expect(jsonEncode(storage.getRaw('YandexDrive.accounts')), isNot(contains('late-new')));
      expect(
        records.where((record) => record.loggerName == 'YandexDriveService' && record.level >= Level.WARNING),
        isEmpty,
      );
      expect(records.any((record) => record.message.contains('Token refresh discarded')), isTrue);
      if (stop == _AccessStop.close) expect(api.closeCalls, 1);
    });
  }

  test('reauthorization supersedes a late invalid_grant from an earlier refresh of the same account', () {
    _seedAccount(storage, expired: true);
    fakeAsync((clock) {
      final records = <LogRecord>[];
      final subscription = Logger.root.onRecord.listen(records.add);
      final api = _ReauthorizationApi();
      final service = YandexDriveService(storage, api: api);
      String? access;
      Object? failure;
      unawaited(
        service
            .withAccess('123', (token) async => token)
            .then<void>((value) => access = value, onError: (Object error) => failure = error),
      );
      clock.flushMicrotasks();
      expect(api.refreshCalls, 1);
      DriveAuthorization? authorization;
      unawaited(service.startAuthorization().then((value) => authorization = value));
      clock.flushMicrotasks();
      clock.elapse(const Duration(seconds: 5));
      expect(service.authorization(authorization!.sessionId).status, DriveAuthorizationStatus.connected);
      expect(service.state().connections.single.label, 'Reconnected');
      api.refresh.complete(const YandexDriveTokenResponse(error: 'invalid_grant'));
      clock.flushMicrotasks();
      expect(access, 'new-authorization-access');
      expect(failure, isNull);
      expect((storage.getRaw('YandexDrive.accounts') as Map)['123']['accessToken'], 'new-authorization-access');
      expect(
        records.where((record) => record.loggerName == 'YandexDriveService' && record.level >= Level.WARNING),
        isEmpty,
      );
      expect(records.any((record) => record.message == 'Token refresh completed reason=credentialsReplaced'), isTrue);
      unawaited(service.close());
      unawaited(subscription.cancel());
      clock.flushMicrotasks();
    });
  });

  test('failed pending transfer still releases the API', () async {
    final api = _DeviceApi(onToken: () async => const YandexDriveTokenResponse(error: 'authorization_pending'));
    final service = YandexDriveService(storage, api: api);
    final pending = Completer<void>();
    final closing = service.close(pendingTransfer: pending.future);
    final expectation = expectLater(closing, throwsA(isA<StateError>()));
    expect(api.closeCalls, 0);
    pending.completeError(StateError('Transfer failed'));
    await expectation;
    expect(api.closeCalls, 1);
  });

  for (final stage in _OAuthStage.values) {
    for (final error in [false, true]) {
      test('cancelled OAuth $stage waits for its HTTP ${error ? 'error' : 'response'} and ignores it', () {
        fakeAsync((clock) {
          final records = <LogRecord>[];
          final subscription = Logger.root.onRecord.listen(records.add);
          final api = _HeldOAuthApi(stage);
          final service = YandexDriveService(storage, api: api);
          service.configureApplication('application', null);
          DriveAuthorization? original;
          unawaited(service.startAuthorization().then((value) => original = value));
          clock.flushMicrotasks();
          DriveAuthorization? current;
          unawaited(service.startAuthorization().then((value) => current = value));
          clock.flushMicrotasks();
          if (stage != _OAuthStage.device) clock.elapse(const Duration(seconds: 5));
          final accepted = api.requests;
          expect(service.cancelAuthorization(current!.sessionId).status, DriveAuthorizationStatus.cancelled);
          expect(service.authorization(current!.sessionId).userCode, isNull);
          clock.elapse(const Duration(minutes: 2));
          expect(api.requests, accepted);
          if (stage == _OAuthStage.device) expect(original, isNull);
          var closed = false;
          unawaited(service.close().then((_) => closed = true));
          clock.flushMicrotasks();
          expect(closed, isFalse);
          expect(api.closeCalls, 0);
          api.complete(error: error);
          clock.flushMicrotasks();
          expect(closed, isTrue);
          expect(api.closeCalls, 1);
          expect(api.requests, accepted);
          expect(service.state().connections, isEmpty);
          if (stage == _OAuthStage.device) expect(original!.status, DriveAuthorizationStatus.cancelled);
          expect(records.where((record) => record.level >= Level.WARNING), isEmpty);
          expect(
            records.map((record) => '${record.message} ${record.error ?? ''}').join(' '),
            isNot(contains('private-')),
          );
          expect(clock.pendingTimers, isEmpty);
          unawaited(subscription.cancel());
          clock.flushMicrotasks();
        });
      });
    }
  }

  for (final stage in [_OAuthStage.token, _OAuthStage.identity]) {
    test('close marks OAuth $stage cancelled and waits for its late HTTP error', () {
      fakeAsync((clock) {
        final records = <LogRecord>[];
        final subscription = Logger.root.onRecord.listen(records.add);
        final api = _HeldOAuthApi(stage);
        final service = YandexDriveService(storage, api: api);
        service.configureApplication('application', null);
        unawaited(service.startAuthorization());
        clock.flushMicrotasks();
        clock.elapse(const Duration(seconds: 5));
        final accepted = api.requests;
        var closed = false;
        unawaited(service.close().then((_) => closed = true));
        clock.flushMicrotasks();
        expect(closed, isFalse);
        expect(api.closeCalls, 0);
        expect(
          records.any(
            (record) => record.level == Level.INFO && record.message == 'Authorization cancelled reason=closed',
          ),
          isTrue,
        );
        clock.elapse(const Duration(minutes: 2));
        expect(api.requests, accepted);
        api.complete(error: true);
        clock.flushMicrotasks();
        expect(closed, isTrue);
        expect(api.closeCalls, 1);
        expect(service.state().connections, isEmpty);
        expect(records.where((record) => record.level >= Level.WARNING), isEmpty);
        expect(clock.pendingTimers, isEmpty);
        unawaited(subscription.cancel());
        clock.flushMicrotasks();
      });
    });

    test('expired OAuth $stage waits for HTTP and never processes its late response', () {
      fakeAsync((clock) {
        final api = _HeldOAuthApi(stage, expiresIn: 6);
        final service = YandexDriveService(storage, api: api);
        service.configureApplication('application', null);
        DriveAuthorization? current;
        unawaited(service.startAuthorization().then((value) => current = value));
        clock.flushMicrotasks();
        clock.elapse(const Duration(seconds: 6));
        expect(service.authorization(current!.sessionId).status, DriveAuthorizationStatus.expired);
        final accepted = api.requests;
        var closed = false;
        unawaited(service.close().then((_) => closed = true));
        clock.flushMicrotasks();
        expect(closed, isFalse);
        api.complete();
        clock.flushMicrotasks();
        expect(closed, isTrue);
        expect(api.requests, accepted);
        expect(service.state().connections, isEmpty);
        expect(clock.pendingTimers, isEmpty);
      });
    });
  }

  test('close waits for an old cancelled session and a newer session even when replies arrive in reverse order', () {
    fakeAsync((clock) {
      final api = _HeldOAuthApi(_OAuthStage.device);
      final service = YandexDriveService(storage, api: api);
      service.configureApplication('application', null);
      DriveAuthorization? oldReply, oldSession, newReply;
      unawaited(service.startAuthorization().then((value) => oldReply = value));
      clock.flushMicrotasks();
      unawaited(service.startAuthorization().then((value) => oldSession = value));
      clock.flushMicrotasks();
      service.cancelAuthorization(oldSession!.sessionId);
      unawaited(service.startAuthorization().then((value) => newReply = value));
      clock.flushMicrotasks();
      expect(api.deviceCalls, 2);
      var closed = false;
      unawaited(service.close().then((_) => closed = true));
      clock.flushMicrotasks();
      expect(closed, isFalse);
      api.complete(index: 1);
      clock.flushMicrotasks();
      expect(newReply!.status, DriveAuthorizationStatus.cancelled);
      expect(newReply!.sessionId, isNot(oldSession!.sessionId));
      expect(closed, isFalse);
      expect(api.closeCalls, 0);
      api.complete(index: 0, error: true);
      clock.flushMicrotasks();
      expect(oldReply!.status, DriveAuthorizationStatus.cancelled);
      expect(closed, isTrue);
      expect(api.closeCalls, 1);
      expect(api.tokenCalls, 0);
      expect(service.state().connections, isEmpty);
      expect(clock.pendingTimers, isEmpty);
    });
  });

  test('folder browsing pages directory data and safely refreshes an expired token', () async {
    storage.setValue('YandexDrive.clientId', 'application');
    storage.setValue('YandexDrive.accounts', {
      '123': {
        'accountId': '123',
        'label': 'Family',
        'accessToken': 'old',
        'refreshToken': 'old-refresh',
        'expiresAt': '2000-01-01T00:00:00.000Z',
      },
    });
    storage.save();
    var refreshes = 0;
    final service = YandexDriveService(
      storage,
      api: YandexDriveApi(
        clientFactory: () => MockClient((request) async {
          if (request.url.path == '/token') {
            refreshes++;
            return _json(_tokens('fresh'));
          }
          expect(request.headers['Authorization'], 'OAuth fresh');
          expect(request.url.queryParameters['offset'], '0');
          return _json({
            'path': 'disk:/',
            'type': 'dir',
            '_embedded': {
              'offset': 0,
              'limit': 100,
              'total': 3,
              'items': [
                {'path': 'disk:/Camera', 'name': 'Camera', 'type': 'dir'},
                {'path': 'disk:/a.jpg', 'name': 'a.jpg', 'type': 'file', 'size': 3},
              ],
            },
          });
        }),
      ),
    );
    final page = await service.folders('123', 'disk:/', 0);
    expect(page.folders.single.path, 'disk:/Camera');
    expect(page.nextOffset, 2);
    expect(refreshes, 1);
    await service.close();
  });
}
