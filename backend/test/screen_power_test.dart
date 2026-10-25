import 'dart:async';
import 'dart:io';

import 'package:dpms/dpms.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_power.dart';
import 'package:test/test.dart';

final class RecordingDpms extends Dpms {
  final calls = <PowerMode>[];
  bool fail = false;
  @override
  void setMode(PowerMode mode) {
    calls.add(mode);
    if (fail) throw const DpmsException('setMode', 5);
  }

  @override
  PowerMode getMode() => calls.last;
}

void main() {
  final config = HardwareConfig.fromJson({});

  test('waits for script completion before calling DPMS', () async {
    final completion = Completer<ProcessResult>();
    final dpms = RecordingDpms();
    final scripts = <String>[];
    final power = SystemScreenPower(
      config,
      runScript: (script) {
        scripts.add(script);
        return completion.future;
      },
      getDpms: () => dpms,
    );
    final result = power.setPower(false);
    expect(scripts, [config.screenPowerOffScript]);
    expect(dpms.calls, isEmpty);
    completion.complete(ProcessResult(1, 0, '', ''));
    await result;
    expect(dpms.calls, [PowerMode.off]);
  });

  test('legacy script failure still permits successful KMS DPMS', () async {
    final dpms = RecordingDpms();
    final power = SystemScreenPower(
      config,
      runScript: (_) async =>
          ProcessResult(1, 127, '', 'tvservice unavailable'),
      getDpms: () => dpms,
    );
    await power.setPower(true);
    expect(dpms.calls, [PowerMode.on]);
  });

  test('script launch failure still permits successful DPMS', () async {
    final dpms = RecordingDpms();
    final power = SystemScreenPower(
      config,
      runScript: (_) async => throw const ProcessException('script', []),
      getDpms: () => dpms,
    );
    await power.setPower(false);
    expect(dpms.calls, [PowerMode.off]);
  });

  test('DPMS failure is propagated even after a successful script', () async {
    final dpms = RecordingDpms()..fail = true;
    final power = SystemScreenPower(
      config,
      runScript: (_) async => ProcessResult(1, 0, '', ''),
      getDpms: () => dpms,
    );
    await expectLater(power.setPower(true), throwsA(isA<DpmsException>()));
  });

  test('without DPMS the script result determines success', () async {
    final success = SystemScreenPower(
      config,
      runScript: (_) async => ProcessResult(1, 0, '', ''),
      getDpms: () => null,
    );
    await success.setPower(false);
    final failure = SystemScreenPower(
      config,
      runScript: (_) async => ProcessResult(1, 3, '', 'failure'),
      getDpms: () => null,
    );
    await expectLater(
      failure.setPower(false),
      throwsA(
        isA<ProcessException>().having((e) => e.errorCode, 'exit code', 3),
      ),
    );
    final missing = SystemScreenPower(
      config,
      runScript: (_) async => throw const ProcessException('missing', []),
      getDpms: () => null,
    );
    await expectLater(missing.setPower(true), throwsA(isA<ProcessException>()));
  });

  test(
    'real harmless process execution checks exit code, without display access',
    () async {
      final config = HardwareConfig.fromJson({
        'screenPowerOnScript': '/bin/true',
        'screenPowerOffScript': '/bin/false',
      });
      final power = SystemScreenPower(config, getDpms: () => null);
      await power.setPower(true);
      await expectLater(
        power.setPower(false),
        throwsA(
          isA<ProcessException>().having((e) => e.errorCode, 'exit code', 1),
        ),
      );
    },
  );
}
