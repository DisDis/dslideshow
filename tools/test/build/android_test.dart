import 'dart:io';

import 'package:dslideshow_tools/src/build/android.dart';
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  late File pubspec;
  late File appPubspec;
  late File source;
  late List<LogRecord> logs;

  setUp(() {
    root = Directory.systemTemp.createTempSync('android build ');
    addTearDown(() => root.deleteSync(recursive: true));
    pubspec = File(p.join(root.path, 'backend/pubspec.yaml'));
    pubspec.parent.createSync(recursive: true);
    pubspec.writeAsStringSync('name: backend\nversion: 21.2.3+7\n');
    appPubspec = File(p.join(root.path, 'config_app/pubspec.yaml'));
    appPubspec.parent.createSync(recursive: true);
    appPubspec.writeAsStringSync('name: config_app\nversion: "1.0.0+1" # keep comment\n');
    source = File(p.join(root.path, 'config_app/build/app/outputs/flutter-apk/app-release.apk'));
    logs = [];
    final subscription = Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'AndroidBuild') logs.add(record);
    });
    addTearDown(subscription.cancel);
  });

  test('builds with backend version and publishes the same APK under its versioned name', () async {
    final artifact = await buildAndroidApk(
      root,
      runFlutter: (arguments, workingDirectory) async {
        expect(workingDirectory, p.join(root.path, 'config_app'));
        expect(arguments, ['build', 'apk', '--release']);
        expect(appPubspec.readAsStringSync(), 'name: config_app\nversion: 21.2.3+7 # keep comment\n');
        source.parent.createSync(recursive: true);
        source.writeAsBytesSync([1, 4, 8, 16]);
        return 0;
      },
    );
    expect(artifact.path, p.join(source.parent.path, 'config_app_21.2.3+7.apk'));
    expect(artifact.readAsBytesSync(), [1, 4, 8, 16]);
    expect(source.readAsBytesSync(), [1, 4, 8, 16]);
    expect(appPubspec.readAsStringSync(), 'name: config_app\nversion: 21.2.3+7 # keep comment\n');
    expect(logs.first.message, contains('action=start'));
    expect(logs.last.message, contains('result=passed version=21.2.3+7'));
  });

  for (final version in ['21.2.3', '21.2.3+abc', '21.2.3+0', '21.2.3+2100000001', '../invalid']) {
    test('rejects backend version $version before launching Flutter', () async {
      pubspec.writeAsStringSync('version: "$version"\n');
      await expectLater(
        buildAndroidApk(root, runFlutter: (_, _) async => fail('Flutter must not run')),
        throwsFormatException,
      );
      expect(logs.last.level, Level.SEVERE);
      expect(logs.last.message, contains('result=failed'));
      expect(appPubspec.readAsStringSync(), 'name: config_app\nversion: "1.0.0+1" # keep comment\n');
    });
  }

  test('failed build never publishes a stale default APK and preserves the Flutter exit code', () async {
    source.parent.createSync(recursive: true);
    source.writeAsStringSync('previous build');
    await expectLater(
      buildAndroidApk(root, runFlutter: (_, _) async => 9),
      throwsA(isA<ProcessJobFailure>().having((error) => error.code, 'code', 9)),
    );
    expect(File(p.join(source.parent.path, 'config_app_21.2.3+7.apk')).existsSync(), isFalse);
    expect(logs.last.level, Level.SEVERE);
    expect(logs.last.message, contains('result=failed code=9'));
    expect(appPubspec.readAsStringSync(), 'name: config_app\nversion: 21.2.3+7 # keep comment\n');
  });

  test('missing build output fails instead of reporting successful publication', () async {
    await expectLater(buildAndroidApk(root, runFlutter: (_, _) async => 0), throwsA(isA<FileSystemException>()));
    expect(logs.last.level, Level.SEVERE);
    expect(logs.last.message, contains('result=failed'));
  });

  test('cancelled build is logged as cancellation and does not publish an APK', () async {
    await expectLater(
      buildAndroidApk(
        root,
        runFlutter: (_, _) async => throw const ProcessJobFailure('android', 130, reason: 'cancelled'),
      ),
      throwsA(isA<ProcessJobFailure>().having((error) => error.code, 'code', 130)),
    );
    expect(logs.last.level, Level.INFO);
    expect(logs.last.message, contains('result=cancelled code=130'));
    expect(source.parent.existsSync(), isFalse);
  });
}
