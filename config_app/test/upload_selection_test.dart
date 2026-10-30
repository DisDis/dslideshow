import 'dart:async';

import 'package:config_app/features/upload/domain/upload_folder_file.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

import 'support/upload_support.dart';

void main() {
  test('Android picked files use their original names instead of picker cache directory names', () async {
    final photo = SelectedUploadFile('photo.jpg', selectedUri: Uri.file('/app/cache/file_picker/12345/photo.jpg'));
    final bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      pickedPathMode: UploadPickedPathMode.fileName,
      pickFiles: () async => [photo],
      webClientFactory: () =>
          WebClient(host: 'frame', port: 80, code: '', clientFactory: ControlledUploadHttpClient.new),
    );
    addTearDown(bloc.close);
    final selected = bloc.stream.firstWhere((state) => state.tasks.isNotEmpty);
    bloc.add(const UploadQueueEvent.select(UploadSelectionKind.files));
    expect((await selected).tasks.single.serverPath, 'photo.jpg');
  });

  test('selection belongs to Bloc, rejects a second picker and ignores a result after close', () async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(subscription.cancel);
    final picked = Completer<List<PlatformFile>>();
    var selections = 0;
    final bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      pickFiles: () {
        selections++;
        return picked.future;
      },
    );
    final selecting = bloc.stream.firstWhere((state) => state.isSelecting);
    bloc.add(const UploadQueueEvent.select(UploadSelectionKind.files));
    await selecting;
    final another = Completer<void>();
    bloc.add(const UploadQueueEvent.select(UploadSelectionKind.files));
    scheduleMicrotask(another.complete);
    await another.future;
    expect(selections, 1);
    final closing = bloc.close();
    picked.complete([SelectedUploadFile('late.jpg')]);
    await closing;
    expect(bloc.state.tasks, isEmpty);
    expect(records.any((record) => record.message == 'selection cancelled reason=queueClosed'), isTrue);
  });

  test('document permission failure reports a typed folder issue and a safe platform code', () async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(subscription.cancel);
    final bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      listPlatformFolder: (_) => Stream.error(
        PlatformException(code: 'documents_SecurityException', message: 'content://private-provider/private-file'),
      ),
    );
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state.selectionIssue == UploadSelectionIssue.folderReadFailed);
    bloc.add(const UploadQueueEvent.addFolder('content://selected'));
    await failed;
    expect(records.any((record) => record.message == 'folder source failed code=documents_SecurityException'), isTrue);
    expect(records.map((record) => record.message).join(), isNot(contains('private-provider')));
  });

  test('picker error is visible and logs neither its message nor a secret URI', () async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(subscription.cancel);
    final bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      pickFiles: () async => throw StateError('content://private-provider/private-file'),
    );
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state.selectionIssue == UploadSelectionIssue.pickerFailed);
    bloc.add(const UploadQueueEvent.select(UploadSelectionKind.files));
    await failed;
    expect(
      records.any((record) => record.level == Level.WARNING && record.message.contains('selection failed')),
      isTrue,
    );
    expect(records.map((record) => record.message).join(), isNot(contains('private-provider')));
    expect(bloc.state.tasks, isEmpty);
  });

  test('selected Android document tree keeps subfolders and reads only active upload sources', () async {
    final files = List.generate(129, (index) => SelectedUploadFile('photo$index.jpg'));
    final folderSelected = Completer<void>();
    final bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      pickFolder: () async => 'content://tree/selected',
      listPlatformFolder: (uri) {
        expect(uri, 'content://tree/selected');
        folderSelected.complete();
        return Stream.fromIterable([
          for (final file in files) UploadFolderFile.document(file, 'Photos/sub/${file.name}'),
        ]);
      },
      webClientFactory: () =>
          WebClient(host: 'frame', port: 80, code: '', clientFactory: ControlledUploadHttpClient.new),
    );
    addTearDown(bloc.close);
    final scanned = bloc.stream.firstWhere((state) => !state.isScanningFolder && state.tasks.length == 129);
    bloc.add(const UploadQueueEvent.select(UploadSelectionKind.folder));
    await folderSelected.future;
    final state = await scanned;
    await Future.wait(files.take(2).map((file) => file.opened.future));
    expect(state.tasks.first.serverPath, 'Photos/sub/photo0.jpg');
    expect(state.tasks.last.serverPath, 'Photos/sub/photo128.jpg');
    expect(files.skip(2).every((file) => file.lengthCalls == 0 && file.streamCalls == 0), isTrue);
  });
}
