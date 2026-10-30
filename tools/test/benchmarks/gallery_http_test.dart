import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/benchmarks/gallery_http.dart';
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:dslideshow_tools/src/benchmarks/provenance.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  setUp(() => root = Directory.systemTemp.createTempSync('gallery-http-test-'));
  tearDown(() => root.deleteSync(recursive: true));
  test('snapshot preserves uncommitted sources and rejects later mutation', () async {
    final packages = <Map<String, dynamic>>[];
    for (final name in ['dslideshow_backend', 'dslideshow_common']) {
      final directory = Directory(p.join(root.path, name, 'lib'))..createSync(recursive: true);
      File(p.join(directory.path, 'example.dart')).writeAsStringSync('// uncommitted\n');
      packages.add({'name': name, 'rootUri': directory.parent.uri.toString(), 'packageUri': 'lib/'});
    }
    final config = File(p.join(root.path, 'packages.json'));
    writeJson(config, {'configVersion': 2, 'packages': packages});
    final variant = Directory(p.join(root.path, 'candidate'));
    final frozen = await snapshotGallery(config, variant);
    File(p.join(root.path, 'dslideshow_backend/lib/example.dart')).writeAsStringSync('// later');
    verifyGallerySnapshot(variant);
    expect(
      asList(readJson(frozen, [])['packages']).every((e) => (e['rootUri'] as String).startsWith('file:///')),
      isTrue,
    );
    final copied = File(p.join(variant.path, 'sources/backend/lib/example.dart'));
    expect(copied.readAsStringSync(), contains('uncommitted'));
    copied.writeAsStringSync('// mutated');
    expect(() => verifyGallerySnapshot(variant), throwsStateError);
  });
  test('existing variants/fixtures are never replaced', () async {
    final existing = Directory(p.join(root.path, 'existing'))..createSync();
    final preserve = File(p.join(existing.path, 'preserve'))..writeAsStringSync('preserve');
    await expectLater(snapshotGallery(File('absent'), existing), throwsStateError);
    expect(() => prepareGalleryFixture(existing, 1, []), throwsStateError);
    expect(preserve.readAsStringSync(), 'preserve');
  });
  test('fixture copies original bytes and labels metadata-only entries', () {
    final photo = File(p.join(root.path, 'original.jpg'))..writeAsStringSync('original bytes');
    final fixture = Directory(p.join(root.path, 'fixture')), manifest = prepareGalleryFixture(fixture, 7, [photo]);
    expect(manifest['real_media'], {
      'original.jpg': {'sha256': digest(photo), 'bytes': 14},
    });
    expect(File(p.join(fixture.path, 'media/original.jpg')).readAsBytesSync(), photo.readAsBytesSync());
    expect(
      Directory(p.join(fixture.path, 'media')).listSync().where((f) => p.basename(f.path).startsWith('empty-')).length,
      7,
    );
    expect(manifest['metadata_only_jpgs'], 7);
  });
  test('missing quantiles stay null and nearest rank preserves count', () {
    expect(nearestDistribution([]), {'n': 0, 'p50': null, 'p95': null, 'p99': null, 'max': null});
    expect(nearestDistribution([3, 2, 50])['p99'], 50);
  });
  test('resource samples count fd entries without resolving unavailable targets', () {
    final proc = Directory(p.join(root.path, 'proc'))..createSync();
    for (final (processId, rss, highWater, threads, cpu) in [
      (123, 100, 150, 2, [2, 3, 5, 7]),
      (456, 60, 80, 3, [11, 13, 17, 19]),
    ]) {
      final directory = Directory(p.join(proc.path, '$processId'))..createSync();
      File(p.join(directory.path, 'status'))
          .writeAsStringSync('VmRSS:\t$rss kB\nVmHWM:\t$highWater kB\nThreads:\t$threads\n');
      final fields = List<String>.filled(15, '0');
      fields[0] = 'S';
      fields.setRange(11, 15, cpu.map((value) => '$value'));
      File(p.join(directory.path, 'stat')).writeAsStringSync('$processId (gallery process) ${fields.join(' ')}');
      final task = Directory(p.join(directory.path, 'task', '$processId'))..createSync(recursive: true);
      File(p.join(task.path, 'children')).writeAsStringSync(processId == 123 ? '456 456' : '123');
      Directory(p.join(directory.path, 'fd')).createSync();
    }
    final secondTask = Directory(p.join(proc.path, '123/task/124'))..createSync();
    File(p.join(secondTask.path, 'children')).writeAsStringSync('456 789');
    final readable = File(p.join(root.path, 'readable'))..writeAsStringSync('open descriptor target');
    final restricted = Directory(p.join(root.path, 'restricted'))..createSync();
    final unavailable = File(p.join(restricted.path, 'opened-before-restriction'))..writeAsStringSync('open target');
    Link(p.join(proc.path, '123/fd/1')).createSync(readable.path);
    Link(p.join(proc.path, '123/fd/2')).createSync(p.join(root.path, 'removed descriptor target'));
    Link(p.join(proc.path, '123/fd/3')).createSync(unavailable.path);
    Link(p.join(proc.path, '456/fd/1')).createSync(readable.path);
    Link(p.join(proc.path, '456/fd/2')).createSync(p.join(root.path, 'removed child target'));
    expect(Process.runSync('chmod', ['000', restricted.path]).exitCode, 0);
    try {
      final sample = galleryProcessSample(123, procRoot: proc);
      expect(sample, isNotNull);
      final metrics = sample!, childCpu = 24000 / clockTicks, childTreeCpu = childCpu + 36000 / clockTicks;
      expect(metrics, {
        'VmRSS': 100,
        'VmHWM': 150,
        'Threads': 2,
        'cpu_ms': 5000 / clockTicks,
        'fd': 3,
        'monotonic_s': isPositive,
        'pid': 123,
        'children': [
          {
            'VmRSS': 60,
            'VmHWM': 80,
            'Threads': 3,
            'cpu_ms': childCpu,
            'fd': 2,
            'monotonic_s': greaterThanOrEqualTo(metrics['monotonic_s'] as num),
            'pid': 456,
            'children': isEmpty,
            'tree_rss_kib': 60,
            'tree_fd': 2,
            'tree_threads': 3,
            'tree_processes': 1,
            'tree_cpu_ms': childTreeCpu,
          },
        ],
        'tree_rss_kib': 160,
        'tree_fd': 5,
        'tree_threads': 5,
        'tree_processes': 2,
        'tree_cpu_ms': 5000 / clockTicks + 12000 / clockTicks + childTreeCpu,
      });
    } finally {
      expect(Process.runSync('chmod', ['700', restricted.path]).exitCode, 0);
    }
  });
  test('resource samples include real children from all Dart IO tasks', () async {
    final script = File(p.join(root.path, 'child.dart'))
      ..writeAsStringSync("import 'dart:io'; Future<void> main() async {stdout.writeln('ready');await stdin.first;}\n");
    final child = await Process.start(cli.dartExecutable!, ['--suppress-analytics', 'run', script.path]);
    addTearDown(() async {
      child.kill(ProcessSignal.sigkill);
      await child.exitCode;
    });
    unawaited(child.stderr.drain<void>());
    expect(await child.stdout.transform(utf8.decoder).transform(const LineSplitter()).first, 'ready');
    final sample = galleryProcessSample(pid)!;
    expect(asList(sample['children']).map((e) => e['pid']), contains(child.pid));
    expect(sample['tree_processes'], greaterThanOrEqualTo(2));
    expect(sample['tree_rss_kib'], greaterThanOrEqualTo(sample['VmRSS'] as num));
    expect(sample['tree_threads'], greaterThanOrEqualTo(sample['Threads'] as num));
  });
  group('streaming client', () {
    late HttpServer server;
    setUp(() async {
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      server.listen((request) async {
        if (request.uri.path == '/missing') {
          request.response.statusCode = 404;
          request.response.write('missing');
        } else {
          request.response.contentLength = 262144;
          request.response.add(List<int>.filled(262144, 97));
        }
        try {
          await request.response.close();
        } on Object {
          /* Cancellation closes the socket. */
        }
      });
    });
    tearDown(() => server.close(force: true));
    test('counts original body without retaining it', () async {
      final (result, body) = await galleryRequest(server.port, '/original');
      expect(result['status'], 200);
      expect(result['body_bytes'], 262144);
      expect(result['error'], isNull);
      expect(result['cancelled'], false);
      expect(body, isEmpty);
    });
    test('explicit metadata capture retains body', () async {
      final (result, body) = await galleryRequest(server.port, '/missing', captureBody: true);
      expect(result['status'], 404);
      expect(result['body_bytes'], 7);
      expect(utf8.decode(body), 'missing');
    });
    test('cancellation stops consumption at threshold', () async {
      final (result, _) = await galleryRequest(server.port, '/original', cancelAfter: 65536);
      expect(result['cancelled'], true);
      expect(result['body_bytes'], 65536);
      expect(result['error'], isNull);
    });
  });
  test('truncated body remains an error', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close());
    server.listen((socket) {
      socket.listen((_) async {
        socket.write('HTTP/1.1 200 OK\r\nContent-Length: 200000\r\nConnection: close\r\n\r\ntoo short');
        await socket.flush();
        await socket.close();
      });
    });
    final (result, _) = await galleryRequest(server.port, '/truncated');
    expect(result['error'], contains('IncompleteRead'));
  });
}
