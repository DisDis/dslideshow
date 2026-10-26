// Local, in-process diagnostic of the existing gallery HTTP handler.
// No hardware services or listening sockets. Run with backend package_config.
// The standalone diagnostic intentionally imports backend's dependencies.
// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:shelf/shelf.dart';

class UnusedRemoteService implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

WebService createService(Directory directory, Directory workingDirectory) {
  final previousDirectory = Directory.current;
  try {
    Directory.current = workingDirectory;
    final config = AppConfig.fromJson({});
    return WebService(
      config,
      config.webServer,
      UnusedRemoteService(),
      cacheDirectory: directory,
      startServer: false,
    );
  } finally {
    Directory.current = previousDirectory;
  }
}

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1) {
    throw ArgumentError('Pass an existing media file for the byte-count probe');
  }
  final original = File(arguments.single).absolute;
  final originalLength = await original.length();
  print(
    jsonEncode({
      'kind': 'environment',
      'dart': Platform.version,
      'os': Platform.operatingSystemVersion,
      'mode': 'in_process_handler_no_http_transport',
      'filesystem_cache': 'warm_after_fixture_creation_not_os_cold',
      'fixture': 'zero_byte_jpg_files_flat_no_decoding',
    }),
  );
  final root = await Directory.systemTemp.createTemp('gallery-list-probe-');
  try {
    // WebService constructs its unrelated static app handler synchronously.
    // Keep that scaffold separate from media, with no build/web dependency.
    await Directory('${root.path}/web').create();
    await _runProbes(root, original, originalLength);
  } finally {
    // This also runs if WebService construction fails before its own try/finally.
    await root.delete(recursive: true);
  }
}

Future<void> _runProbes(
  Directory root,
  File original,
  int originalLength,
) async {
  final directory = await Directory('${root.path}/media').create();
  final service = createService(directory, root);
  try {
    var previous = 0;
    for (final count in [1000, 10000, 50000]) {
      // Fixture creation is excluded from timing. A fresh file per path.
      for (var index = previous; index < count; index++) {
        File('${directory.path}/image-$index.jpg').writeAsBytesSync([]);
      }
      previous = count;
      for (var repeat = 0; repeat < 3; repeat++) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        final clock = Stopwatch()..start();
        final timer = Completer<double>();
        Timer(const Duration(milliseconds: 1), () {
          timer.complete(clock.elapsedMicroseconds / 1000);
        });
        final response = await service.handler(
          Request(
            'GET',
            Uri.parse('http://localhost/cache/${service.code}/list'),
          ),
        );
        final handlerMs = clock.elapsedMicroseconds / 1000;
        final text = await response.readAsString();
        final bodyMs = clock.elapsedMicroseconds / 1000;
        final timerMs = await timer.future;
        final items =
            (jsonDecode(text) as Map<String, dynamic>)['items'] as List;
        if (response.statusCode != 200 ||
            items.length != count ||
            items.toSet().length != count) {
          throw StateError(
            'Incomplete list: ${response.statusCode}/${items.length}/$count',
          );
        }
        print(
          jsonEncode({
            'kind': 'list',
            'count': count,
            'repeat': repeat,
            'status': response.statusCode,
            'handler_ms': handlerMs,
            'body_complete_ms': bodyMs,
            'timer_due_ms': 1,
            'timer_actual_ms': timerMs,
            'timer_lateness_ms': (timerMs - 1).clamp(0, double.infinity),
            'json_bytes': utf8.encode(text).length,
            'items': items.length,
          }),
        );
      }
    }
  } finally {
    await service.close();
    await directory.delete(recursive: true);
  }

  final mediaService = createService(original.parent, root);
  try {
    final response = await mediaService.handler(
      Request(
        'GET',
        Uri.parse(
          'http://localhost/cache/${mediaService.code}/get/${Uri.encodeComponent(original.uri.pathSegments.last)}',
        ),
      ),
    );
    final bodyBytes = await response.read().fold<int>(
      0,
      (sum, bytes) => sum + bytes.length,
    );
    if (response.statusCode != 200 || bodyBytes != originalLength) {
      throw StateError(
        'Incomplete original: ${response.statusCode}/$bodyBytes/$originalLength',
      );
    }
    print(
      jsonEncode({
        'kind': 'original',
        'name': original.uri.pathSegments.last,
        'file_bytes': originalLength,
        'response_body_bytes': bodyBytes,
        'headers': response.headers,
        'status': response.statusCode,
        'note':
            'counted_handler_stream_bytes_not_browser_or_socket_measurement',
      }),
    );
  } finally {
    await mediaService.close();
  }
}
