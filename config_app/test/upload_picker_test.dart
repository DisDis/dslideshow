import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';

final class _PickedFile extends PlatformFile {
  @override
  String get name => 'photo.jpg';

  @override
  Uri get uri => Uri.parse('blob:test-photo');

  @override
  Future<Uint8List> readAsBytes() async =>
      Uint8List.fromList(utf8.encode('photo-content'));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RealtimeService implements RealtimeService {
  _RealtimeService(this.connectUri);

  @override
  final Uri connectUri;

  @override
  String get authCode => '12345';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('uploads bytes read asynchronously from a picked web file', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final requestBody = Completer<String>();
    server.listen((request) async {
      expect(request.uri.path, '/upload/12345/');
      requestBody.complete(await utf8.decoder.bind(request).join());
      request.response.write('File uploaded');
      await request.response.close();
    });

    final bloc = UploadQueueBloc(
      client: _RealtimeService(Uri.parse('http://127.0.0.1:${server.port}')),
    );
    addTearDown(bloc.close);
    final finished = bloc.stream.firstWhere(
      (state) => state.tasks.singleOrNull?.status == UploadStatus.completed,
    );

    bloc.add(
      UploadQueueEvent.addPlatformFiles(files: [_PickedFile()], rootPath: ''),
    );
    final state = await finished.timeout(const Duration(seconds: 10));
    final body = await requestBody.future;

    expect(body, contains('filename="photo.jpg"'));
    expect(body, contains('photo-content'));
    expect(state.tasks.single.serverPath, 'photo.jpg');
  });
}
