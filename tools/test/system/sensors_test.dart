import 'dart:async';
import 'dart:io';

import 'package:dslideshow_tools/src/repository.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final script = p.join(
    findRepository().path,
    'deb_factory/template_build_arm64/opt/dslideshow/scripts/sensorsScript.sh',
  );
  const temperature = "temp=57.1'C\n";
  late Directory root;
  late Map<String, String> env;
  late File command;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('sensors fixture ');
    command = File(p.join(root.path, 'bin/vcgencmd'));
    await command.parent.create();
    await command.writeAsString(r'''#!/bin/sh
[ "$#" -eq 1 ] && [ "$1" = measure_temp ] || exit 99
printf '%s' "$MOCK_TEMPERATURE"
printf '%s' "$MOCK_TEMPERATURE_ERROR" >&2
exit "$MOCK_TEMPERATURE_STATUS"
''');
    await Process.run('chmod', ['755', command.path]);
    env = {
      'DSLIDESHOW_SYSFS_ROOT': p.join(root.path, 'sys'),
      'PATH': command.parent.path,
      'MOCK_TEMPERATURE': temperature,
      'MOCK_TEMPERATURE_ERROR': '',
      'MOCK_TEMPERATURE_STATUS': '0',
    };
  });
  tearDown(() => root.delete(recursive: true));
  Future<Directory> hwmon({
    String number = '2',
    String name = 'pwmfan\n',
    String? rpm = '4611\n',
    bool board = true,
  }) async {
    final directory = Directory(
      p.join(root.path, 'sys/devices/platform', board ? 'cooling_fan' : 'another_fan', 'hwmon/hwmon$number'),
    );
    await directory.create(recursive: true);
    await File(p.join(directory.path, 'name')).writeAsString(name);
    if (rpm != null) await File(p.join(directory.path, 'fan1_input')).writeAsString(rpm);
    return directory;
  }

  Future<ProcessResult> run() => Process.run('/bin/sh', [script], environment: env).timeout(const Duration(seconds: 5));
  void check(ProcessResult result, String output, {int code = 0, bool? diagnostic = false}) {
    expect(result.exitCode, code, reason: '${result.stderr}');
    expect(result.stdout, output);
    if (diagnostic != null) expect('${result.stderr}'.isNotEmpty, diagnostic);
  }

  for (final value in ['4611', '0', '0000', '18446744073709551616']) {
    test('RPM preserves exact digits $value', () async {
      await hwmon(rpm: '$value\n');
      check(await run(), '${temperature}fan1=${value}rpm\n');
    });
  }
  test('accepts no final LF and arbitrary hwmon index', () async {
    await hwmon(number: '137', rpm: '1280');
    check(await run(), '${temperature}fan1=1280rpm\n');
  });
  test('missing fan and attribute are optional', () async {
    check(await run(), temperature);
    await hwmon(rpm: null);
    check(await run(), temperature);
  });
  test('only the board pwmfan is selected', () async {
    await hwmon(number: '1', name: 'unrelated\n', rpm: '9999\n');
    await hwmon(number: '91', rpm: '2050\n');
    await hwmon(rpm: '1234\n', board: false);
    final foreign = Directory(p.join(root.path, 'sys/class/hwmon/hwmon0'));
    await foreign.create(recursive: true);
    await File(p.join(foreign.path, 'name')).writeAsString('pwmfan\n');
    await File(p.join(foreign.path, 'fan1_input')).writeAsString('8888\n');
    check(await run(), '${temperature}fan1=2050rpm\n');
  });
  test('other hardware does not publish board RPM', () async {
    await hwmon(board: false);
    check(await run(), temperature);
  });
  for (final secondInput in ['5678\n', null]) {
    test('ambiguous fans are rejected, second input $secondInput', () async {
      await hwmon(number: '1');
      await hwmon(number: '7', rpm: secondInput);
      check(await run(), temperature, diagnostic: true);
    });
  }
  for (final invalid in [
    '',
    '\n',
    'abc\n',
    '-1\n',
    '+1\n',
    '1.5\n',
    '12rpm\n',
    ' 12\n',
    '12 \n',
    '12\r\n',
    '١٢\n',
    '12\n34\n',
    '12\n\n',
    '12\n34',
  ]) {
    test('invalid RPM ${invalid.codeUnits} never becomes zero', () async {
      await hwmon(rpm: invalid);
      check(await run(), temperature, diagnostic: true);
    });
  }
  for (final invalid in ['pwmfan\nextra\n', 'pwmfan\n\n', '', '\n']) {
    test('invalid device name ${invalid.codeUnits}', () async {
      await hwmon(name: invalid);
      check(await run(), temperature, diagnostic: null);
    });
  }
  test('open failure retains temperature', () async {
    final device = await hwmon(rpm: null);
    await Directory(p.join(device.path, 'fan1_input')).create();
    check(await run(), temperature, diagnostic: true);
  });
  test('unreadable RPM reports a failure without fabricated zero', () async {
    final device = await hwmon();
    final rpm = File(p.join(device.path, 'fan1_input'));
    await Process.run('chmod', ['000', rpm.path]);
    addTearDown(() => Process.run('chmod', ['600', rpm.path]));
    final accessible = await Process.run('/bin/sh', ['-c', r'test -r "$1"', 'fixture', rpm.path]);
    if (accessible.exitCode == 0) {
      markTestSkipped('Effective user bypasses fixture permissions');
      return;
    }
    check(await run(), temperature, diagnostic: true);
  });
  for (final beforeOpen in [true, false]) {
    test('FIFO disappearing ${beforeOpen ? 'before open' : 'during read'} preserves other sources', () async {
      final device = await hwmon(rpm: beforeOpen ? '4611\n' : null);
      final attribute = File(p.join(device.path, beforeOpen ? 'name' : 'fan1_input'));
      if (attribute.existsSync()) await attribute.delete();
      expect((await Process.run('mkfifo', [attribute.path])).exitCode, 0);
      final process = await Process.start('/bin/sh', [script], environment: env);
      addTearDown(() {
        process.kill(ProcessSignal.sigkill);
      });
      final output = process.stdout.transform(const SystemEncoding().decoder).join();
      final errors = process.stderr.transform(const SystemEncoding().decoder).join();
      // Shell opens the FIFO O_WRONLY (Dart FileMode.write also opens for read),
      // so this mutation is gated by the collector's actual open, without sleeps.
      final mutate = await Process.run('/bin/sh', [
        '-c',
        beforeOpen
            ? r'''exec 3>"$1"; printf 'pwmfan\n' >&3; /bin/rm "$2"; exec 3>&-'''
            : r'''exec 3>"$1"; /bin/rm "$1"; exec 3>&-''',
        'fixture',
        attribute.path,
        p.join(device.path, 'fan1_input'),
      ]).timeout(const Duration(seconds: 5));
      expect(mutate.exitCode, 0, reason: '${mutate.stderr}');
      check(
        ProcessResult(
          process.pid,
          await process.exitCode.timeout(const Duration(seconds: 5)),
          await output,
          await errors,
        ),
        temperature,
        diagnostic: !beforeOpen,
      );
    });
  }
  test('arbitrary temperature lines and successful stderr survive', () async {
    env['MOCK_TEMPERATURE'] = '${temperature}button0=false\nhuman1=detected\n';
    env['MOCK_TEMPERATURE_ERROR'] = 'fixture warning\n';
    await hwmon(rpm: '2000\n');
    final result = await run();
    check(result, '${env['MOCK_TEMPERATURE']}fan1=2000rpm\n', diagnostic: true);
    expect(result.stderr, contains('fixture warning'));
  });
  for (final failure in ['missing', 'failed', 'empty']) {
    test('$failure temperature keeps valid fan and fails without another source', () async {
      if (failure == 'missing') await command.delete();
      if (failure == 'failed') {
        env['MOCK_TEMPERATURE_STATUS'] = '7';
        env['MOCK_TEMPERATURE'] = 'partial=bad\n';
      }
      if (failure == 'empty') env['MOCK_TEMPERATURE'] = '';
      check(await run(), '', code: 1, diagnostic: true);
      await hwmon(rpm: '0\n');
      check(await run(), 'fan1=0rpm\n', diagnostic: true);
    });
  }
  test('both failed sources publish no measurement', () async {
    await hwmon(rpm: 'invalid\n');
    env['MOCK_TEMPERATURE_STATUS'] = '4';
    check(await run(), '', code: 1, diagnostic: true);
  });
}
