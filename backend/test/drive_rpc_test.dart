import 'package:dslideshow_backend/config.dart' as storage_config show StorageType;

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

class _Target implements RpcService {
  _Target({this.fail = false});
  final bool fail;
  RpcCommand? received;
  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    received = command;
    if (fail) throw StateError('private-secret-in-transport-error');
    return DriveResult(
      id: command.id,
      state: const DriveState(),
      authorization: const DriveAuthorization(
        sessionId: 'private-session',
        status: DriveAuthorizationStatus.pending,
        userCode: 'private-user-code',
      ),
    );
  }
}

void main() {
  test('drive protocol requires a known provider and preserves unknown actions for validation', () {
    const state = {'id': 8, 'provider': 'YandexDriveStorage', 'action': 'state'};
    final command = DriveCommand.fromJson(state);
    expect(command.provider, storage_config.StorageType.YandexDriveStorage);
    expect(command.type, 'drive');
    expect(command.action, DriveAction.state);
    expect(() => DriveCommand.fromJson({'id': 8, 'action': 'state'}), throwsArgumentError);
    expect(() => DriveCommand.fromJson({...state, 'provider': 'unregistered-provider'}), throwsArgumentError);
    expect(DriveCommand.fromJson({...state, 'action': 'unrecognized-action'}).action, DriveAction.unknown);
  });

  test('actual isolate service redacts structured and JSON credential commands at FINE', () async {
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(logs.add);
    try {
      for (final jsonTransport in [false, true]) {
        final commands = ReceivePort();
        final results = ReceivePort();
        final unused = ReceivePort();
        final target = _Target();
        final server = Service(
          commandIPort: commands,
          commanOPort: unused.sendPort,
          resultIPorts: [],
          resultOPorts: [results.sendPort],
        );
        final processing = server.processing(target, serializers);
        const command = DriveCommand(
          provider: storage_config.StorageType.YandexDriveStorage,
          id: 71,
          action: DriveAction.configureApplication,
          clientId: 'application',
          clientSecret: 'private-client-secret',
        );
        final encoded = serializers.serialize(command);
        commands.sendPort.send([0, jsonTransport ? jsonEncode(encoded) : encoded]);
        final rawResult = await results.first;
        final result = serializers.deserialize(
          jsonTransport ? jsonDecode(rawResult as String) as Object : rawResult as Object,
        ) as DriveResult;
        expect(target.received, command);
        expect(result.authorization?.userCode, 'private-user-code');
        commands.sendPort.send(null);
        await processing;
        results.close();
        unused.close();
      }
      expect(logs.any((entry) => entry.loggerName == 'Service' && entry.message.contains('id=71')), isTrue);
      final diagnostic = logs
          .map((entry) => '${entry.message} ${entry.error ?? ''} ${entry.stackTrace ?? ''}')
          .join('\n');
      expect(diagnostic, isNot(contains('private-')));
      expect(
        const DriveCommand(
          provider: storage_config.StorageType.YandexDriveStorage,
          id: 1,
          action: DriveAction.configureApplication,
          clientSecret: 'private-secret',
        ).toString(),
        isNot(contains('private-')),
      );
    } finally {
      await subscription.cancel();
      Logger.root.level = previousLevel;
    }
  });

  test('service execution failure keeps payload out of severe records', () async {
    final logs = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(logs.add);
    final commands = ReceivePort();
    final results = ReceivePort();
    final unused = ReceivePort();
    final error = Completer<Object>();
    late Future processing;
    runZonedGuarded(() {
      final service = Service(
        commandIPort: commands,
        commanOPort: unused.sendPort,
        resultIPorts: [],
        resultOPorts: [results.sendPort],
      );
      processing = service.processing(_Target(fail: true), serializers);
      commands.sendPort.send([
        0,
        serializers.serialize(
          const DriveCommand(provider: storage_config.StorageType.YandexDriveStorage, id: 2, action: DriveAction.state),
        ),
      ]);
    }, (caught, stack) => error.complete(caught));
    expect(await error.future, isA<StateError>());
    commands.sendPort.send(null);
    await processing;
    expect(logs.any((entry) => entry.level == Level.SEVERE && entry.message.contains('type=StateError')), isTrue);
    expect(logs.map((entry) => '${entry.message} ${entry.error ?? ''}').join(' '), isNot(contains('private-secret')));
    results.close();
    unused.close();
    await subscription.cancel();
  });
}
