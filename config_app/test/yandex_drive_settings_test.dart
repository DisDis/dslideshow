import 'dart:async';

import 'package:config_app/features/config/data/repository/yandex_drive_repository.dart';
import 'package:config_app/features/config/presentation/bloc/yandex_drive_bloc.dart';
import 'package:config_app/features/config/presentation/pages/storage_settings_page.dart';
import 'package:config_app/features/config/presentation/pages/yandex_drive_settings.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';

class _Realtime implements RealtimeService {
  _Realtime(this.handle);
  final FutureOr<DriveResult> Function(DriveCommand) handle;
  final commands = <DriveCommand>[];
  final firstRequest = Completer<void>();
  int envelopeIdOffset = 0;

  @override
  Future<WebSocketResult> send(WebSocketCommand command, {Duration? timeout}) async {
    final envelope = command as WSSendRpcCommand;
    final request = serializers.deserialize(envelope.commandData) as DriveCommand;
    commands.add(request);
    if (!firstRequest.isCompleted) firstRequest.complete();
    final result = await handle(request);
    return WSRpcResult(id: envelope.id + envelopeIdOffset, resultData: serializers.serialize(result)!);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _connected = DriveState(
  clientId: 'application',
  connections: [DriveConnection(accountId: 'family', label: 'Family')],
);

DriveResult _result(
  DriveCommand command, {
  DriveState state = _connected,
  DriveAuthorization? authorization,
  DriveFolderPage? page,
  DriveFailure? error,
}) => DriveResult(id: command.id, state: state, authorization: authorization, folderPage: page, error: error);

Widget _app(Widget child, {double textScale = 1}) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
    child: child!,
  ),
  home: Scaffold(body: child),
);

void main() {
  for (final opened in [true, false]) {
    testWidgets('OAuth setup explains registration and opens its creation URL; opened=$opened', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final launched = <String>[];
      const channel = MethodChannel('plugins.flutter.io/url_launcher');
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'launch') {
          launched.add((call.arguments as Map)['url'] as String);
          return opened;
        }
        return true;
      });
      addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, null));
      final logs = <LogRecord>[];
      final previousLevel = Logger.root.level;
      Logger.root.level = Level.ALL;
      final subscription = Logger.root.onRecord.listen(logs.add);
      addTearDown(() async {
        await subscription.cancel();
        Logger.root.level = previousLevel;
      });
      final client = _Realtime((command) => _result(command, state: const DriveState(clientId: 'public-client')));
      await tester.pumpWidget(
        _app(
          SingleChildScrollView(
            child: YandexDriveSettings(
              config: const YandexDriveStorageConfig(),
              repository: YandexDriveRepository(client),
              onChanged: (_) {},
            ),
          ),
          textScale: 1.5,
        ),
      );
      await tester.pump();
      await tester.ensureVisible(find.text('Configure application'));
      await tester.tap(find.text('Configure application'));
      await tester.pumpAndSettle();
      const creationUrl = 'https://oauth.yandex.ru/client/new/id/';
      expect(find.text(creationUrl), findsOneWidget);
      expect(find.text('https://oauth.yandex.ru/verification_code'), findsOneWidget);
      expect(find.text('cloud_api:disk.read\ncloud_api:disk.info'), findsOneWidget);
      expect(find.textContaining('Client ID and Client secret'), findsOneWidget);
      final link = find.text('Create an application in Yandex OAuth');
      await tester.ensureVisible(link);
      await tester.tap(link);
      await tester.pumpAndSettle();
      expect(launched, [creationUrl]);
      expect(find.byType(AlertDialog), findsOneWidget);
      final events = logs.where((record) => record.loggerName == 'YandexOAuthLink').toList();
      expect(events.first.message, 'event=browserOpenStarted');
      expect(events.last.message, 'event=browserOpenFinished opened=$opened');
      expect(events.last.level, opened ? Level.FINE : Level.WARNING);
      expect(events.every((record) => record.error == null && record.stackTrace == null), isTrue);
      final l = AppLocalizations.of(tester.element(find.byType(AlertDialog)));
      expect(find.text(l.yandex_browser_failed), opened ? findsNothing : findsOneWidget);
      expect(events.map((record) => record.message).join('\n'), isNot(contains(creationUrl)));
      final secret = find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextField)).last;
      await tester.ensureVisible(secret);
      await tester.enterText(secret, 'new-private-secret');
      await tester.pump();
      expect((tester.widget<TextField>(secret)).obscureText, isTrue);
      expect(logs.map((record) => record.message).join('\n'), isNot(contains('new-private-secret')));
      expect(client.commands.every((command) => command.action == DriveAction.state), isTrue);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  }

  test('repository correlates both response IDs and addresses the requested OAuth session to Yandex', () async {
    for (final mismatchedEnvelope in [true, false]) {
      final client = _Realtime((command) => _result(command.copyWith(id: command.id + (mismatchedEnvelope ? 0 : 1))))
        ..envelopeIdOffset = mismatchedEnvelope ? 1 : 0;
      await expectLater(
        YandexDriveRepository(client).request(DriveAction.authorization, sessionId: 'requested-session'),
        throwsA(isA<YandexPanelFailure>().having((failure) => failure.kind, 'kind', YandexPanelFailureKind.load)),
      );
      expect(client.commands, hasLength(1));
      expect(client.commands.single.provider, StorageType.YandexDriveStorage);
      expect(client.commands.single.type, DriveCommand.TYPE);
      expect(client.commands.single.sessionId, 'requested-session');
      expect(client.commands.single.action, DriveAction.authorization);
    }
  });

  test('another panel session edits folders without OAuth or changing another account', () async {
    final client = _Realtime((_) => throw StateError('No network call expected for draft editing'));
    const saved = YandexDriveStorageConfig(
      accounts: [
        YandexDriveAccountConfig(accountId: 'family', label: 'Wife', paths: ['disk:/Old']),
        YandexDriveAccountConfig(accountId: 'other', label: 'Other', paths: ['disk:/Keep']),
      ],
    );
    YandexDriveStorageConfig? edited;
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: saved,
      onChanged: (value) => edited = value,
    );
    addTearDown(cubit.close);

    cubit.setPaths('family', 'Wife', ['disk:/New']);
    final reloaded = YandexDriveStorageConfig.fromJson(edited!.toJson());

    expect(reloaded.accounts.first.accountId, 'family');
    expect(reloaded.accounts.first.paths, ['disk:/New']);
    expect(reloaded.accounts.last, saved.accounts.last);
    expect(saved.accounts.first.paths, ['disk:/Old']);
    expect(client.commands, isEmpty);
  });

  test('closing the authorization dialog during start cancels the returned session', () async {
    final start = Completer<DriveResult>();
    final client = _Realtime((command) {
      if (command.action == DriveAction.startAuthorization) return start.future;
      expect(command.action, DriveAction.cancelAuthorization);
      expect(command.sessionId, 'pending');
      return _result(
        command,
        authorization: const DriveAuthorization(sessionId: 'pending', status: DriveAuthorizationStatus.cancelled),
      );
    });
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: const YandexDriveStorageConfig(),
      onChanged: (_) {},
    );
    addTearDown(cubit.close);
    final operation = cubit.startAuthorization();
    await client.firstRequest.future;
    await cubit.cancelAuthorization();
    start.complete(
      _result(
        client.commands.first,
        authorization: const DriveAuthorization(
          sessionId: 'pending',
          status: DriveAuthorizationStatus.pending,
          userCode: 'private-code',
        ),
      ),
    );
    await operation;

    expect(client.commands.map((command) => command.action), [
      DriveAction.startAuthorization,
      DriveAction.cancelAuthorization,
    ]);
    expect(cubit.state.authorizationOpen, isFalse);
    expect(cubit.state.authorization?.status, DriveAuthorizationStatus.cancelled);
    expect(cubit.state.config.accounts, isEmpty);
  });

  test('page disposal cleans up a late authorization start response', () async {
    final start = Completer<DriveResult>();
    final cancelled = Completer<void>();
    final client = _Realtime((command) {
      if (command.action == DriveAction.startAuthorization) return start.future;
      expect(command.action, DriveAction.cancelAuthorization);
      expect(command.sessionId, 'late-session');
      cancelled.complete();
      return _result(command);
    });
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: const YandexDriveStorageConfig(),
      onChanged: (_) {},
    );
    final operation = cubit.startAuthorization();
    await client.firstRequest.future;
    await cubit.close();
    start.complete(
      _result(
        client.commands.first,
        authorization: const DriveAuthorization(sessionId: 'late-session', status: DriveAuthorizationStatus.pending),
      ),
    );
    await operation;
    await cancelled.future;
    expect(client.commands, hasLength(2));
  });

  test('folder browsing holds one page and retries the failed requested offset', () async {
    var secondPageAttempts = 0;
    final client = _Realtime((command) {
      expect(command.action, DriveAction.folders);
      if (command.offset == 0) {
        return _result(
          command,
          page: const DriveFolderPage(
            path: 'disk:/',
            folders: [DriveFolder(name: 'First', path: 'disk:/First')],
            nextOffset: 100,
          ),
        );
      }
      if (++secondPageAttempts == 1) throw StateError('private-service-url');
      return _result(
        command,
        page: const DriveFolderPage(
          path: 'disk:/',
          offset: 100,
          folders: [DriveFolder(name: 'Second', path: 'disk:/Second')],
        ),
      );
    });
    final cubit = YandexFolderCubit(
      repository: YandexDriveRepository(client),
      accountId: 'family',
      selected: ['disk:/Old'],
    );
    addTearDown(cubit.close);
    await cubit.open('disk:/');
    expect(cubit.state.page!.folders.single.name, 'First');
    await cubit.nextPage();
    expect(cubit.state.failure, YandexPanelFailureKind.load);
    expect(cubit.state.page, isNull);
    await cubit.retry();
    expect(cubit.state.page!.folders.single.name, 'Second');
    expect(cubit.state.selected, {'disk:/Old'});
    expect(client.commands.map((command) => command.offset), [0, 100, 100]);
  });

  test('unknown mutation results are not retried and preserve source diagnostics', () async {
    final client = _Realtime((_) => throw StateError('https://private.example/?access_token=secret'));
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: const YandexDriveStorageConfig(),
      onChanged: (_) {},
    );
    addTearDown(cubit.close);
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(subscription.cancel);
    await cubit.disconnect('family');

    expect(cubit.state.failure, YandexPanelFailureKind.outcomeUnknown);
    expect(client.commands, hasLength(1));
    final messages = records
        .where((record) => record.loggerName == 'YandexSettingsCubit')
        .map((record) => record.message)
        .join('\n');
    expect(messages, contains('event=outcomeUnknown action=disconnectAccount'));
    expect(messages, isNot(contains('private.example')));
    expect(messages, isNot(contains('access_token')));
    final source = records.singleWhere((record) => record.loggerName == 'YandexDriveRepository');
    expect(source.error.toString(), contains('https://private.example/?access_token=secret'));
    expect(source.stackTrace.toString(), contains('yandex_drive_settings_test.dart'));
    expect(records.where((record) => record.error != null), isNotEmpty);
    expect(
      records
          .where((record) => record.error != null)
          .every((record) => record.stackTrace != null && record.stackTrace.toString().isNotEmpty),
      isTrue,
    );
  });

  test('structured backend rejection is not treated as successful application setup', () async {
    final client = _Realtime((command) => _result(command, error: DriveFailure.invalidRequest));
    final cubit = YandexApplicationCubit(repository: YandexDriveRepository(client), clientId: 'application');
    addTearDown(cubit.close);
    cubit.setSecret('private-secret');
    expect(await cubit.save(), isNull);
    expect(cubit.state.failure, YandexPanelFailureKind.rejected);
    expect(cubit.state.toString(), isNot(contains('private-secret')));
  });

  testWidgets('sync progress starts unknown and can decrease as more directory totals are discovered', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var runtime = const DriveRuntime(active: true, running: true);
    final client = _Realtime((command) => _result(command, state: DriveState(runtime: runtime)));
    await tester.pumpWidget(
      _app(
        SingleChildScrollView(
          child: YandexDriveSettings(
            config: const YandexDriveStorageConfig(),
            repository: YandexDriveRepository(client),
            onChanged: (_) {},
          ),
        ),
        textScale: 1.5,
      ),
    );
    await tester.pump();
    expect(find.text('Reading the selected folders…'), findsOneWidget);
    expect(tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator)).value, isNull);
    final cubit = tester.element(find.byType(LinearProgressIndicator)).read<YandexSettingsCubit>();
    runtime = runtime.copyWith(totalItems: 3, processedItems: 2);
    await cubit.load();
    await tester.pump();
    expect(find.text('Processed 2 of approximately 3 items (66%)'), findsOneWidget);
    expect(tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator)).value, closeTo(2 / 3, 0.0001));
    runtime = runtime.copyWith(totalItems: 6);
    await cubit.load();
    await tester.pump();
    expect(find.text('Processed 2 of approximately 6 items (33%)'), findsOneWidget);
    expect(tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator)).value, closeTo(1 / 3, 0.0001));
    runtime = runtime.copyWith(running: false, processedItems: 6);
    await cubit.load();
    await tester.pump();
    expect(find.text('Processed 6 of approximately 6 items (100%)'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    expect(tester.takeException(), isNull);
  });

  testWidgets('runtime polling waits ten seconds, does not overlap and stops after completion', (tester) async {
    final pending = Completer<DriveResult>();
    var reads = 0;
    final client = _Realtime((command) {
      reads++;
      if (reads == 2) return pending.future;
      return _result(
        command,
        state: DriveState(runtime: DriveRuntime(active: true, running: reads < 3)),
      );
    });
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: const YandexDriveStorageConfig(),
      onChanged: (_) {},
    );
    await cubit.load();
    await tester.pump(const Duration(seconds: 9));
    expect(reads, 1);
    await tester.pump(const Duration(seconds: 1));
    expect(reads, 2);
    await tester.pump(const Duration(seconds: 30));
    expect(reads, 2);
    pending.complete(
      _result(client.commands.last, state: const DriveState(runtime: DriveRuntime(active: true, running: true))),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 9));
    expect(reads, 2);
    await tester.pump(const Duration(seconds: 1));
    expect(reads, 3);
    expect(cubit.state.remote!.runtime.running, isFalse);
    await tester.pump(const Duration(seconds: 30));
    expect(reads, 3);
    await cubit.close();
  });

  testWidgets('late runtime poll does not restore an account disconnected by a newer action', (tester) async {
    final poll = Completer<DriveResult>();
    var stateReads = 0;
    final client = _Realtime((command) {
      if (command.action == DriveAction.state && ++stateReads == 2) return poll.future;
      if (command.action == DriveAction.disconnectAccount) {
        return _result(command, state: const DriveState(clientId: 'application'));
      }
      return _result(command, state: _connected.copyWith(runtime: const DriveRuntime(active: true, running: true)));
    });
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: const YandexDriveStorageConfig(),
      onChanged: (_) {},
    );
    await cubit.load();
    expect(cubit.state.failure, isNull);
    expect(cubit.state.remote?.runtime.running, isTrue);
    await tester.pump(const Duration(seconds: 10));
    expect(stateReads, 2);
    await cubit.disconnect('family');
    expect(cubit.state.remote!.connections, isEmpty);
    poll.complete(_result(client.commands[1], state: _connected));
    await tester.pump();
    expect(cubit.state.remote!.connections, isEmpty);
    await cubit.close();
  });

  testWidgets('successful authorization refreshes connections without enabling an unsaved source', (tester) async {
    var draftChanges = 0;
    final client = _Realtime(
      (command) => _result(
        command,
        authorization: DriveAuthorization(
          sessionId: 'pending',
          status: command.action == DriveAction.startAuthorization
              ? DriveAuthorizationStatus.pending
              : DriveAuthorizationStatus.connected,
          accountId: command.action == DriveAction.authorization ? 'family' : null,
        ),
      ),
    );
    final cubit = YandexSettingsCubit(
      repository: YandexDriveRepository(client),
      config: const YandexDriveStorageConfig(),
      onChanged: (_) => draftChanges++,
    );
    await cubit.startAuthorization();
    await tester.pump(const Duration(seconds: 2));
    expect(cubit.state.authorization?.status, DriveAuthorizationStatus.connected);
    expect(cubit.state.remote!.connections.single.accountId, 'family');
    expect(cubit.state.config.accounts, isEmpty);
    expect(draftChanges, 0);
    expect(client.commands.map((command) => command.action), [
      DriveAction.startAuthorization,
      DriveAction.authorization,
    ]);
    await cubit.close();
  });

  testWidgets('connection dialog displays the code and QR and explicitly cancels the pending session', (tester) async {
    final client = _Realtime(
      (command) => _result(
        command,
        authorization: command.action == DriveAction.state
            ? null
            : DriveAuthorization(
                sessionId: 'pending',
                status: command.action == DriveAction.cancelAuthorization
                    ? DriveAuthorizationStatus.cancelled
                    : DriveAuthorizationStatus.pending,
                userCode: 'sample-code',
                verificationUrl: Uri.parse('https://ya.ru/device'),
              ),
      ),
    );
    await tester.pumpWidget(
      _app(
        SingleChildScrollView(
          child: YandexDriveSettings(
            config: const YandexDriveStorageConfig(),
            repository: YandexDriveRepository(client),
            onChanged: (_) {},
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.ensureVisible(find.text('Connect Yandex'));
    await tester.tap(find.text('Connect Yandex'));
    await tester.pumpAndSettle();
    expect(find.text('sample-code'), findsOneWidget);
    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text('https://ya.ru/device'), findsOneWidget);
    expect(find.text('Open Yandex'), findsOneWidget);
    await tester.tap(find.text('Cancel').last);
    await tester.pumpAndSettle();
    expect(client.commands.map((command) => command.action), [
      DriveAction.state,
      DriveAction.startAuthorization,
      DriveAction.cancelAuthorization,
    ]);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('authorization failures explain invalid credentials, scopes and a blocked application before QR', (
    tester,
  ) async {
    for (final failure in [DriveFailure.invalidClient, DriveFailure.invalidScope, DriveFailure.clientUnavailable]) {
      final client = _Realtime(
        (command) => _result(
          command,
          authorization: command.action == DriveAction.startAuthorization
              ? DriveAuthorization(sessionId: 'failed', status: DriveAuthorizationStatus.failed, error: failure)
              : null,
        ),
      );
      await tester.pumpWidget(
        _app(
          SingleChildScrollView(
            child: YandexDriveSettings(
              config: const YandexDriveStorageConfig(),
              repository: YandexDriveRepository(client),
              onChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.ensureVisible(find.text('Connect Yandex'));
      await tester.tap(find.text('Connect Yandex'));
      await tester.pumpAndSettle();
      final l = AppLocalizations.of(tester.element(find.byType(AlertDialog)));
      final message = switch (failure) {
        DriveFailure.invalidClient => l.yandex_authorization_invalid_client,
        DriveFailure.invalidScope => l.yandex_authorization_invalid_scope,
        _ => l.yandex_authorization_client_unavailable,
      };
      expect(find.text(message), findsOneWidget);
      expect(find.text(l.yandex_authorization_failed), findsNothing);
      expect(find.byType(QrImageView), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('Yandex storage starts with a 60 minute draft period', (tester) async {
    final client = _Realtime((command) => _result(command));
    final config = AppConfig.fromJson({}).storages..selected = StorageType.YandexDriveStorage;
    await tester.pumpWidget(_app(StorageSettingsPage(config: config, yandexRepository: YandexDriveRepository(client))));
    await tester.pump();
    final field = find.widgetWithText(TextFormField, 'Sync period');
    final edit = tester.widget<EditableText>(find.descendant(of: field, matching: find.byType(EditableText)));
    expect(edit.controller.text, '60');
    await tester.enterText(field, '120');
    expect(
      config.getOrCreateEmpty<YandexDriveStorageConfig>(StorageType.YandexDriveStorage).syncPeriod,
      const Duration(hours: 2),
    );
    expect(client.commands.map((command) => command.action), [DriveAction.state]);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('folder picker remains usable on a compact phone and preserves initial selections', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final client = _Realtime(
      (command) => _result(
        command,
        page: const DriveFolderPage(
          path: 'disk:/',
          folders: [DriveFolder(name: 'Camera', path: 'disk:/Camera')],
        ),
      ),
    );
    final cubit = YandexFolderCubit(
      repository: YandexDriveRepository(client),
      accountId: 'family',
      selected: ['disk:/Old'],
    );
    await cubit.open('disk:/');
    List<String>? chosen;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              chosen = await showDialog<List<String>>(
                context: context,
                builder: (_) => BlocProvider.value(value: cubit, child: const YandexFolderDialog()),
              );
            },
            child: const Text('Open folders'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open folders'));
    await tester.pumpAndSettle();
    final row = find.ancestor(of: find.text('Camera'), matching: find.byType(ListTile));
    await tester.tap(find.descendant(of: row, matching: find.byType(Checkbox)));
    await tester.pump();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Use selected folders'));
    await tester.pumpAndSettle();
    expect(chosen, ['disk:/Camera', 'disk:/Old']);
    expect(client.commands.map((command) => command.action), [DriveAction.folders]);
    await cubit.close();
  });

  testWidgets('an already connected account can be edited without starting authorization', (tester) async {
    final client = _Realtime(
      (command) => command.action == DriveAction.folders
          ? _result(
              command,
              page: const DriveFolderPage(
                path: 'disk:/',
                folders: [DriveFolder(name: 'Camera', path: 'disk:/Camera')],
              ),
            )
          : _result(command),
    );
    YandexDriveStorageConfig? edited;
    await tester.pumpWidget(
      _app(
        SingleChildScrollView(
          child: YandexDriveSettings(
            repository: YandexDriveRepository(client),
            config: const YandexDriveStorageConfig(
              accounts: [YandexDriveAccountConfig(accountId: 'family', label: 'Wife')],
            ),
            onChanged: (value) => edited = value,
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.ensureVisible(find.text('Choose folders'));
    await tester.tap(find.text('Choose folders'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select this folder'));
    await tester.pump();
    await tester.tap(find.text('Use selected folders'));
    await tester.pumpAndSettle();
    expect(edited!.accounts.single.paths, ['disk:/']);
    expect(edited!.accounts.single.accountId, 'family');
    expect(client.commands.every((command) => command.action != DriveAction.startAuthorization), isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
