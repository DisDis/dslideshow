import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/hardware_fixture.dart';
import 'support/wifi_process_runner.dart';

void main() {
  for (final command in <RpcCommand>[
    const WiFiRescanCommand(id: 7001),
    const WiFiAddCommand(id: 7002, name: 'test', SSID: 'test', psk: 'private-password'),
    const WiFiRemoveCommand(id: 7003, connectionId: 'connection-id'),
  ]) {
    test('${command.type} acknowledges only the completed system operation', () async {
      final runner = ControlledWiFiProcessRunner();
      final wifi = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
      final fixture = HardwareFixture(wifi: wifi);
      addTearDown(() async {
        await fixture.close();
        await fixture.mqtt.close();
      });
      var replied = false;
      final response = fixture.hardware.executeCommand(command)..then((_) => replied = true);
      expect(runner.calls, hasLength(1));
      expect(replied, isFalse);
      runner.pending.single.complete(ProcessResult(1, 0, '', ''));
      expect(await response, EmptyResult(id: command.id));
      expect(runner.calls, hasLength(1), reason: 'there is no automatic mutation retry');
    });
  }

  for (final (name, fail) in <(String, void Function(Completer<ProcessResult>))>[
    ('launch', (pending) => pending.completeError(ProcessException('sudo', ['private-password'], 'private output', 2))),
    ('exit code', (pending) => pending.complete(ProcessResult(1, 10, 'private-password', 'private output'))),
    ('timeout', (pending) => pending.completeError(TimeoutException('private-password'))),
  ]) {
    test(
      '$name failure keeps the source RPC id and original failure diagnostics',
      () => captureLogs((records) async {
        final runner = ControlledWiFiProcessRunner();
        final wifi = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
        final fixture = HardwareFixture(wifi: wifi);
        addTearDown(() async {
          await fixture.close();
          await fixture.mqtt.close();
        });
        const command = WiFiAddCommand(id: 7010, name: 'test', SSID: 'test', psk: 'private-password');
        final response = fixture.hardware.executeCommand(command);
        fail(runner.pending.single);
        final result = await response;
        expect(result, isA<RpcErrorResult>());
        expect(result.id, command.id);
        expect(result.toString(), isNot(contains('private-password')));
        expect(result.toString(), isNot(contains('private output')));
        final failures = records.where(
          (record) => record.loggerName == 'HardwareService' && record.message.startsWith('event=wifiFailed '),
        );
        expect(failures.single.message, contains('rpcId=7010'));
        expect(failures.single.error, isNotNull);
        expect(failures.single.stackTrace, isNotNull);
        for (final record in records.where(
          (record) => record.loggerName == 'WiFiService' || record.loggerName == 'HardwareService',
        )) {
          if (record.error != null) expect(record.stackTrace, isNotNull);
        }
      }),
    );
  }

  for (final command in <RpcCommand>[const WiFiListCommand(id: 7020), const WiFiGetConnectionsCommand(id: 7021)]) {
    test('${command.type} does not replace a system failure with an empty list', () async {
      final runner = ControlledWiFiProcessRunner();
      final wifi = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
      final fixture = HardwareFixture(wifi: wifi);
      addTearDown(() async {
        await fixture.close();
        await fixture.mqtt.close();
      });
      final response = fixture.hardware.executeCommand(command);
      runner.pending.single.complete(ProcessResult(1, 4, '', 'private output'));
      final result = await response;
      expect(result, isA<RpcErrorResult>());
      expect(result.id, command.id);
    });
  }

  test('hardware disposal waits for Wi-Fi cleanup and rejects late success', () async {
    final runner = ControlledWiFiProcessRunner()..cleanup = Completer<void>();
    final wifi = WiFiService(WiFiConfig.fromJson({}), commandRunner: runner);
    final fixture = HardwareFixture(wifi: wifi);
    addTearDown(() async {
      if (!runner.cleanup!.isCompleted) runner.cleanup!.complete();
      await fixture.close();
      await fixture.mqtt.close();
    });
    const command = WiFiRescanCommand(id: 7030);
    var replied = false;
    final response = fixture.hardware.executeCommand(command)..then((_) => replied = true);
    var disposed = false;
    final closing = fixture.close()..then((_) => disposed = true);
    await runner.closeStarted.future.timeout(const Duration(seconds: 2));
    expect(disposed, isFalse);
    expect(replied, isFalse);
    runner.cleanup!.complete();
    await closing;
    expect(await response, isA<RpcErrorResult>());
    expect((await response).id, command.id);
    expect(identical(wifi.close(), wifi.close()), isTrue);
    expect(await fixture.hardware.executeCommand(const WiFiRescanCommand(id: 7031)), isA<RpcErrorResult>());
    expect(runner.calls, hasLength(1));
  });
}
