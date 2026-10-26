// Benchmark-only loopback adapter around the production WebService handler.
// Run via gallery_http.py; no hardware or production service is started.
// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class _UnusedRemote implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1)
    throw ArgumentError('Pass a temporary fixture root');
  final root = Directory(arguments.single).absolute;
  final media = Directory('${root.path}/media');
  if (!media.existsSync() || !Directory('${root.path}/web').existsSync()) {
    throw ArgumentError('Fixture must already contain media/ and web/');
  }
  final previousDirectory = Directory.current;
  late WebService service;
  try {
    Directory.current = root;
    final config = AppConfig.fromJson({});
    service = WebService(
      config,
      config.webServer,
      _UnusedRemote(),
      cacheDirectory: media,
      startServer: false,
    );
  } finally {
    Directory.current = previousDirectory;
  }

  var activeHandlers = 0;
  var maxHandlers = 0;
  var activeBodies = 0;
  var maxBodies = 0;
  final bodies = <Map<String, Object?>>[];
  final eventLoopLateness = <double>[];
  final watch = Stopwatch()..start();
  var timerExpected = watch.elapsedMicroseconds + 5000;
  final timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
    final now = watch.elapsedMicroseconds;
    eventLoopLateness.add((now - timerExpected).clamp(0, 1 << 60) / 1000);
    // Do not invent zero-valued samples for timer ticks missed while blocked.
    timerExpected = now + 5000;
  });
  final stop = Completer<void>();
  final server = await shelf_io.serve(
    (request) async {
      if (request.url.path == '__probe/reset') {
        if (activeHandlers != 0 || activeBodies != 0) {
          return Response(409, body: 'Response bodies still active');
        }
        bodies.clear();
        eventLoopLateness.clear();
        maxBodies = 0;
        maxHandlers = 0;
        return Response.ok('reset');
      }
      if (request.url.path == '__probe/stats') {
        return Response.ok(
          jsonEncode({
            'active_handlers': activeHandlers,
            'max_handlers': maxHandlers,
            'active_bodies': activeBodies,
            'max_bodies': maxBodies,
            'bodies': bodies,
            'event_loop_lateness_ms': eventLoopLateness,
          }),
          headers: {'content-type': 'application/json'},
        );
      }
      if (request.url.path == '__probe/stop') {
        Timer(const Duration(milliseconds: 20), () => stop.complete());
        return Response.ok('stopping');
      }
      final tracked = request.url.path.startsWith('cache/');
      final clock = Stopwatch()..start();
      if (tracked) {
        activeHandlers++;
        if (activeHandlers > maxHandlers) maxHandlers = activeHandlers;
      }
      late Response response;
      try {
        response = await service.handler(request);
      } finally {
        if (tracked) activeHandlers--;
      }
      if (!tracked) return response;

      var sourceBytes = 0;
      var sourceDone = false;
      var finalized = false;
      late StreamSubscription<List<int>> source;
      late StreamController<List<int>> output;
      void record(bool cancelled) {
        if (finalized) return;
        finalized = true;
        activeBodies--;
        bodies.add({
          'path': request.url.path,
          'status': response.statusCode,
          'source_bytes': sourceBytes,
          'source_done': sourceDone,
          'source_cancelled': cancelled,
          'elapsed_ms': clock.elapsedMicroseconds / 1000,
        });
      }

      output = StreamController<List<int>>(
        onListen: () {
          activeBodies++;
          if (activeBodies > maxBodies) maxBodies = activeBodies;
          source = response.read().listen(
            (chunk) {
              sourceBytes += chunk.length;
              output.add(chunk);
            },
            onError: output.addError,
            onDone: () {
              sourceDone = true;
              record(false);
              output.close();
            },
          );
        },
        onPause: () => source.pause(),
        onResume: () => source.resume(),
        onCancel: () async {
          await source.cancel();
          record(!sourceDone);
        },
      );
      return response.change(body: output.stream);
    },
    InternetAddress.loopbackIPv4,
    0,
    poweredByHeader: null,
  );
  stdout.writeln(
    jsonEncode({
      'kind': 'ready',
      'port': server.port,
      'code': service.code,
      'pid': pid,
      'dart': Platform.version,
      'scope':
          'actual WebService handler; benchmark-only body observer; loopback',
    }),
  );
  try {
    await stop.future;
  } finally {
    timer.cancel();
    await server.close(force: true);
    await service.close();
  }
}
