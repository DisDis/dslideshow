// Review evidence: all writes remain inside one disposable temporary directory.
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';

class _UnusedRemote implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> main() async {
  final root = await Directory.systemTemp.createTemp('upload-path-review-');
  final previous = Directory.current;
  final images = await Directory.fromUri(root.uri.resolve('images/')).create();
  final config = AppConfig.fromJson({});
  config.webServer.permanentCode = 'synthetic-review-code';
  await Directory.fromUri(root.uri.resolve('web/')).create();
  Directory.current = root;
  Logger.root.level = Level.ALL;
  var codeLogged = false;
  final logs = Logger.root.onRecord.listen((record) {
    if (record.message.contains('synthetic-review-code')) codeLogged = true;
  });
  final service = WebService(
    config,
    config.webServer,
    _UnusedRemote(),
    cacheDirectory: images,
    startServer: false,
  );
  try {
    final body = utf8.encode(
      '--review-boundary\r\n'
      'Content-Disposition: form-data; name="file"; filename="../escaped.jpg"\r\n\r\n'
      'review\r\n--review-boundary--\r\n',
    );
    final response = await service.handler(
      Request(
        'POST',
        Uri.parse('http://localhost/upload/${service.code}/'),
        headers: {
          'content-type': 'multipart/form-data; boundary=review-boundary',
        },
        body: body,
      ),
    );
    await response.readAsString();
    final escaped = File.fromUri(root.uri.resolve('escaped.jpg'));
    final exists = await escaped.exists();
    print(
      'status=${response.statusCode} write_outside_media_root=$exists access_code_logged=$codeLogged',
    );
    if (response.statusCode != 200 ||
        !exists ||
        await escaped.readAsString() != 'review') {
      throw StateError('The reviewed path escape was not reproduced');
    }
  } finally {
    await service.close();
    await logs.cancel();
    Directory.current = previous;
    await root.delete(recursive: true);
  }
}
