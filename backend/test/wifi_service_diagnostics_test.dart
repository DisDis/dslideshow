import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/wifi_process_runner.dart';

const _password = 'synthetic-wifi-password';
const _privateOutput = 'private command output';

Future<LogRecord> _finished(String action) => Logger.root.onRecord
    .firstWhere(
      (record) =>
          record.loggerName == 'WiFiService' &&
          record.message.contains('action=$action ') &&
          (record.message.startsWith('event=failed ') || record.message.startsWith('event=completed ')),
    )
    .timeout(const Duration(seconds: 2))
    // Logger uses a synchronous broadcast stream. Continue outside its publish
    // stack before the next command logs another event.
    .then((record) => Future<LogRecord>.microtask(() => record));

void _expectSafe(List<LogRecord> records) {
  final service = records.where((record) => record.loggerName == 'WiFiService');
  for (final record in service) {
    expect(record.error, isNull);
    expect(record.stackTrace, isNull);
    for (final secret in [_password, _privateOutput, 'private-ssid', 'private-name']) {
      expect(record.toString(), isNot(contains(secret)));
    }
  }
}

void _expectActionLogs(List<LogRecord> records, String action) {
  final events = records.where((record) => record.loggerName == 'WiFiService').toList();
  expect(events, hasLength(2));
  expect(events.every((record) => !record.message.contains('operationId=')), isTrue);
  expect(events.first.message, startsWith('event=started '));
  expect(events.first.message, contains('action=$action'));
  expect(events.last.message, contains('action=$action '));
}

void main() {
  for (final launchFails in [true, false]) {
    test(
      'add diagnostics sanitize ${launchFails ? 'launch exception' : 'nonzero exit'} and report failure',
      () => captureLogs((records) async {
        final runner = ControlledWiFiProcessRunner();
        final service = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
        final failed = _finished('add');
        final pending = service.addWiFiConnection('private-name', 'private-ssid', _password);
        final rejected = expectLater(pending, throwsA(isA<Exception>()));
        expect(runner.calls.single.executable, 'sudo');
        expect(runner.calls.single.environment, {'LC_ALL': 'C'});
        expect(runner.calls.single.arguments, contains(_password));
        if (launchFails) {
          runner.pending.single.completeError(
            ProcessException('sudo', runner.calls.single.arguments, _privateOutput, 2),
          );
        } else {
          runner.pending.single.complete(
            ProcessResult(11, 10, '$_privateOutput $_password', '$_privateOutput $_password'),
          );
        }
        final failure = await failed;
        await rejected;
        expect(failure.level, Level.WARNING);
        expect(failure.message, contains(launchFails ? 'reason=launch' : 'reason=exitCode'));
        expect(failure.message, contains(launchFails ? 'code=2' : 'code=10'));
        _expectSafe(records);
        _expectActionLogs(records, 'add');
      }),
    );
  }

  test(
    'connection actions report completion without stdout, stderr or names',
    () => captureLogs((records) async {
      final runner = ControlledWiFiProcessRunner();
      final service = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
      for (final (action, execute) in <(String, Future<void> Function(String))>[
        ('up', service.upConnection),
        ('down', service.downConnection),
        ('delete', service.deleteConnection),
      ]) {
        final completed = _finished(action);
        final operation = execute('private-name');
        runner.pending.last.complete(ProcessResult(11, 0, _privateOutput, _privateOutput));
        expect((await completed).level, Level.INFO);
        await operation;
      }
      _expectSafe(records);
      final serviceRecords = records.where((record) => record.loggerName == 'WiFiService');
      expect(serviceRecords.where((record) => record.message.startsWith('event=completed ')), hasLength(3));
    }),
  );

  test(
    'getConnections propagates only the safe failure boundary',
    () => captureLogs((records) async {
      final runner = ControlledWiFiProcessRunner();
      final service = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
      final result = service.getConnections();
      final expectation = expectLater(
        result,
        throwsA(
          predicate<Object>((error) {
            final text = error.toString();
            return text.contains('connections') &&
                text.contains('code=2') &&
                !text.contains(_password) &&
                !text.contains(_privateOutput);
          }),
        ),
      );
      runner.pending.single.completeError(ProcessException('nmcli', [_password], _privateOutput, 2));
      await expectation;
      _expectSafe(records);
      _expectActionLogs(records, 'connections');
    }),
  );

  test(
    'process output reaches the real parsers and list failures propagate safely',
    () => captureLogs((records) async {
      final runner = ControlledWiFiProcessRunner();
      final service = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
      final scan = service.list(false);
      final scanFailure = expectLater(scan, throwsA(isA<Exception>()));
      expect(runner.calls.last.arguments, ['nmcli', 'device', 'wifi', 'list']);
      runner.pending.last.completeError(ProcessException('sudo', [_password], _privateOutput, 2));
      await scanFailure;

      final connections = service.getConnections();
      expect(runner.calls.last.executable, 'nmcli');
      expect(runner.calls.last.arguments, ['connection', 'show']);
      runner.pending.last.complete(
        ProcessResult(
          11,
          0,
          'NAME  UUID  TYPE  DEVICE\n'
              'Home  abcd  wifi  wlan0\n',
          '',
        ),
      );
      expect(await connections, [const WiFiConnectionInfo(name: 'Home', UUID: 'abcd', type: 'wifi', device: 'wlan0')]);
      _expectSafe(records);
    }),
  );
}
