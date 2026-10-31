import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:fake_async/fake_async.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';

void main() {
  late Directory directory;
  late File file;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('app-storage-');
    file = File(p.join(directory.path, AppStorage.STORAGE_FILE));
  });

  tearDown(() => directory.deleteSync(recursive: true));

  test('missing file gives defaults without creating a file', () {
    final storage = AppStorage(directory.path);
    expect(storage.getRaw('missing'), isNull);
    expect(storage.getValue<String>('missing', 'default'), 'default');
    expect(storage.getValue<bool>('missing', false), isFalse);
    expect(storage.getInt('missing', 17), 17);
    expect(() => storage.getValue<String>('missing'), throwsException);
    expect(file.existsSync(), isFalse);
  });

  test('reads typed values and integer compatibility without coercing types', () {
    file.writeAsStringSync(
      jsonEncode({
        'count': 4,
        'legacyCount': '9',
        'invalidCount': 'nine',
        'enabled': true,
        'text': 'saved',
        'nothing': null,
        'nested': {'position': 2},
      }),
    );
    final storage = AppStorage(directory.path);
    expect(storage.getValue<String>('text'), 'saved');
    expect(storage.getValue<bool>('enabled'), isTrue);
    expect(storage.getInt('count', 0), 4);
    expect(storage.getInt('legacyCount', 0), 9);
    expect(storage.getInt('invalidCount', 7), 7);
    expect(storage.getValue<int>('nothing', 11), 11);
    expect(storage.getRaw('nested'), {'position': 2});
    expect(() => storage.getValue<String>('count'), throwsA(isA<TypeError>()));
    expect(() => storage.getInt('enabled', 0), throwsA(isA<TypeError>()));
  });

  for (final invalid in ['null', '[]', '42', '{"private":"SECRET_CONTENT"']) {
    test('invalid JSON document $invalid recovers to an empty map safely', () async {
      file.writeAsStringSync(invalid);
      await captureLogs((logs) async {
        final storage = AppStorage(directory.path);
        expect(storage.getInt('absent', 5), 5);
        fakeAsync((clock) {
          storage.setValue('recovered', true);
          clock.elapse(const Duration(seconds: 10));
        });
        expect(jsonDecode(file.readAsStringSync()), {'recovered': true});
        final failures = logs.where((log) => log.loggerName == 'AppStorage' && log.level >= Level.WARNING);
        expect(failures, isNotEmpty);
        for (final log in logs) {
          expect('${log.message} ${log.error} ${log.stackTrace}', isNot(contains('SECRET_CONTENT')));
          expect(log.error, isNull);
        }
      });
    });
  }

  test('one ten-second save includes later changes without postponing the deadline', () {
    fakeAsync((clock) {
      final storage = AppStorage(directory.path);
      storage.setValue('position', 1);
      clock.elapse(const Duration(seconds: 9));
      storage.setValue('position', 2);
      storage.setValue('enabled', true);
      expect(file.existsSync(), isFalse);
      clock.elapse(const Duration(milliseconds: 999));
      expect(file.existsSync(), isFalse);
      clock.elapse(const Duration(milliseconds: 1));
      expect(jsonDecode(file.readAsStringSync()), {'position': 2, 'enabled': true});
      expect(clock.nonPeriodicTimerCount, 0);
      expect(AppStorage(directory.path).getInt('position', 0), 2);
    });
  });

  test('explicit save cancels pending work and a later edit gets its own deadline', () {
    fakeAsync((clock) {
      final storage = AppStorage(directory.path)..setValue('position', 3);
      storage.save();
      expect(clock.nonPeriodicTimerCount, 0);
      expect(jsonDecode(file.readAsStringSync()), {'position': 3});
      file.writeAsStringSync('{"external":true}');
      clock.elapse(const Duration(seconds: 20));
      expect(jsonDecode(file.readAsStringSync()), {'external': true});
      storage.setValue('position', 4);
      clock.elapse(const Duration(seconds: 10));
      expect(jsonDecode(file.readAsStringSync()), {'position': 4});
      storage.load();
      expect(storage.getInt('position', 0), 4);
    });
  });

  test('read failure propagates and is diagnosed without file contents', () async {
    file.writeAsBytesSync([0xff]);
    await captureLogs((logs) async {
      expect(() => AppStorage(directory.path), throwsA(isA<FileSystemException>()));
      expect(
        logs.any((record) => record.loggerName == 'AppStorage' && record.message.toString().contains('load failed')),
        isTrue,
      );
    });
  });

  test('write failure is observable and a later explicit save can recover', () async {
    final storage = AppStorage(directory.path);
    await captureLogs((logs) async {
      fakeAsync((clock) {
        storage.setValue('position', 5);
        Directory(file.path).createSync();
        expect(storage.save, throwsA(isA<FileSystemException>()));
        expect(clock.nonPeriodicTimerCount, 0);
        Directory(file.path).deleteSync();
        storage.save();
        expect(jsonDecode(file.readAsStringSync()), {'position': 5});
      });
      expect(
        logs.any((record) => record.loggerName == 'AppStorage' && record.message.toString().contains('save failed')),
        isTrue,
      );
    });
  });

  test('restoring a value keeps unrelated edits and the original autosave deadline', () {
    fakeAsync((clock) {
      final storage = AppStorage(directory.path);
      storage.setValue('position', 'old');
      storage.save();
      storage.setValue('enabled', true);
      clock.elapse(const Duration(seconds: 9));
      storage.setValue('position', 'new');
      storage.setValue('position', 'old');
      expect(clock.nonPeriodicTimerCount, 1);
      clock.elapse(const Duration(seconds: 1));
      expect(jsonDecode(file.readAsStringSync()), {'position': 'old', 'enabled': true});
      expect(clock.nonPeriodicTimerCount, 0);
    });
  });

  test('rollback with setValue autosaves old values and unrelated pending changes after recovery', () {
    fakeAsync((clock) {
      final storage = AppStorage(directory.path);
      storage.setValue('position', 'old');
      storage.save();
      storage.setValue('enabled', true);
      file.deleteSync();
      Directory(file.path).createSync();
      storage.setValue('position', 'new');
      expect(storage.save, throwsA(isA<FileSystemException>()));
      storage.setValue('position', 'old');
      expect(clock.nonPeriodicTimerCount, 1);
      Directory(file.path).deleteSync();
      clock.elapse(const Duration(seconds: 10));
      expect(storage.getValue<String>('position'), 'old');
      expect(jsonDecode(file.readAsStringSync()), {'position': 'old', 'enabled': true});
      expect(clock.nonPeriodicTimerCount, 0);
    });
  });

  test('background save failure is logged and retains values for a later edit', () async {
    await captureLogs((logs) async {
      fakeAsync((clock) {
        final storage = AppStorage(directory.path);
        storage.setValue('position', 'private-pending-value');
        Directory(file.path).createSync();
        clock.elapse(const Duration(seconds: 10));
        expect(storage.getValue<String>('position'), 'private-pending-value');
        expect(clock.nonPeriodicTimerCount, 0);
        Directory(file.path).deleteSync();
        storage.setValue('enabled', true);
        clock.elapse(const Duration(seconds: 10));
        expect(jsonDecode(file.readAsStringSync()), {'position': 'private-pending-value', 'enabled': true});
      });
      expect(logs.any((entry) => entry.message.contains('save failed')), isTrue);
      expect(
        logs.map((entry) => '${entry.message} ${entry.error ?? ''}').join(' '),
        isNot(contains('private-pending-value')),
      );
    });
  });
}
