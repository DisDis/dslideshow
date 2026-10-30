import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:cli_util/cli_util.dart' as cli;
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import '../process/supervisor.dart';
import '../repository.dart';
import 'json_io.dart';
import 'native_cache_templates.dart';
import 'native_pipeline/posix.dart' show fileIdentity;
import 'provenance.dart';

String dartString(String value) => canonical(value).replaceAll(r'$', r'\$');

Future<int> runNativeCache(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('snapshot', mandatory: true)
    ..addFlag('freeze-current', negatable: false)
    ..addOption('scenario', allowed: ['warm', 'cold'], defaultsTo: 'warm')
    ..addOption('fixture-parent')
    ..addOption('payload')
    ..addOption('concurrency', defaultsTo: '4')
    ..addOption('run-name');
  final args = parser.parse(arguments),
      root = findRepository(),
      snapshot = Directory(args.option('snapshot')!).absolute;
  if (args.flag('freeze-current')) {
    if (snapshot.existsSync()) throw StateError('Refusing to replace existing snapshot');
    snapshot.createSync(recursive: true);
    for (final name in ['gallery_encoded_cache_io.dart', 'media_image_loader.dart']) {
      final destination = File(p.join(snapshot.path, 'config_app/lib/src/gallery', name));
      destination.parent.createSync(recursive: true);
      File(p.join(root.path, 'config_app/lib/src/gallery', name)).copySync(destination.path);
    }
    writeJson(File(p.join(snapshot.path, 'manifest.json')), {
      for (final file in filesBelow(snapshot).where((f) => p.extension(f.path) == '.dart'))
        p.relative(file.path, from: snapshot.path): digest(file),
    });
  }
  final manifest = readJson(File(p.join(snapshot.path, 'manifest.json')), []);
  if (manifest.isEmpty) throw StateError('Missing frozen source manifest');
  for (final entry in manifest.entries) {
    if (digest(File(p.join(snapshot.path, entry.key))) != entry.value) throw StateError('Frozen source changed');
  }
  var execution = snapshot;
  final runName = args.option('run-name');
  if (runName != null) {
    if (runName.isEmpty || p.basename(runName) != runName || ['.', '..'].contains(runName)) {
      throw ArgumentError('run-name must be one directory name');
    }
    execution = Directory(p.join(snapshot.path, 'runs', runName));
    if (execution.existsSync()) throw StateError('Refusing to replace existing run');
    execution.createSync(recursive: true);
  }
  final scenario = args.option('scenario')!,
      output = File(p.join(execution.path, '$scenario-63.json')),
      harness = File(p.join(execution.path, 'native_${scenario}_probe_test.dart'));
  if (output.existsSync() || harness.existsSync()) throw StateError('Refusing to overwrite an existing probe run');
  final template = scenario == 'warm' ? nativeCacheWarm : nativeCacheCold;
  var code = template
      .replaceAll(
        '__CACHE_URI__',
        dartString(
          File(p.join(snapshot.path, 'config_app/lib/src/gallery/gallery_encoded_cache_io.dart')).uri.toString(),
        ),
      )
      .replaceAll('__OUTPUT__', dartString(output.path));
  final provenance = <String, dynamic>{
    'scenario': scenario,
    'scope': 'Flutter VM test, 5 fresh directories, 63 actual native operations; no image decoding, Pi or network',
  };
  if (scenario == 'cold') {
    final parent = args.option('fixture-parent'),
        payload = args.option('payload'),
        concurrency = int.parse(args.option('concurrency')!);
    if (parent == null || payload == null || concurrency < 1 || !Directory(parent).existsSync()) {
      throw ArgumentError('cold requires existing fixture-parent, payload and positive concurrency');
    }
    final copied = File(payload).copySync(p.join(execution.path, 'payload.jpg'));
    code = code
        .replaceAll('__PARENT__', dartString(Directory(parent).absolute.path))
        .replaceAll('__PAYLOAD__', dartString(copied.path))
        .replaceAll('__CONCURRENCY__', concurrency.toString());
    provenance.addAll({
      'fixture_parent': Directory(parent).absolute.path,
      'filesystem_device_id': int.parse(fileIdentity(parent)[0]),
      'payload_sha256': digest(copied),
      'payload_bytes': copied.lengthSync(),
      'concurrency': concurrency,
    });
  }
  harness.writeAsStringSync(code);
  final sdk = cli.sdkPath;
  if (sdk == null) throw StateError('Dart SDK not found');
  final flutterSnapshot = p.join(p.dirname(sdk), 'flutter_tools.snapshot'), dart = cli.dartExecutable!;
  final command = [dart, '--disable-dart-dev', flutterSnapshot, 'test', '--no-pub', harness.path];
  provenance.addAll({
    'command': command,
    'harness_sha256': digest(harness),
    'template_sha256': sha256.convert(utf8.encode(template)).toString(),
    'runner_sha256': digest(File(Platform.script.toFilePath())),
    'started_utc': DateTime.now().toUtc().toIso8601String(),
  });
  final sink = File(p.join(execution.path, 'probe.log')).openWrite(), supervisor = ProcessSupervisor();
  var status = 0;
  try {
    await supervisor.run(
      command.first,
      command.skip(1).toList(),
      label: 'native-cache',
      workingDirectory: p.join(root.path, 'config_app'),
      environment: {'DASH__SUPPRESS_ANALYTICS': 'true'},
      stdoutSink: sink,
      stderrSink: sink,
      streamOutput: false,
      timeout: const Duration(minutes: 5),
    );
  } on ProcessJobFailure catch (error) {
    status = error.exitCode;
  } finally {
    await sink.flush();
    await sink.close();
  }
  provenance.addAll({'returncode': status, 'finished_utc': DateTime.now().toUtc().toIso8601String()});
  writeJson(File(p.join(execution.path, 'probe-provenance.json')), provenance);
  stdout.writeln(output.path);
  return status;
}
