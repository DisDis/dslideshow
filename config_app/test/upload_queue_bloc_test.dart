import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/upload_support.dart';

Future<T> bounded<T>(Future<T> future) =>
    future.timeout(const Duration(seconds: 5));

Future<UploadQueueState> stateWhere(
  UploadQueueBloc bloc,
  bool Function(UploadQueueState) predicate,
) {
  if (predicate(bloc.state)) return Future.value(bloc.state);
  return bounded(bloc.stream.firstWhere(predicate));
}

void addFiles(UploadQueueBloc bloc, List<SelectedUploadFile> files) =>
    bloc.add(UploadQueueEvent.addPlatformFiles(files: files, rootPath: ''));

void main() {
  late List<ControlledUploadHttpClient> clients;
  late UploadQueueBloc bloc;

  setUp(() {
    clients = [];
    bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      webClientFactory: () => WebClient(
        host: 'frame.example',
        port: 444,
        code: 'private-access-code',
        scheme: 'https',
        clientFactory: () {
          final client = ControlledUploadHttpClient();
          clients.add(client);
          return client;
        },
      ),
    );
  });

  tearDown(() => bloc.close());

  test(
    'reserves two slots before metadata awaits, leaves queued sources lazy',
    () async {
      final metadataA = Completer<int?>();
      final metadataB = Completer<int?>();
      final a = SelectedUploadFile('a.jpg', metadata: metadataA);
      final b = SelectedUploadFile('b.jpg', metadata: metadataB);
      final c = SelectedUploadFile('c.jpg');
      final d = SelectedUploadFile('d.jpg');
      addFiles(bloc, [a, b]);
      addFiles(bloc, [c, d]);
      final state = await stateWhere(bloc, (state) => state.tasks.length == 4);
      await bounded(
        Future.wait([a.lengthStarted.future, b.lengthStarted.future]),
      );

      expect(state.tasks.map((task) => task.status), [
        UploadStatus.uploading,
        UploadStatus.uploading,
        UploadStatus.queued,
        UploadStatus.queued,
      ]);
      expect(
        [a.lengthCalls, b.lengthCalls, c.lengthCalls, d.lengthCalls],
        [1, 1, 0, 0],
      );
      expect([
        a.streamCalls,
        b.streamCalls,
        c.streamCalls,
        d.streamCalls,
      ], everyElement(0));
      expect(clients, isEmpty);
      bloc.add(UploadQueueEvent.removeTask(state.tasks[2].id));
      await stateWhere(bloc, (state) => state.tasks.length == 3);
      expect(c.lengthCalls, 0);
      final closing = bloc.close();
      metadataA.completeError(
        StateError('late metadata failure with a secret path'),
      );
      metadataB.complete(4);
      await closing;
      expect([
        a.streamCalls,
        b.streamCalls,
        c.streamCalls,
        d.streamCalls,
      ], everyElement(0));
    },
  );

  test(
    'remove waits for source cleanup before opening the next queued source',
    () async {
      final cleanup = Completer<void>();
      final a = SelectedUploadFile('a.jpg', cleanupGate: cleanup);
      final b = SelectedUploadFile('b.jpg');
      final c = SelectedUploadFile('c.jpg');
      addFiles(bloc, [a, b, c]);
      await bounded(Future.wait([a.opened.future, b.opened.future]));
      final id = bloc.state.tasks.first.id;
      bloc.add(UploadQueueEvent.removeTask(id));
      await stateWhere(bloc, (state) => state.tasks.length == 2);
      await bounded(a.cancelStarted.future);
      expect(clients.first.closed, isTrue);
      expect(
        c.lengthCalls,
        0,
        reason: 'a cancelled attempt still owns its cleanup slot',
      );
      expect(bloc.state.activeProgress, isNot(contains(id)));
      cleanup.complete();
      await bounded(c.opened.future);
      expect(c.lengthCalls, 1);
      expect(clients, hasLength(3));
      expect(clients.every((client) => client.sends == 1), isTrue);
      expect([a.byteReads, b.byteReads, c.byteReads], everyElement(0));
    },
  );

  test(
    'close awaits all active source cleanup and never opens queued files',
    () async {
      final cleanup = Completer<void>();
      final a = SelectedUploadFile('a.jpg', cleanupGate: cleanup);
      final b = SelectedUploadFile('b.jpg');
      final c = SelectedUploadFile('c.jpg');
      addFiles(bloc, [a, b, c]);
      await bounded(Future.wait([a.opened.future, b.opened.future]));
      var closed = false;
      final closing = bloc.close().then((_) => closed = true);
      await bounded(a.cancelStarted.future);
      await bounded(b.cancelStarted.future);
      expect(closed, isFalse);
      expect(clients.every((client) => client.closed), isTrue);
      expect(c.lengthCalls, 0);
      cleanup.complete();
      await bounded(closing);
      expect(bloc.isClosed, isTrue);
      expect(c.streamCalls, 0);
    },
  );

  test('progress changes only a bounded active map and ignores stale attempt events', () async {
    final a = SelectedUploadFile('a.jpg');
    final b = SelectedUploadFile('b.jpg');
    final c = SelectedUploadFile('c.jpg');
    addFiles(bloc, [a, b, c]);
    await bounded(Future.wait([a.opened.future, b.opened.future]));
    final snapshot = bloc.state;
    final id = snapshot.tasks.first.id;
    a.chunks.add(Uint8List.fromList([1, 2]));
    final progress = await stateWhere(
      bloc,
      (state) => state.activeProgress[id] == .5,
    );
    expect(progress.taskRevision, snapshot.taskRevision);
    expect(identical(progress.tasks.first, snapshot.tasks.first), isTrue);
    expect(progress.tasks.first.progress, 0);
    expect(progress.activeProgress, hasLength(2));
    bloc.add(UploadQueueEvent.updateProgress(id, 999, 4, 4));
    // A subsequent valid event provides an observable processing boundary.
    bloc.add(UploadQueueEvent.updateProgress(snapshot.tasks[1].id, 2, 1, 4));
    final next = await stateWhere(
      bloc,
      (state) => state.activeProgress[snapshot.tasks[1].id] == .25,
    );
    expect(next.activeProgress[id], .5);
    expect(c.lengthCalls, 0);
  });

  test('uncertain HTTP failure requires explicit retry and old completion cannot finish it', () async {
    final metadata = Completer<int?>();
    final a = SelectedUploadFile('a.jpg', metadata: metadata);
    addFiles(bloc, [a]);
    await bounded(a.lengthStarted.future);
    metadata.complete(4);
    await bounded(a.opened.future);
    final id = bloc.state.tasks.single.id;
    clients.single.respond(503);
    final failed = await stateWhere(
      bloc,
      (state) => state.tasks.single.status == UploadStatus.error,
    );
    expect(failed.tasks.single.failure, UploadFailure.transferFailed);
    expect(clients, hasLength(1));
    expect(clients.single.closed, isTrue);

    // A new source subscription is allowed only after the user requests retry.
    bloc.add(UploadQueueEvent.retryTask(id));
    final retry = await stateWhere(
      bloc,
      (state) => state.tasks.single.status == UploadStatus.uploading,
    );
    expect(retry.tasks.single.batchId, isNot(failed.tasks.single.batchId));
    bloc.add(UploadQueueEvent.taskFinished(id, 1, null, false));
    bloc.add(UploadQueueEvent.updateProgress(id, 2, 1, 4));
    final stillUploading = await stateWhere(
      bloc,
      (state) => state.activeProgress[id] == .25,
    );
    expect(stillUploading.tasks.single.status, UploadStatus.uploading);
    a.chunks.add(Uint8List.fromList([1, 2, 3, 4]));
    await a.chunks.close();
    await bounded(clients.last.bodyDone.future);
    clients.last.respond();
    await stateWhere(
      bloc,
      (state) => state.tasks.single.status == UploadStatus.completed,
    );
    expect(a.streamCalls, 2);
    expect(clients, hasLength(2));
    expect(clients.every((client) => client.closed), isTrue);
  });

  test(
    'unknown size reports a typed failure without opening source or HTTP',
    () async {
      final file = SelectedUploadFile('unknown.jpg', size: null);
      addFiles(bloc, [file]);
      final state = await stateWhere(
        bloc,
        (state) => state.tasks.singleOrNull?.status == UploadStatus.error,
      );
      expect(state.tasks.single.failure, UploadFailure.lengthUnknown);
      expect(file.streamCalls, 0);
      expect(clients, isEmpty);
    },
  );

  test('batch diagnostics correlate retry and cancellation without names, URLs or per-file INFO', () async {
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord
        .where((record) => record.loggerName == 'UploadQueueBloc')
        .listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = previous;
    });
    final a = SelectedUploadFile('private-name.jpg', size: null);
    final b = SelectedUploadFile('another-private.jpg');
    addFiles(bloc, [a, b]);
    await bounded(b.opened.future);
    await stateWhere(
      bloc,
      (state) => state.tasks.first.status == UploadStatus.error,
    );
    bloc.add(UploadQueueEvent.retryTask(bloc.state.tasks.first.id));
    await stateWhere(
      bloc,
      (state) => state.tasks.first.batchId != state.tasks.last.batchId,
    );
    await bloc.close();
    final info = records
        .where((record) => record.level == Level.INFO)
        .map((record) => record.message)
        .toList();
    expect(
      info.where((message) => message.startsWith('batch start')),
      hasLength(2),
    );
    expect(
      info.where((message) => message.startsWith('batch result')),
      hasLength(2),
    );
    expect(info.any((message) => message.contains('retryOf=')), isTrue);
    expect(
      info.any(
        (message) =>
            message.contains('failed=1') && message.contains('cancelled=1'),
      ),
      isTrue,
    );
    expect(records.every((record) => record.error == null), isTrue);
    final text = records.map((record) => record.message).join('\n');
    for (final secret in [
      'private-access-code',
      'private-name',
      'another-private',
      'https:',
      'secret authenticated',
    ]) {
      expect(text, isNot(contains(secret)));
    }
  });

  test('folder scanning is asynchronous, filters files and preserves selected folder prefix', () async {
    await bloc.close();
    final folder = StreamController<FileSystemEntity>();
    var cancelled = false;
    folder.onCancel = () {
      cancelled = true;
    };
    bloc = UploadQueueBloc(
      client: UploadRealtimeService(),
      listFolder: (_) => folder.stream,
      webClientFactory: () => WebClient(
        host: 'frame',
        port: 80,
        code: '',
        clientFactory: () {
          final client = ControlledUploadHttpClient();
          clients.add(client);
          return client;
        },
      ),
    );
    bloc.add(const UploadQueueEvent.addFolder('/pictures/album'));
    await stateWhere(bloc, (state) => state.isScanningFolder);
    expect(bloc.state.tasks, isEmpty);
    folder.add(Directory('/pictures/album/subfolder'));
    folder.add(File('/pictures/album/notes.txt'));
    // No real filesystem read is needed: failure to stat this external File is
    // independently represented by the queue, while traversal uses the stream.
    folder.add(File('/pictures/album/sub/photo.jpg'));
    await folder.close();
    final selected = await stateWhere(
      bloc,
      (state) => !state.isScanningFolder && state.tasks.isNotEmpty,
    );
    expect(selected.tasks.single.serverPath, 'album/sub/photo.jpg');
    expect(cancelled, isTrue);
    expect(selected.selectionIssue, isNull);
  });

  test(
    'closing cancels a pending folder stream and does not process late entries',
    () async {
      await bloc.close();
      final folder = StreamController<FileSystemEntity>();
      final cancelled = Completer<void>();
      folder.onCancel = () => cancelled.complete();
      bloc = UploadQueueBloc(
        client: UploadRealtimeService(),
        listFolder: (_) => folder.stream,
      );
      bloc.add(const UploadQueueEvent.addFolder('/pictures/album'));
      await stateWhere(bloc, (state) => state.isScanningFolder);
      await bounded(bloc.close());
      await bounded(cancelled.future);
      folder.add(File('/pictures/album/late.jpg'));
      await folder.close();
      expect(bloc.state.tasks, isEmpty);
    },
  );

  test(
    'native picker keeps the existing selected parent folder in server names',
    () async {
      final a = SelectedUploadFile(
        'first.jpg',
        selectedUri: Uri.file('/pictures/album/first.jpg'),
      );
      final b = SelectedUploadFile(
        'second.jpg',
        selectedUri: Uri.file('/pictures/album/sub/second.jpg'),
      );
      addFiles(bloc, [a, b]);
      final selected = await stateWhere(
        bloc,
        (state) => state.tasks.length == 2,
      );
      expect(selected.tasks.map((task) => task.serverPath), [
        'album/first.jpg',
        'album/sub/second.jpg',
      ]);
    },
  );

  for (final fails in [false, true]) {
    test(
      'folder ${fails ? 'read failure' : 'empty selection'} reports a typed issue',
      () async {
        await bloc.close();
        bloc = UploadQueueBloc(
          client: UploadRealtimeService(),
          listFolder: (_) => fails
              ? Stream.error(FileSystemException('private path'))
              : const Stream.empty(),
        );
        bloc.add(const UploadQueueEvent.addFolder('/pictures/empty'));
        final state = await stateWhere(
          bloc,
          (state) => state.selectionRevision == 1,
        );
        expect(state.isScanningFolder, isFalse);
        expect(state.tasks, isEmpty);
        expect(
          state.selectionIssue,
          fails
              ? UploadSelectionIssue.folderReadFailed
              : UploadSelectionIssue.emptyFolder,
        );
      },
    );
  }
  testWidgets(
    'metadata cancellation retains a slot and close waits for unabortable length reads',
    (tester) async {
      final metadata = [
        Completer<int?>(),
        Completer<int?>(),
        Completer<int?>(),
      ];
      final files = [
        for (var index = 0; index < 3; index++)
          SelectedUploadFile('$index.jpg', metadata: metadata[index]),
      ];
      final queue = UploadQueueBloc(client: UploadRealtimeService());
      try {
        addFiles(queue, files);
        await tester.pump();
        expect(files.map((file) => file.lengthCalls), [1, 1, 0]);
        queue.add(UploadQueueEvent.removeTask(queue.state.tasks.first.id));
        await tester.pump();
        expect(files.last.lengthCalls, 0);
        metadata.first.completeError(
          StateError('cancelled metadata finished with private error'),
        );
        await tester.pump();
        expect(files.last.lengthCalls, 1);
        var closed = false;
        late Future<void> closing;
        await tester.runAsync(() async {
          closing = queue.close().then((_) => closed = true);
        });
        await tester.pump();
        expect(closed, isFalse);
        metadata[1].complete(4);
        metadata[2].complete(4);
        await tester.pump();
        await tester.runAsync(() => closing);
        expect(closed, isTrue);
        expect(files.map((file) => file.streamCalls), everyElement(0));
      } finally {
        for (final gate in metadata) {
          if (!gate.isCompleted) gate.complete(null);
        }
        await tester.runAsync(queue.close);
      }
    },
  );
}
