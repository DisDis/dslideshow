// Read-only gallery protocol probe. Uses only a fresh temporary media folder.
// Run from repository root with the existing backend package config:
// dart --packages=backend/.dart_tool/package_config.json \
//   benchmarks/tool/gallery_contract_probe.dart
// --socket-cancel additionally binds loopback for a client disconnect probe.
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
  final folder = await Directory.systemTemp.createTemp('gallery-contract-');
  final config = AppConfig.fromJson({});
  final service = WebService(
    config,
    config.webServer,
    _UnusedRemote(),
    cacheDirectory: folder,
    startServer: false,
  );
  Future<Response> response(
    String method,
    String tail, [
    Map<String, String> headers = const {},
  ]) async => await service.handler(
    Request(
      method,
      Uri.parse('http://localhost/cache/${service.code}/$tail'),
      headers: headers,
    ),
  );
  final observations = <String, Object?>{};
  Future<void> probe(
    String name,
    String method,
    String tail, [
    Map<String, String> headers = const {},
  ]) async {
    final result = await response(method, tail, headers);
    final body = await result.read().expand((chunk) => chunk).toList();
    observations[name] = {
      'status': result.statusCode,
      'headers': result.headers,
      'bodyBytes': body.length,
      'body': utf8.decode(body, allowMalformed: true),
    };
  }

  try {
    final original = File('${folder.path}/original.jpg');
    await original.writeAsString('0123456789');
    await Directory('${folder.path}/album').create();
    await File('${folder.path}/album/ready.jpg').writeAsString('ready');
    await File('${folder.path}/upload.part').writeAsString('unfinished');
    await probe('list', 'GET', 'list');
    await probe('get', 'GET', 'get/original.jpg');
    final initial = observations['get'] as Map;
    final modified = (initial['headers'] as Map)['last-modified'] as String;
    await probe('head', 'HEAD', 'get/original.jpg');
    await probe('range', 'GET', 'get/original.jpg', {'range': 'bytes=2-4'});
    await probe('rangeHead', 'HEAD', 'get/original.jpg', {
      'range': 'bytes=2-4',
    });
    await probe('suffixRange', 'GET', 'get/original.jpg', {
      'range': 'bytes=-3',
    });
    await probe('unsatisfiableRange', 'GET', 'get/original.jpg', {
      'range': 'bytes=99-',
    });
    await probe('multiRange', 'GET', 'get/original.jpg', {
      'range': 'bytes=0-1,4-5',
    });
    await probe('ifModifiedSince', 'GET', 'get/original.jpg', {
      'if-modified-since': modified,
    });
    await probe('ifNoneMatch', 'GET', 'get/original.jpg', {
      'if-none-match': '*',
    });
    await probe('staleIfRange', 'GET', 'get/original.jpg', {
      'range': 'bytes=2-4',
      'if-range': 'Tue, 15 Nov 1994 12:45:26 GMT',
    });
    await original.writeAsString('replacement');
    await probe('replacedAtSameUrl', 'GET', 'get/original.jpg');
    await File('${folder.path}/quote"name.jpg').writeAsString('quote');
    final quotedList = await response('GET', 'list');
    final quotedBody = await quotedList.readAsString();
    var parses = true;
    try {
      jsonDecode(quotedBody);
    } on FormatException {
      parses = false;
    }
    observations['quotedFilenameList'] = {'validJson': parses};
    final forbidden = await service.handler(
      Request(
        'GET',
        Uri.parse('http://localhost/cache/wrong/get/original.jpg'),
      ),
    );
    observations['wrongCode'] = {'status': forbidden.statusCode};
    await forbidden.read().drain<void>();
    if (arguments.contains('--socket-cancel')) {
      observations['socketCancel'] = await _probeDisconnect(service, folder);
    }
    stdout.writeln(
      const JsonEncoder.withIndent('  ').convert({
        'sdk': Platform.version,
        'scope': 'Local temp fixtures; contract probe, not throughput or Pi benchmark',
        'observations': observations,
      }),
    );
  } finally {
    await service.close();
    await folder.delete(recursive: true);
  }
}

Future<Map<String, Object?>> _probeDisconnect(
  WebService service,
  Directory folder,
) async {
  final large = File('${folder.path}/large.bin');
  final file = await large.open(mode: FileMode.write);
  await file.truncate(64 * 1024 * 1024);
  await file.close();
  var bytesReadByBackend = 0;
  var sourceCancelled = false;
  var sourceDone = false;
  final cancelled = Completer<void>();
  final server = await shelf_io.serve(
    (request) async {
      final result = await service.handler(request);
      late StreamSubscription<List<int>> input;
      late StreamController<List<int>> output;
      output = StreamController<List<int>>(
        onListen: () {
          input = result.read().listen(
            (data) {
              bytesReadByBackend += data.length;
              output.add(data);
            },
            onError: output.addError,
            onDone: () {
              sourceDone = true;
              output.close();
            },
          );
        },
        onPause: () => input.pause(),
        onResume: () => input.resume(),
        onCancel: () async {
          sourceCancelled = true;
          await input.cancel();
          if (!cancelled.isCompleted) cancelled.complete();
        },
      );
      return result.change(body: output.stream);
    },
    InternetAddress.loopbackIPv4,
    0,
    poweredByHeader: null,
  );
  try {
    final socket = await Socket.connect(
      InternetAddress.loopbackIPv4,
      server.port,
    );
    final received = Completer<int>();
    socket.listen(
      (data) {
        if (!received.isCompleted) {
          received.complete(data.length);
          socket.destroy();
        }
      },
      onError: (Object error) {
        if (!received.isCompleted) received.completeError(error);
      },
    );
    socket.write(
      'GET /cache/${service.code}/get/large.bin HTTP/1.1\r\n'
      'Host: localhost\r\nConnection: close\r\n\r\n',
    );
    final firstClientChunk = await received.future.timeout(
      const Duration(seconds: 5),
    );
    var completedCancellation = true;
    try {
      await cancelled.future.timeout(const Duration(seconds: 5));
    } on TimeoutException {
      completedCancellation = false;
    }
    final openLargeDescriptors = Directory('/proc/self/fd')
        .listSync()
        .where((fd) {
          try {
            return Link(fd.path).targetSync() == large.path;
          } on FileSystemException {
            return false;
          }
        })
        .length;
    return {
      'fixtureBytes': 64 * 1024 * 1024,
      'firstClientChunkBytes': firstClientChunk,
      'backendSourceBytesRead': bytesReadByBackend,
      'sourceDone': sourceDone,
      'sourceCancelled': sourceCancelled,
      'cancellationFinishedWithin5Seconds': completedCancellation,
      'openLargeFileDescriptorsAfterCancellation': openLargeDescriptors,
    };
  } finally {
    await server.close(force: true);
  }
}
