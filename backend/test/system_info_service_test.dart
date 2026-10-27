import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/system_info/system_command_runner.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

const _memory = '''
MemTotal:       8000000 kB
MemFree:          10000 kB
MemAvailable:   3000000 kB
SwapTotal:      1000000 kB
SwapFree:        800000 kB
''';

class _Runner implements SystemCommandRunner {
  final calls = <String>[];
  int closed = 0;
  Future<ProcessResult> Function(String, List<String>)? onRun;

  int count(String command) => calls.where((call) => call == command).length;

  @override
  Future<ProcessResult> run(
    String executable,
    List<String> arguments, {
    Map<String, String>? environment,
  }) async {
    expect(environment, {'LC_ALL': 'C'});
    final command = [executable, ...arguments].join(' ');
    calls.add(command);
    if (onRun != null) return onRun!(executable, arguments);
    return response(executable, arguments);
  }

  ProcessResult response(String executable, List<String> arguments) {
    final command = [executable, ...arguments].join(' ');
    final output = switch (command) {
      'df' => '/dev/mmcblk0p2 10000 2000 8000 20% /\n',
      'uptime -p' => 'up 2 weeks, 1 day, 3 hours, 4 minutes\n',
      'free' => 'Mem: 800 500 300\nSwap: 100 20 80\n',
      'nproc --all' => '4\n',
      'uname -a' => 'Linux test 1\n',
      'ifconfig' =>
        'eth0: flags=4163<UP,BROADCAST,RUNNING> mtu 1500\n'
            '    inet 192.0.2.1 netmask 255.255.255.0\n',
      'ping -c 1 8.8.8.8' => '0% packet loss\n',
      './scripts/sensorsScript.sh' =>
        "temp=61.3'C\nfan1=0rpm\n"
            'button=false\nhuman=detected\ncustom=hello world\ninvalid\n',
      _ => throw StateError('Unexpected command $command'),
    };
    return ProcessResult(1, 0, output, '');
  }

  @override
  Future<void> close() async {
    closed++;
  }
}

class _Fixture {
  final runner = _Runner();
  final config = HardwareConfig.fromJson({});
  Duration tick = Duration.zero;
  DateTime wall = DateTime.fromMillisecondsSinceEpoch(1000000);
  final reads = <String>[];
  final files = <String, String>{
    '/proc/meminfo': _memory,
    '/proc/loadavg': '0.25 0.50 0.75 1/100 123\n',
    '/proc/cpuinfo':
        'Hardware : Known hardware\n'
        'Revision : 123\nModel : Known CPU\n',
  };
  Future<String> Function(String)? overrideRead;
  late final SystemInfoService service = SystemInfoService(
    config,
    commandRunner: runner,
    monotonicClock: () => tick,
    wallClock: () => wall,
    readFile: (path) async {
      reads.add(path);
      if (overrideRead != null) return overrideRead!(path);
      return files[path] ?? (throw FileSystemException('Missing', path));
    },
  );

  void advance(Duration duration) {
    tick += duration;
    wall = wall.add(duration);
  }
}

void main() {
  group('SystemInfoService', () {
    late _Fixture fixture;
    setUp(() => fixture = _Fixture());
    tearDown(() => fixture.service.release());

    test(
      'preserves units, pretty uptime and arbitrary sensor values',
      () async {
        final info = await fixture.service.getFullInfo();
        final update = info.updateInfo;
        expect(update.memTotal, 8000000);
        expect(update.memUsed, 5000000);
        expect(update.swapTotal, 1000000);
        expect(update.swapUsed, 200000);
        expect(update.diskUsed, 2000);
        expect(update.diskAvailable, 8000);
        expect(update.diskUsedPercent, 20);
        expect(update.cpuLoad1, 0.25);
        expect(update.cpuLoad5, 0.5);
        expect(update.cpuLoad15, 0.75);
        expect(update.uptime, 'up 2 weeks, 1 day, 3 hours, 4 minutes\n');
        expect(update.lastUpdate, fixture.wall.millisecondsSinceEpoch);
        expect(
          {for (final sensor in update.sensors) sensor.name: sensor.value},
          {
            'temp': "61.3'C",
            'fan1': '0rpm',
            'button': 'false',
            'human': 'detected',
            'custom': 'hello world',
          },
        );
        expect(info.cpuInfo.cores, 4);
        expect(info.cpuInfo.model.trim(), 'Known CPU');
        expect(info.cpuInfo.hardware.trim(), 'Known hardware');
        expect(info.cpuInfo.revision.trim(), '123');
        expect(info.networkInfo.interfaces!.single.ip4, '192.0.2.1');
        expect(info.networkInfo.hasInternet, isTrue);
        expect(fixture.runner.count('cat /proc/loadavg'), 0);
        expect(fixture.runner.count('cat /proc/cpuinfo'), 0);
        expect(fixture.runner.count('free'), 0);
      },
    );

    test('shares concurrent full and update collections', () async {
      final gate = Completer<ProcessResult>();
      fixture.runner.onRun = (executable, arguments) async {
        if (executable == 'df') return gate.future;
        return fixture.runner.response(executable, arguments);
      };
      final first = fixture.service.getFullInfo();
      final second = fixture.service.getFullInfo();
      final update = fixture.service.getUpdateInfo();
      final otherUpdate = fixture.service.getUpdateInfo();
      expect(identical(first, second), isTrue);
      expect(identical(update, otherUpdate), isTrue);
      gate.complete(fixture.runner.response('df', []));
      final results = await Future.wait([first, second]);
      expect(await update, results.first.updateInfo);
      expect(await otherUpdate, results.first.updateInfo);
      expect(fixture.runner.count('df'), 1);
      expect(fixture.runner.count('nproc --all'), 1);
      expect(fixture.runner.count('ifconfig'), 1);
    });

    test(
      'disk parser treats configured prefixes literally across updates',
      () async {
        const firstDevice = r'/dev/disk[1].+$';
        const secondDevice = '/dev/mapper/system (root)';
        fixture.config.systemDiskDev = firstDevice;
        fixture.runner.onRun = (executable, arguments) async {
          if (executable == 'df') {
            return ProcessResult(
              1,
              0,
              '$firstDevice 10000 2000 8000 20% /\n'
                  '$secondDevice 5000 3000 2000 60% /other\n',
              '',
            );
          }
          return fixture.runner.response(executable, arguments);
        };
        final first = await fixture.service.getUpdateInfo();
        expect(first.diskUsed, 2000);
        expect(first.diskAvailable, 8000);
        expect(first.diskUsedPercent, 20);
        fixture.config.systemDiskDev = secondDevice;
        fixture.advance(const Duration(seconds: 2));
        final second = await fixture.service.getUpdateInfo();
        expect(second.diskUsed, 3000);
        expect(second.diskAvailable, 2000);
        expect(second.diskUsedPercent, 60);
      },
    );

    test(
      'retains partial sensor data and logs successful diagnostics',
      () async {
        final warnings = <LogRecord>[];
        final subscription = Logger.root.onRecord.listen((record) {
          if (record.loggerName == 'SystemInfoService' &&
              record.level == Level.WARNING) {
            warnings.add(record);
          }
        });
        addTearDown(subscription.cancel);
        fixture.runner.onRun = (executable, arguments) async {
          if (executable == './scripts/sensorsScript.sh') {
            return ProcessResult(
              1,
              0,
              "temp=61.3'C\ncustom=hello world\n",
              'Cannot read fan tachometer\n',
            );
          }
          return fixture.runner.response(executable, arguments);
        };
        final info = await fixture.service.getUpdateInfo();
        expect(
          {for (final sensor in info.sensors) sensor.name: sensor.value},
          {'temp': "61.3'C", 'custom': 'hello world'},
        );
        expect(warnings, hasLength(1));
        expect(warnings.single.message, contains('Cannot read fan tachometer'));
      },
    );

    test(
      'refresh replaces positive and zero RPM with absent sensor data',
      () async {
        var fan = 'fan1=4611rpm\n';
        fixture.runner.onRun = (executable, arguments) async {
          if (executable == './scripts/sensorsScript.sh') {
            return ProcessResult(
              1,
              0,
              "temp=61.3'C\n${fan}custom=hello world\n",
              '',
            );
          }
          return fixture.runner.response(executable, arguments);
        };

        final positive = await fixture.service.getUpdateInfo();
        expect(
          positive.sensors.singleWhere((sensor) => sensor.name == 'fan1').value,
          '4611rpm',
        );
        fan = 'fan1=0rpm\n';
        fixture.advance(const Duration(seconds: 1));
        final stopped = await fixture.service.getUpdateInfo();
        expect(
          stopped.sensors.singleWhere((sensor) => sensor.name == 'fan1').value,
          '0rpm',
        );
        fan = '';
        fixture.advance(const Duration(seconds: 1));
        final absent = await fixture.service.getUpdateInfo();
        expect(
          {for (final sensor in absent.sensors) sensor.name: sensor.value},
          {'temp': "61.3'C", 'custom': 'hello world'},
        );
        expect(fixture.runner.count('./scripts/sensorsScript.sh'), 3);
      },
    );

    test(
      'rejects failed sensor stdout and logs the failure only once',
      () async {
        final warnings = <LogRecord>[];
        final subscription = Logger.root.onRecord.listen((record) {
          if (record.loggerName == 'SystemInfoService' &&
              record.level == Level.WARNING) {
            warnings.add(record);
          }
        });
        addTearDown(subscription.cancel);
        fixture.runner.onRun = (executable, arguments) async {
          if (executable == './scripts/sensorsScript.sh') {
            return ProcessResult(
              1,
              1,
              'fan1=4611rpm\n',
              'Sensor collection failed\n',
            );
          }
          return fixture.runner.response(executable, arguments);
        };
        expect((await fixture.service.getUpdateInfo()).sensors, isEmpty);
        expect(warnings, hasLength(1));
        expect(warnings.single.message, contains('exited 1'));
        expect(warnings.single.message, contains('Sensor collection failed'));
      },
    );

    test(
      'one second TTL starts at completion and uses monotonic time',
      () async {
        final gate = Completer<ProcessResult>();
        fixture.runner.onRun = (executable, arguments) async {
          if (executable == 'df' && !gate.isCompleted) return gate.future;
          return fixture.runner.response(executable, arguments);
        };
        final pending = fixture.service.getUpdateInfo();
        fixture.advance(const Duration(seconds: 10));
        gate.complete(fixture.runner.response('df', []));
        final first = await pending;
        fixture.advance(const Duration(milliseconds: 999));
        fixture.wall = DateTime.fromMillisecondsSinceEpoch(1);
        final cached = await fixture.service.getUpdateInfo();
        expect(identical(cached, first), isTrue);
        expect(cached.lastUpdate, first.lastUpdate);
        expect(fixture.runner.count('df'), 1);
        fixture.advance(const Duration(milliseconds: 1));
        final refreshed = await fixture.service.getUpdateInfo();
        expect(refreshed.lastUpdate, fixture.wall.millisecondsSinceEpoch);
        expect(fixture.runner.count('df'), 2);
        expect(fixture.runner.count('free --version'), 0);
      },
    );

    test(
      'retains CPU/OS and refreshes network only after its minute TTL',
      () async {
        final first = await fixture.service.getFullInfo();
        fixture.advance(const Duration(seconds: 1));
        await fixture.service.getFullInfo();
        fixture.advance(const Duration(seconds: 58));
        await fixture.service.getFullInfo();
        expect(fixture.runner.count('ifconfig'), 1);
        fixture.advance(const Duration(seconds: 1));
        final last = await fixture.service.getFullInfo();
        expect(fixture.runner.count('ifconfig'), 2);
        expect(fixture.runner.count('ping -c 1 8.8.8.8'), 2);
        expect(fixture.runner.count('nproc --all'), 1);
        expect(fixture.runner.count('uname -a'), 1);
        expect(last.cpuInfo, first.cpuInfo);
        expect(last.osInfo, first.osInfo);
      },
    );

    test('reads Linux memory directly without checking free version', () async {
      final first = await fixture.service.getUpdateInfo();
      expect(first.memTotal, 8000000);
      expect(first.memUsed, 5000000);
      expect(fixture.reads, contains('/proc/meminfo'));
      fixture.advance(const Duration(seconds: 1));
      await fixture.service.getUpdateInfo();
      expect(fixture.runner.count('free'), 0);
      expect(fixture.runner.count('free --version'), 0);
    });

    for (final entry in {
      'missing fields': 'MemTotal: 8000000 kB\n',
      'wrong units': _memory.replaceFirst('8000000 kB', '8000000 MB'),
      'negative used': _memory.replaceFirst('3000000 kB', '9000000 kB'),
      'invalid swap': _memory.replaceFirst('800000 kB', '2000000 kB'),
    }.entries) {
      test('falls back to free for ${entry.key}', () async {
        fixture.files['/proc/meminfo'] = entry.value;
        final info = await fixture.service.getUpdateInfo();
        expect(info.memTotal, 800);
        expect(info.memUsed, 500);
        expect(info.swapTotal, 100);
        expect(info.swapUsed, 20);
        expect(fixture.runner.count('free'), 1);
      });
    }

    test('falls back to free on an unreadable meminfo', () async {
      fixture.files.remove('/proc/meminfo');
      expect((await fixture.service.getUpdateInfo()).memTotal, 800);
      expect(fixture.runner.count('free'), 1);
    });

    test('zero swap and zero load remain valid measurements', () async {
      fixture.files['/proc/meminfo'] = _memory
          .replaceFirst('1000000 kB', '0 kB')
          .replaceFirst('800000 kB', '0 kB');
      fixture.files['/proc/loadavg'] = '0 0 0 1/10 123\n';
      final info = await fixture.service.getUpdateInfo();
      expect(info.swapTotal, 0);
      expect(info.swapUsed, 0);
      expect(info.cpuLoad1, 0);
      expect(info.cpuLoad5, 0);
      expect(info.cpuLoad15, 0);
    });

    test('nonzero command statuses retain existing defaults', () async {
      fixture.runner.onRun = (_, __) async => ProcessResult(1, 1, '', 'error');
      fixture.files.remove('/proc/loadavg');
      fixture.files.remove('/proc/meminfo');
      final info = await fixture.service.getUpdateInfo();
      expect(info.cpuLoad1, 1);
      expect(info.cpuLoad5, 1);
      expect(info.cpuLoad15, 1);
      expect(info.memTotal, 1);
      expect(info.memUsed, 1);
      expect(info.swapTotal, 1);
      expect(info.swapUsed, 1);
      expect(info.diskUsed, 0);
      expect(info.diskAvailable, 0);
      expect(info.diskUsedPercent, 0);
      expect(info.uptime, '');
      expect(info.sensors, isEmpty);
      fixture.advance(const Duration(milliseconds: 999));
      expect(await fixture.service.getUpdateInfo(), info);
      expect(fixture.runner.count('df'), 1);
    });

    test('keeps existing source grouping after command failure', () async {
      fixture.runner.onRun = (executable, arguments) async {
        if (executable == 'df') throw TimeoutException('df');
        return fixture.runner.response(executable, arguments);
      };
      final info = await fixture.service.getUpdateInfo();
      expect(info.diskUsed, 0);
      expect(info.memUsed, 1);
      expect(info.cpuLoad1, 1);
      expect(info.uptime, '');
      expect(info.sensors, isNotEmpty);
      expect(fixture.runner.count('uptime -p'), 0);
    });

    test('malformed free keeps defaults and still collects sensors', () async {
      fixture.files['/proc/meminfo'] = 'incomplete';
      fixture.runner.onRun = (executable, arguments) async {
        if (executable == 'free' && arguments.isEmpty) {
          return ProcessResult(1, 0, 'truncated', '');
        }
        return fixture.runner.response(executable, arguments);
      };
      final info = await fixture.service.getUpdateInfo();
      expect(info.memTotal, 1);
      expect(info.cpuLoad1, 1);
      expect(info.sensors, isNotEmpty);
    });

    test(
      'release returns while a file read is pending and rejects late data',
      () async {
        final reading = Completer<void>();
        final load = Completer<String>();
        fixture.overrideRead = (path) async {
          if (path == '/proc/loadavg') {
            reading.complete();
            return load.future;
          }
          return fixture.files[path]!;
        };
        final pending = fixture.service.getFullInfo();
        final rejected = expectLater(pending, throwsStateError);
        await reading.future;
        await fixture.service.release();
        await fixture.service.release();
        expect(fixture.runner.closed, 1);
        final callsBeforeLateRead = fixture.runner.calls.length;
        load.complete('9 9 9 1/10 1\n');
        await rejected;
        expect(fixture.runner.calls.length, callsBeforeLateRead);
        expect(() => fixture.service.getFullInfo(), throwsStateError);
        expect(() => fixture.service.getUpdateInfo(), throwsStateError);
      },
    );
  }, skip: !Platform.isLinux);
}
