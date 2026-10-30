import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:args/args.dart';
import 'package:cli_util/cli_util.dart' as cli;
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import '../process/supervisor.dart';
import '../repository.dart';
import 'json_io.dart';
import 'native_pipeline/clock.dart';
import 'provenance.dart';

final _whitespace = RegExp(r'\s+');
int? _clockTicks;
int get clockTicks => _clockTicks ??= int.parse(Process.runSync('getconf', ['CLK_TCK']).stdout.toString().trim());

Map<String, dynamic> nearestDistribution(Iterable<num> input) {
  final values = input.toList()..sort();
  num? rank(double fraction) => values.isEmpty ? null : values[math.max(0, (values.length * fraction).ceil() - 1)];
  return {'n': values.length, 'p50': rank(.5), 'p95': rank(.95), 'p99': rank(.99), 'max': values.lastOrNull};
}

void _copyTree(Directory source, Directory target) {
  target.createSync(recursive: true);
  for (final entity in source.listSync(followLinks: false)) {
    final path = p.join(target.path, p.basename(entity.path));
    if (entity is Directory) {
      _copyTree(entity, Directory(path));
    } else if (entity is File) {
      entity.copySync(path);
    } else if (entity is Link) {
      Link(path).createSync(entity.targetSync());
    }
  }
}

Future<File> snapshotGallery(File packages, Directory destination, {Directory? repository}) async {
  if (destination.existsSync()) throw StateError('Refusing to replace existing variant');
  destination.createSync(recursive: true);
  final sources = Directory(p.join(destination.path, 'sources'))..createSync();
  final config = readJson(packages, []);
  for (final value in asList(config['packages'])) {
    final item = asMap(value);
    var source = Directory.fromUri(packages.absolute.uri.resolve(item['rootUri'] as String));
    if (['dslideshow_backend', 'dslideshow_common'].contains(item['name'])) {
      final target = Directory(p.join(sources.path, item['name'] == 'dslideshow_backend' ? 'backend' : 'common'));
      _copyTree(Directory(p.join(source.path, 'lib')), Directory(p.join(target.path, 'lib')));
      for (final name in ['pubspec.yaml', 'pubspec.lock']) {
        final file = File(p.join(source.path, name));
        if (file.existsSync()) file.copySync(p.join(target.path, name));
      }
      source = target;
    }
    value['rootUri'] = source.absolute.uri.toString();
  }
  final frozen = File(p.join(destination.path, 'backend-packages.json'));
  writeJson(frozen, config);
  writeJson(File(p.join(destination.path, 'source-manifest.json')), {
    for (final file in filesBelow(sources)) p.relative(file.path, from: sources.path): digest(file),
  });
  final archive = File(p.join(destination.path, 'source.tar.gz'));
  final tar = await Process.run('tar', ['-czf', archive.path, '-C', destination.path, 'sources']);
  if (tar.exitCode != 0) throw StateError('Source archive failed');
  final root = repository ?? findRepository();
  final revision = await Process.run('git', ['rev-parse', 'HEAD'], workingDirectory: root.path),
      status = await Process.run('git', ['status', '--short'], workingDirectory: root.path);
  writeJson(File(p.join(destination.path, 'provenance.json')), {
    'revision': revision.stdout.toString().trim(),
    'git_status': status.stdout.toString(),
    'source_archive_sha256': digest(archive),
    'scope': 'backend/common current source snapshot; dependencies remain in existing pub cache',
  });
  return frozen;
}

void verifyGallerySnapshot(Directory variant) {
  final diagnostics = <String>[],
      manifest = readJson(File(p.join(variant.path, 'source-manifest.json')), diagnostics),
      sources = Directory(p.join(variant.path, 'sources'));
  if (diagnostics.isNotEmpty || manifest.isEmpty) throw StateError('Missing frozen source manifest');
  final actual = filesBelow(sources).map((f) => p.relative(f.path, from: sources.path)).toSet();
  if (actual.length != manifest.length || !actual.containsAll(manifest.keys)) {
    throw StateError('Frozen source file set changed');
  }
  for (final entry in manifest.entries) {
    if (digest(File(p.join(sources.path, entry.key))) != entry.value) {
      throw StateError('Frozen source changed: ${entry.key}');
    }
  }
}

Future<File> compileGalleryServer(String dart, Directory variant, File harness) async {
  verifyGallerySnapshot(variant);
  final execution = Directory(p.join(variant.path, 'execution'));
  if (execution.existsSync()) throw StateError('Refusing existing execution directory');
  execution.createSync();
  final frozen = harness.copySync(p.join(execution.path, 'gallery_http_server.dart'));
  final root = findRepository();
  _copyTree(Directory(p.join(root.path, 'tools/lib')), Directory(p.join(execution.path, 'runner-source/lib')));
  for (final name in ['pubspec.yaml', 'pubspec.lock']) {
    File(p.join(root.path, 'tools', name)).copySync(p.join(execution.path, 'runner-source', name));
  }
  final binary = File(p.join(execution.path, 'gallery-http-server'));
  final command = [
    '--suppress-analytics',
    'compile',
    'exe',
    '--packages=${p.join(variant.path, 'backend-packages.json')}',
    frozen.path,
    '-o',
    binary.path,
  ];
  final sink = File(p.join(execution.path, 'compile.log')).openWrite();
  final supervisor = ProcessSupervisor();
  try {
    await supervisor.run(
      dart,
      command,
      label: 'gallery-compile',
      stdoutSink: sink,
      stderrSink: sink,
      streamOutput: false,
      timeout: const Duration(minutes: 2),
    );
  } finally {
    await sink.close();
  }
  final version = await Process.run(dart, ['--suppress-analytics', '--version']);
  writeJson(File(p.join(execution.path, 'build.json')), {
    'command': [dart, ...command],
    'binary_sha256': digest(binary),
    'harness_sha256': digest(frozen),
    'runner_sha256': digest(File(p.join(root.path, 'tools/lib/src/benchmarks/gallery_http.dart'))),
    'dart': version.stdout.toString().trim(),
    'mode': 'local Linux AOT release; not Flutter UI or Pi',
  });
  return binary;
}

Map<String, dynamic> prepareGalleryFixture(Directory directory, int count, List<File> mediaFiles) {
  if (directory.existsSync()) throw StateError('Refusing existing fixture');
  directory.createSync(recursive: true);
  Directory(p.join(directory.path, 'web')).createSync();
  final media = Directory(p.join(directory.path, 'media'))..createSync();
  final hashes = <String, dynamic>{};
  for (final source in mediaFiles) {
    final target = source.copySync(p.join(media.path, p.basename(source.path)));
    hashes[p.basename(target.path)] = {'sha256': digest(target), 'bytes': target.lengthSync()};
  }
  for (var i = 0; i < count; i++) {
    File(p.join(media.path, 'empty-${i.toString().padLeft(6, '0')}.jpg')).createSync();
  }
  return {
    'metadata_only_jpgs': count,
    'real_media': hashes,
    'filesystem_cache': 'warm after creation/copy; OS cache is never dropped',
  };
}

Future<(Map<String, dynamic>, Uint8List)> galleryRequest(
  int port,
  String path, {
  int delayMs = 0,
  int? cancelAfter,
  Map<String, String> headers = const {},
  bool captureBody = false,
  Duration timeout = const Duration(seconds: 15),
}) async {
  final clock = Stopwatch()..start(),
      client = HttpClient()..autoUncompress = false,
      body = BytesBuilder(copy: false),
      responseHeaders = <String, String>{};
  int? status;
  num? firstByte;
  var bytes = 0, cancelled = false;
  String? error;
  try {
    await (() async {
      final request = await client.getUrl(Uri.parse('http://127.0.0.1:$port$path'));
      headers.forEach(request.headers.set);
      final response = await request.close();
      status = response.statusCode;
      firstByte = clock.elapsedMicroseconds / 1000;
      response.headers.forEach((name, values) => responseHeaders[name] = values.join(', '));
      var delayBytes = 0;
      await for (final chunk in response) {
        var offset = 0;
        while (offset < chunk.length) {
          var end = math.min(offset + 65536, chunk.length);
          if (cancelAfter != null) end = math.min(end, offset + math.max(0, cancelAfter - bytes));
          final slice = chunk.sublist(offset, end);
          bytes += slice.length;
          delayBytes += slice.length;
          if (captureBody) body.add(slice);
          offset = end;
          if (cancelAfter != null && bytes >= cancelAfter) {
            cancelled = true;
            break;
          }
          if (delayMs > 0 && delayBytes >= 65536) {
            await Future<void>.delayed(Duration(milliseconds: delayMs));
            delayBytes %= 65536;
          }
        }
        if (cancelled) break;
      }
      if (!cancelled &&
          status != 204 &&
          status != 304 &&
          response.contentLength >= 0 &&
          bytes != response.contentLength) {
        throw const HttpException('IncompleteRead');
      }
    })().timeout(timeout);
  } on TimeoutException {
    error = 'TimeoutError';
  } on HttpException {
    error = 'IncompleteRead';
  } on Object catch (exception) {
    error = exception.runtimeType.toString();
  } finally {
    client.close(force: true);
  }
  return (
    {
      'path': path,
      'status': status,
      'body_bytes': bytes,
      'first_byte_ms': firstByte,
      'elapsed_ms': clock.elapsedMicroseconds / 1000,
      'cancelled': cancelled,
      'error': error,
      'headers': responseHeaders,
    },
    body.takeBytes(),
  );
}

Map<String, dynamic>? galleryProcessSample(int processId, {Set<int>? seen, Directory? procRoot}) {
  final visited = seen ?? <int>{};
  if (!visited.add(processId)) return null;
  final root = procRoot ?? Directory('/proc'), directory = Directory(p.join(root.path, processId.toString()));
  try {
    final status = <String, dynamic>{};
    for (final line in File(p.join(directory.path, 'status')).readAsLinesSync()) {
      final split = line.indexOf(':');
      if (split < 0) continue;
      final key = line.substring(0, split);
      if (['VmRSS', 'VmHWM', 'Threads'].contains(key)) {
        status[key] = int.parse(line.substring(split + 1).trim().split(_whitespace).first);
      }
    }
    final text = File(p.join(directory.path, 'stat')).readAsStringSync(),
        fields = text.substring(text.lastIndexOf(')') + 2).split(_whitespace);
    status['cpu_ms'] = (int.parse(fields[11]) + int.parse(fields[12])) * 1000 / clockTicks;
    // Only descriptor entries matter; their targets may disappear while sampling.
    status['fd'] = Directory(p.join(directory.path, 'fd')).listSync(followLinks: false).length;
    status['monotonic_s'] = monotonicNanoseconds() / 1000000000;
    status['pid'] = processId;
    final children = <int>{};
    for (final task in Directory(p.join(directory.path, 'task')).listSync().whereType<Directory>()) {
      try {
        children.addAll(
          File(p.join(task.path, 'children'))
              .readAsStringSync()
              .trim()
              .split(_whitespace)
              .where((e) => e.isNotEmpty)
              .map(int.parse),
        );
      } on FileSystemException {
        /* IO thread exited. */
      }
    }
    final descendants = (children.toList()..sort())
        .map((child) => galleryProcessSample(child, seen: visited, procRoot: root))
        .whereType<Map<String, dynamic>>()
        .toList();
    status['children'] = descendants;
    num sum(String key) => descendants.fold<num>(0, (value, child) => value + (child[key] as num));
    status['tree_rss_kib'] = (status['VmRSS'] as num? ?? 0) + sum('tree_rss_kib');
    status['tree_fd'] = (status['fd'] as num) + sum('tree_fd');
    status['tree_threads'] = (status['Threads'] as num? ?? 0) + sum('tree_threads');
    status['tree_processes'] = 1 + sum('tree_processes');
    status['tree_cpu_ms'] =
        (status['cpu_ms'] as num) +
        (int.parse(fields[13]) + int.parse(fields[14])) * 1000 / clockTicks +
        sum('tree_cpu_ms');
    return status;
  } on FileSystemException {
    return null;
  } on FormatException {
    return null;
  }
}

Future<Map<String, dynamic>> _stats(int port) async {
  final (result, body) = await galleryRequest(port, '/__probe/stats', captureBody: true);
  if (result['status'] != 200 || result['error'] != null) throw StateError('Stats request failed');
  return asMap(decodeStrictJson(utf8.decode(body)));
}

Future<Map<String, dynamic>> _settle(int port) async {
  final watch = Stopwatch()..start();
  while (true) {
    final value = await _stats(port);
    if (value['active_bodies'] == 0 && value['active_handlers'] == 0) return value;
    if (watch.elapsed > const Duration(seconds: 5)) throw StateError('Resources remained active after 5 seconds');
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

Future<Map<String, dynamic>> galleryRunGroup(
  int port,
  int processId,
  String name,
  List<String> paths,
  int concurrency, {
  int delayMs = 0,
  int? cancelAfter,
}) async {
  await _settle(port);
  final (reset, _) = await galleryRequest(port, '/__probe/reset');
  if (reset['status'] != 200) throw StateError('Probe reset failed');
  final info = <Map<String, dynamic>>[], samples = <Map<String, dynamic>>[];
  var stopped = false;
  final monitor = (() async {
    while (!stopped) {
      final (row, _) = await galleryRequest(port, '/info');
      info.add(row);
      final sample = galleryProcessSample(processId);
      if (sample != null) samples.add(sample);
      if (!stopped) await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  })();
  final before = galleryProcessSample(processId), clock = Stopwatch()..start(), pool = Pool(concurrency);
  late List<Map<String, dynamic>> responses;
  late Map<String, dynamic> observed;
  late double elapsed;
  try {
    responses = await Future.wait(
      paths.map(
        (path) => pool.withResource(
          () async => (await galleryRequest(port, path, delayMs: delayMs, cancelAfter: cancelAfter)).$1,
        ),
      ),
    );
    elapsed = clock.elapsedMicroseconds / 1000000;
    observed = await _settle(port);
  } finally {
    stopped = true;
    await pool.close();
    await monitor.timeout(const Duration(seconds: 20));
  }
  final after = galleryProcessSample(processId),
      valid = responses.where((row) => row['error'] == null && [200, 206, 304].contains(row['status'])).toList();
  num? peak(String field) {
    final values = samples.map((e) => e[field]).whereType<num>();
    return values.isEmpty ? null : values.reduce(math.max);
  }

  return {
    'name': name,
    'concurrency_requested': concurrency,
    'delay_per_64k_ms': delayMs,
    'elapsed_s': elapsed,
    'requests_per_s': responses.length / elapsed,
    'client_body_bytes': responses.fold<num>(0, (n, e) => n + (e['body_bytes'] as num)),
    'successful_responses': valid.length,
    'errors': responses.length - valid.length,
    'client_cancellations': responses.where((e) => e['cancelled'] == true).length,
    'latency_ms': nearestDistribution(valid.map((e) => e['elapsed_ms'] as num)),
    'info_latency_ms': nearestDistribution(info.where((e) => e['status'] == 200).map((e) => e['elapsed_ms'] as num)),
    'info_errors': info.where((e) => e['error'] != null || e['status'] != 200).length,
    'cpu_ms': before != null && after != null ? (after['cpu_ms'] as num) - (before['cpu_ms'] as num) : null,
    'tree_cpu_ms': before != null && after != null
        ? (after['tree_cpu_ms'] as num) - (before['tree_cpu_ms'] as num)
        : null,
    'max_sampled_tree_rss_kib': peak('tree_rss_kib'),
    'max_sampled_tree_fd': peak('tree_fd'),
    'max_sampled_tree_threads': peak('tree_threads'),
    'max_sampled_tree_processes': peak('tree_processes'),
    'child_processes_after': after == null ? null : (after['tree_processes'] as num) - 1,
    'max_rss_kib': peak('VmRSS'),
    'max_fd': peak('fd'),
    'fd_before': before?['fd'],
    'fd_after': after?['fd'],
    'max_threads': peak('Threads'),
    'server': observed,
    'responses': responses,
    'info_responses': info,
    'process_samples': samples,
  };
}

Future<Map<String, dynamic>> galleryTrial(
  File binary,
  Directory resultDir,
  int count,
  List<File> mediaFiles,
  List<int> concurrencyValues,
  int requests, {
  int bucket = 256,
  int coldConcurrency = 1,
}) async {
  if (resultDir.existsSync()) throw StateError('Refusing existing trial');
  resultDir.createSync();
  final temporary = Directory.systemTemp.createTempSync('gallery-http-'),
      fixture = Directory(p.join(temporary.path, 'fixture'));
  final manifest = prepareGalleryFixture(fixture, count, mediaFiles),
      stderrSink = File(p.join(resultDir.path, 'server.stderr.log')).openWrite();
  Process? process;
  StreamSubscription<List<int>>? stderrSub;
  StreamSubscription<String>? stdoutSub;
  final stdoutDone = Completer<void>(), stderrDone = Completer<void>(), owner = ProcessSupervisor();
  int? port, interrupted;
  final signals = <StreamSubscription<ProcessSignal>>[];
  void signal(int code) {
    interrupted ??= code;
    if (process != null) unawaited(owner.cancel(interrupted!));
  }

  signals.add(ProcessSignal.sigint.watch().listen((_) => signal(130)));
  if (!Platform.isWindows) signals.add(ProcessSignal.sigterm.watch().listen((_) => signal(143)));
  try {
    process = await Process.start('setsid', ['--', binary.path, fixture.path]);
    owner.adopt(process);
    stderrSub = process.stderr.listen(stderrSink.add, onDone: stderrDone.complete);
    final readyLine = Completer<String>();
    unawaited(readyLine.future.then<void>((_) {}, onError: (Object _, StackTrace _) {}));
    stdoutSub = process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          (line) {
            if (!readyLine.isCompleted) readyLine.complete(line);
          },
          onError: (Object error, StackTrace stack) {
            if (!readyLine.isCompleted) readyLine.completeError(error, stack);
          },
          onDone: () {
            if (!readyLine.isCompleted) readyLine.completeError(StateError('Server exited before readiness'));
            stdoutDone.complete();
          },
        );
    if (interrupted != null) await owner.cancel(interrupted!);
    final ready = asMap(decodeStrictJson(await readyLine.future.timeout(const Duration(seconds: 15))));
    if (ready['kind'] != 'ready') throw StateError('Unexpected server readiness');
    port = ready['port'] as int;
    final code = ready['code'].toString(), pid = ready['pid'] as int;
    var originals = mediaFiles.map((f) => '/cache/$code/get/${Uri.encodeComponent(p.basename(f.path))}').toList();
    final listGroup = await galleryRunGroup(port, pid, 'legacy-list', List.filled(3, '/cache/$code/list'), 1);
    final (listResult, listBody) = await galleryRequest(port, '/cache/$code/list', captureBody: true);
    final listing = asList(asMap(decodeStrictJson(utf8.decode(listBody)))['items']);
    if (listResult['status'] != 200 ||
        listing.length != count + mediaFiles.length ||
        listing.toSet().length != listing.length) {
      throw StateError('Incomplete or duplicate legacy list');
    }
    final (catalogResult, catalogBody) = await galleryRequest(port, '/cache/$code/v2/catalog', captureBody: true);
    final thumbnails = <String>[];
    if (catalogResult['status'] == 200) {
      final catalog = asMap(decodeStrictJson(utf8.decode(catalogBody))),
          entries = {
            for (final e in asList(asMap(decodeStrictJson(utf8.decode(catalogBody)))['entries'])) e['path']: e,
          },
          policy = asMap(catalog['thumbnailPolicy']);
      var policyId = policy['version'].toString();
      if (truth(policy['revision'])) policyId += '-${policy['revision']}';
      for (final source in mediaFiles) {
        final entry = asMap(entries[p.basename(source.path)]);
        if (entry['thumbnailSupported'] != true) throw StateError('Real JPEG lacks thumbnail support');
        thumbnails.add(
          '/cache/$code/v2/thumbnail/${Uri.encodeComponent(entry['mediaId'] as String)}/${Uri.encodeComponent(entry['sourceRevision'] as String)}/$policyId/$bucket',
        );
      }
      originals = mediaFiles
          .map(
            (source) =>
                '/cache/$code/get/${Uri.encodeComponent(p.basename(source.path))}?rev=${Uri.encodeComponent(entries[p.basename(source.path)]['sourceRevision'] as String)}',
          )
          .toList();
    } else if (catalogResult['status'] != 404) {
      throw StateError('Catalog failed');
    }
    final groups = <Map<String, dynamic>>[listGroup], grid = thumbnails.isEmpty ? originals : thumbnails;
    groups.add(await galleryRunGroup(port, pid, 'grid-backend-cache-cold', grid, coldConcurrency));
    final conditional = <Map<String, dynamic>>[];
    for (final path in grid) {
      final (first, _) = await galleryRequest(port, path);
      final headers = asMap(first['headers']);
      final conditions = <String, String>{
        if (headers.containsKey('etag'))
          'If-None-Match': headers['etag'] as String
        else if (headers.containsKey('last-modified'))
          'If-Modified-Since': headers['last-modified'] as String,
      };
      final (repeated, _) = await galleryRequest(port, path, headers: conditions);
      conditional.add({'first': first, 'conditional_headers': conditions, 'repeat': repeated});
    }
    for (final concurrency in concurrencyValues) {
      groups.add(
        await galleryRunGroup(
          port,
          pid,
          'grid-warm-c$concurrency',
          [for (var i = 0; i < requests; i++) grid[i % grid.length]],
          concurrency,
          delayMs: 1,
        ),
      );
      groups.add(
        await galleryRunGroup(
          port,
          pid,
          'original-control-c$concurrency',
          [for (var i = 0; i < requests; i++) originals[i % originals.length]],
          concurrency,
          delayMs: 1,
        ),
      );
      final expected = List.generate(
        requests,
        (i) => mediaFiles[i % mediaFiles.length].lengthSync(),
      ).fold<int>(0, (n, e) => n + e);
      if (groups.last['client_body_bytes'] != expected || groups.last['errors'] != 0) {
        throw StateError('Original control failed byte-count integrity check');
      }
    }
    final cancel = File(p.join(fixture.path, 'media/cancel.bin')).openSync(mode: FileMode.write);
    cancel.truncateSync(64 * 1024 * 1024);
    cancel.closeSync();
    groups.add(
      await galleryRunGroup(
        port,
        pid,
        'original-socket-cancel',
        List.filled(4, '/cache/$code/get/cancel.bin'),
        2,
        cancelAfter: 65536,
      ),
    );
    final result = {
      'ready': ready,
      'fixture': manifest,
      'thumbnail_endpoint_available': thumbnails.isNotEmpty,
      'list_catalog': catalogResult,
      'legacy_list_entries_verified': listing.length,
      'conditional_probe': conditional,
      'groups': groups,
      'limits': [
        'loopback Linux host; not Wi-Fi, Pi, browser, Flutter smoothness or client memory',
        'AOT server process with benchmark-only body observer; no hardware services',
        '/info latency is HTTP/event-loop responsiveness, not real configuration RPC',
        'small samples describe these observations; no stable p99 claim',
        'no browser/client HTTP cache simulation; warm means backend derivatives only',
      ],
    };
    writeJson(File(p.join(resultDir.path, 'raw.json')), result);
    return result;
  } finally {
    int? serverCode;
    try {
      if (process != null) {
        try {
          if (interrupted == null && port != null) {
            await galleryRequest(port, '/__probe/stop', timeout: const Duration(seconds: 5));
          }
          serverCode = await process.exitCode.timeout(const Duration(seconds: 5));
        } on Object {
          await owner.cancel(interrupted ?? 1);
          serverCode = await process.exitCode;
        }
        await owner.close();
        await Future.wait([stdoutDone.future, stderrDone.future]);
      }
    } finally {
      for (final listener in signals) {
        await listener.cancel();
      }
      await stdoutSub?.cancel();
      await stderrSub?.cancel();
      await stderrSink.close();
      temporary.deleteSync(recursive: true);
    }
    if (interrupted != null) throw ProcessJobFailure('gallery-trial', interrupted!, reason: 'cancelled');
    if (serverCode != null && serverCode != 0) throw StateError('Server exited unsuccessfully; see trial logs');
  }
}

void writeGallerySummary(Directory destination, List<Map<String, dynamic>> results) {
  final compact = <Map<String, dynamic>>[];
  for (var trial = 0; trial < results.length; trial++) {
    final result = results[trial];
    for (final value in asList(result['groups'])) {
      final group = asMap(value), server = asMap(group['server']);
      compact.add({
        'trial': trial,
        'metadata_entries': asMap(result['fixture'])['metadata_only_jpgs'],
        for (final entry in group.entries)
          if (!['server', 'responses', 'info_responses', 'process_samples'].contains(entry.key)) entry.key: entry.value,
        'server_max_active_bodies': server['max_bodies'],
        'server_source_bytes': asList(server['bodies']).fold<num>(0, (n, e) => n + (e['source_bytes'] as num)),
        'server_source_cancellations': asList(server['bodies']).where((e) => e['source_cancelled'] == true).length,
        'event_loop_lateness_ms': nearestDistribution(asList(server['event_loop_lateness_ms']).cast<num>()),
      });
    }
  }
  writeJson(File(p.join(destination.path, 'summary.json')), compact);
}

Future<int> runGalleryHttp(List<String> arguments) async {
  final root = findRepository(),
      parser = ArgParser()
        ..addOption('output', mandatory: true)
        ..addOption('variant', mandatory: true)
        ..addFlag('freeze-current', negatable: false)
        ..addFlag('reuse-binary', negatable: false)
        ..addOption('dart', defaultsTo: cli.dartExecutable)
        ..addOption('packages', defaultsTo: p.join(root.path, 'backend/.dart_tool/package_config.json'))
        ..addOption('harness', defaultsTo: p.join(root.path, 'benchmarks/tool/gallery_http_server.dart'))
        ..addOption('sizes', defaultsTo: '1000,10000')
        ..addOption('concurrency', defaultsTo: '1,4,10')
        ..addOption('requests', defaultsTo: '12')
        ..addOption('bucket', allowed: ['256', '512', '1024'], defaultsTo: '256')
        ..addOption('cold-concurrency', defaultsTo: '1')
        ..addOption('repeats', defaultsTo: '3')
        ..addOption('run-name', defaultsTo: 'confirmed')
        ..addMultiOption('media', splitCommas: false);
  final args = parser.parse(arguments),
      sizes = args.option('sizes')!.split(',').map(int.parse).toList(),
      concurrency = args.option('concurrency')!.split(',').map(int.parse).toList(),
      requests = int.parse(args.option('requests')!),
      repeats = int.parse(args.option('repeats')!),
      cold = int.parse(args.option('cold-concurrency')!);
  if (sizes.any((e) => e < 0) || concurrency.any((e) => e < 1) || requests < 1 || repeats < 1 || cold < 1) {
    throw ArgumentError('Sizes must be nonnegative; other counts must be positive');
  }
  final variantName = args.option('variant')!;
  if (p.basename(variantName) != variantName || ['.', '..'].contains(variantName)) {
    throw ArgumentError('variant must be one directory name');
  }
  final variant = Directory(p.join(Directory(args.option('output')!).absolute.path, variantName));
  if (args.flag('freeze-current')) await snapshotGallery(File(args.option('packages')!), variant);
  late File binary;
  if (args.flag('reuse-binary')) {
    verifyGallerySnapshot(variant);
    binary = File(p.join(variant.path, 'execution/gallery-http-server'));
    if (digest(binary) != readJson(File(p.join(variant.path, 'execution/build.json')), [])['binary_sha256']) {
      throw StateError('Frozen AOT binary changed');
    }
  } else {
    binary = await compileGalleryServer(args.option('dart')!, variant, File(args.option('harness')!));
  }
  final media = args.multiOption('media').isNotEmpty
      ? args.multiOption('media').map(File.new).toList()
      : [
          'photo_a.jpg',
          'photo_b.jpg',
          'photo_large.jpg',
        ].map((name) => File(p.join(root.path, 'benchmarks/assets/media', name))).toList();
  if (media.map((f) => p.basename(f.path)).toSet().length != media.length) {
    throw ArgumentError('Media filenames must be unique');
  }
  final runName = args.option('run-name')!;
  if (runName.isEmpty || p.basename(runName) != runName || ['.', '..'].contains(runName)) {
    throw ArgumentError('run-name must be one directory name');
  }
  final measured = Directory(p.join(variant.path, 'execution', runName));
  if (measured.existsSync()) throw StateError('Refusing existing measurement directory');
  measured.createSync();
  writeJson(File(p.join(measured.path, 'run.json')), {
    'runner_sha256': digest(File(p.join(root.path, 'tools/lib/src/benchmarks/gallery_http.dart'))),
    'binary_sha256': digest(binary),
    'sizes': sizes,
    'concurrency': concurrency,
    'requests': requests,
    'repeats': repeats,
    'media': media.map((f) => f.absolute.path).toList(),
    'run_name': runName,
    'bucket': int.parse(args.option('bucket')!),
    'cold_concurrency': cold,
  });
  final results = <Map<String, dynamic>>[];
  try {
    for (final count in sizes) {
      for (var repeat = 0; repeat < repeats; repeat++) {
        final trial = Directory(p.join(measured.path, 'n$count-r$repeat'));
        final result = await galleryTrial(
          binary,
          trial,
          count,
          media,
          concurrency,
          requests,
          bucket: int.parse(args.option('bucket')!),
          coldConcurrency: cold,
        );
        results.add(result);
        writeGallerySummary(measured, results);
        stdout.writeln(
          canonical({'trial': trial.path, 'thumbnail_endpoint_available': result['thumbnail_endpoint_available']}),
        );
      }
    }
  } on ProcessJobFailure catch (error) {
    if (error.reason == 'cancelled') return error.exitCode;
    rethrow;
  }
  return 0;
}
