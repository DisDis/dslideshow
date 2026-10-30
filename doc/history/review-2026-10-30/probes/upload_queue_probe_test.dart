// Review evidence: reproduces the current defect; not a product regression test.
import 'dart:async';
import 'dart:io';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _Connection implements RealtimeService {
  _Connection(this.connectUri);
  @override
  final Uri connectUri;
  @override
  String get authCode => 'review-code';
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test(
    'two additions before progress send three uploads for two files',
    () async {
      final root = await Directory.systemTemp.createTemp('upload-review-');
      final one = await File.fromUri(root.uri.resolve('one.jpg'))
          .writeAsBytes([1]);
      final two = await File.fromUri(root.uri.resolve('two.jpg'))
          .writeAsBytes([2]);
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final received = Completer<void>();
      final release = Completer<void>();
      final bodies = <String>[];
      final responses = <Future<void>>[];
      final subscription = server.listen((request) {
        responses.add(() async {
          bodies.add(await request.map(String.fromCharCodes).join());
          if (bodies.length == 3 && !received.isCompleted) received.complete();
          await release.future;
          request.response.statusCode = 200;
          await request.response.close();
        }());
      });
      final bloc = UploadQueueBloc(
        client: _Connection(
          Uri(scheme: 'ws', host: '127.0.0.1', port: server.port),
        ),
      );
      try {
        bloc.add(UploadQueueEvent.addFiles(files: [one], rootPath: root.path));
        bloc.add(UploadQueueEvent.addFiles(files: [two], rootPath: root.path));
        await received.future.timeout(const Duration(seconds: 10));
        expect(bodies.length, 3);
        expect(bodies.where((body) => body.contains('one.jpg')).length, 2);
        release.complete();
        await bloc.stream
            .firstWhere(
              (state) => state.tasks.every(
                (task) => task.status == UploadStatus.completed,
              ),
            )
            .timeout(const Duration(seconds: 10));
        await Future.wait(responses);
      } finally {
        if (!release.isCompleted) release.complete();
        await bloc.close();
        await subscription.cancel();
        await server.close(force: true);
        await root.delete(recursive: true);
      }
    },
  );
}
