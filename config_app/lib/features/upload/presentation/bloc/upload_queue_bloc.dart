import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'upload_queue_bloc.freezed.dart';
part 'upload_queue_event.dart';

@freezed
sealed class UploadQueueState with _$UploadQueueState {
  const factory UploadQueueState({
    @Default([]) List<UploadTask> tasks,
    @Default({}) Map<String, double> activeProgress,
    @Default(0) int taskRevision,
    @Default(false) bool isScanningFolder,
    UploadSelectionIssue? selectionIssue,
    @Default(0) int selectionRevision,
  }) = _UploadQueueState;
}

class UploadQueueBloc extends Bloc<UploadQueueEvent, UploadQueueState> {
  static final _log = Logger('UploadQueueBloc');
  static const _maxConcurrentUploads = 2;
  static const _maxHistorySize = 100;
  static const _folderChunkSize = 128;

  final RealtimeService client;
  final WebClient Function() _webClientFactory;
  final Stream<FileSystemEntity> Function(String) _listFolder;
  final _tasks = <String, UploadTask>{};
  final _sources = <String, _UploadSource>{};
  final _waiting = Queue<String>();
  final _completed = Queue<String>();
  final _active = <String, _UploadAttempt>{};
  final _batches = <String, _UploadBatch>{};
  _FolderScan? _scan;
  int _nextAttempt = 0;
  int _nextScan = 0;
  bool _closing = false;
  Future<void>? _closeFuture;

  UploadQueueBloc({
    required this.client,
    WebClient Function()? webClientFactory,
    Stream<FileSystemEntity> Function(String)? listFolder,
  }) : _webClientFactory =
           webClientFactory ??
           (() => WebClient(
             code: client.authCode,
             host: client.connectUri.host,
             port: client.connectUri.port,
             scheme:
                 client.connectUri.scheme == 'wss' ||
                     client.connectUri.scheme == 'https'
                 ? 'https'
                 : 'http',
           )),
       _listFolder =
           listFolder ?? ((path) => Directory(path).list(recursive: true)),
       super(const UploadQueueState()) {
    on<_AddFiles>(_onAddFiles);
    on<_AddPlatformFiles>(_onAddPlatformFiles);
    on<_AddFolder>(_onAddFolder);
    on<_FolderChunk>(_onFolderChunk);
    on<_RemoveTask>(_onRemoveTask);
    on<_RetryTask>(_onRetryTask);
    on<_UpdateProgress>(_onUpdateProgress);
    on<_TaskFinished>(_onTaskFinished);
  }

  _UploadBatch _newBatch({bool open = false, String? retryOf}) {
    final batch = _UploadBatch(const Uuid().v4(), open);
    _batches[batch.id] = batch;
    _log.info(
      'batch start batchId=${batch.id} action=${open
          ? 'folder'
          : retryOf == null
          ? 'files'
          : 'retry'}'
      '${retryOf == null ? '' : ' retryOf=$retryOf'}',
    );
    return batch;
  }

  void _enqueue(
    _UploadBatch batch,
    String localPath,
    String serverPath,
    _UploadSource source,
  ) {
    final task = UploadTask(
      id: const Uuid().v4(),
      localPath: localPath,
      serverPath: serverPath,
      batchId: batch.id,
    );
    _tasks[task.id] = task;
    _sources[task.id] = source;
    _waiting.add(task.id);
    batch.total++;
    batch.remaining++;
  }

  void _onAddFiles(_AddFiles event, Emitter<UploadQueueState> emit) {
    if (_closing || event.files.isEmpty) return;
    final batch = _newBatch();
    for (final file in event.files) {
      _enqueue(
        batch,
        file.path,
        p.relative(file.path, from: p.dirname(event.rootPath)),
        _FileSource(file),
      );
    }
    _pump(emit);
  }

  void _onAddPlatformFiles(
    _AddPlatformFiles event,
    Emitter<UploadQueueState> emit,
  ) {
    if (_closing || event.files.isEmpty) return;
    final batch = _newBatch();
    final firstPath = event.files
        .map((file) => file.path)
        .whereType<String>()
        .firstOrNull;
    final root = event.rootPath.isNotEmpty
        ? p.dirname(event.rootPath)
        : firstPath == null
        ? null
        : p.dirname(p.dirname(firstPath));
    for (final file in event.files) {
      final path = file.path;
      _enqueue(
        batch,
        path ?? file.name,
        path != null && root != null ? p.relative(path, from: root) : file.name,
        _PickedSource(file),
      );
    }
    _pump(emit);
  }

  void _onAddFolder(_AddFolder event, Emitter<UploadQueueState> emit) {
    if (_closing || _scan != null) return;
    final scan = _FolderScan(++_nextScan, _newBatch(open: true));
    _scan = scan;
    emit(state.copyWith(isScanningFolder: true, selectionIssue: null));
    unawaited(_scanFolder(scan, event.path));
  }

  Future<void> _scanFolder(_FolderScan scan, String path) async {
    final files = <File>[];
    UploadSelectionIssue? issue;
    var count = 0;
    try {
      final iterator = StreamIterator(_listFolder(path));
      scan.iterator = iterator;
      while (!scan.cancelled && await iterator.moveNext()) {
        final entity = iterator.current;
        if (entity is! File ||
            !FileSettings.isSupportFile(p.extension(entity.path))) {
          continue;
        }
        files.add(entity);
        count++;
        if (files.length == _folderChunkSize) {
          if (!_closing && !scan.cancelled) {
            add(
              UploadQueueEvent.folderChunk(
                scanId: scan.id,
                files: List.of(files),
                rootPath: path,
              ),
            );
          }
          files.clear();
        }
      }
      if (count == 0) issue = UploadSelectionIssue.emptyFolder;
    } catch (_) {
      if (!scan.cancelled) issue = UploadSelectionIssue.folderReadFailed;
    } finally {
      try {
        await scan.iterator?.cancel();
      } catch (_) {
        if (!scan.cancelled) issue = UploadSelectionIssue.folderReadFailed;
      }
      if (!_closing && !scan.cancelled) {
        add(
          UploadQueueEvent.folderChunk(
            scanId: scan.id,
            files: files,
            rootPath: path,
            finished: true,
            issue: issue,
          ),
        );
      }
      scan.done.complete();
    }
  }

  void _onFolderChunk(_FolderChunk event, Emitter<UploadQueueState> emit) {
    final scan = _scan;
    if (_closing || scan == null || scan.id != event.scanId) return;
    for (final file in event.files) {
      _enqueue(
        scan.batch,
        file.path,
        p.relative(file.path, from: p.dirname(event.rootPath)),
        _FileSource(file),
      );
    }
    if (event.finished) {
      scan.batch.open = false;
      _scan = null;
      _log.info(
        'folder result batchId=${scan.batch.id} count=${scan.batch.total}'
        ' issue=${event.issue?.name ?? 'none'}',
      );
      if (event.issue == UploadSelectionIssue.folderReadFailed) {
        _log.warning(
          'folder failed batchId=${scan.batch.id} count=${scan.batch.total}',
        );
      }
      emit(
        state.copyWith(
          isScanningFolder: false,
          selectionIssue: event.issue,
          selectionRevision: state.selectionRevision + 1,
        ),
      );
      _finishBatch(scan.batch);
    }
    _pump(emit);
  }

  void _onRemoveTask(_RemoveTask event, Emitter<UploadQueueState> emit) {
    if (_closing) return;
    final task = _tasks.remove(event.taskId);
    if (task == null) return;
    final attempt = _active[event.taskId];
    if (attempt != null) {
      attempt.removed = true;
      attempt.cancellation.cancel();
      _log.fine(
        'attempt cancel batchId=${attempt.batchId} taskId=${task.id} attemptId=${attempt.id}',
      );
    } else {
      _sources.remove(task.id);
      if (task.status == UploadStatus.queued) {
        _recordResult(task.batchId, cancelled: true);
      }
    }
    _publishTasks(emit);
  }

  void _onRetryTask(_RetryTask event, Emitter<UploadQueueState> emit) {
    if (_closing) return;
    final task = _tasks[event.taskId];
    if (task == null ||
        task.status != UploadStatus.error ||
        _active.containsKey(task.id)) {
      return;
    }
    final batch = _newBatch(retryOf: task.batchId);
    batch.total = batch.remaining = 1;
    _tasks[task.id] = task.copyWith(
      batchId: batch.id,
      status: UploadStatus.queued,
      progress: 0,
      failure: null,
    );
    _waiting.add(task.id);
    _pump(emit);
  }

  void _pump(Emitter<UploadQueueState> emit) {
    if (_closing) return;
    while (_active.length < _maxConcurrentUploads && _waiting.isNotEmpty) {
      final id = _waiting.removeFirst();
      final task = _tasks[id];
      if (task == null || task.status != UploadStatus.queued) continue;
      final attempt = _UploadAttempt(++_nextAttempt, id, task.batchId);
      // Reserve synchronously, before reading metadata or opening a transport.
      _active[id] = attempt;
      _tasks[id] = task.copyWith(status: UploadStatus.uploading);
      _log.fine(
        'attempt start batchId=${task.batchId} taskId=$id attemptId=${attempt.id}',
      );
      unawaited(_runAttempt(attempt, task, _sources[id]!));
    }
    _publishTasks(emit);
  }

  Future<void> _runAttempt(
    _UploadAttempt attempt,
    UploadTask task,
    _UploadSource source,
  ) async {
    final progressClock = Stopwatch()..start();
    var lastProgressMs = -250;
    try {
      await _webClientFactory().uploadMediaStream(
        serverPath: task.serverPath,
        length: source.length,
        openRead: source.openRead,
        cancellation: attempt.cancellation,
        onProgress: (sent, total) {
          if (_closing || attempt.removed || attempt.cancellation.isCancelled) {
            return;
          }
          final now = progressClock.elapsedMilliseconds;
          if (sent == total || now - lastProgressMs >= 250) {
            lastProgressMs = now;
            add(
              UploadQueueEvent.updateProgress(task.id, attempt.id, sent, total),
            );
          }
        },
      );
    } on MediaUploadCancelled {
      attempt.cancelled = true;
    } on MediaUploadException catch (error) {
      attempt.failure = switch (error.failure) {
        MediaUploadFailure.sourceUnavailable => UploadFailure.sourceUnavailable,
        MediaUploadFailure.lengthUnknown => UploadFailure.lengthUnknown,
        MediaUploadFailure.transferFailed => UploadFailure.transferFailed,
      };
    } catch (_) {
      attempt.failure = UploadFailure.transferFailed;
    } finally {
      attempt.cancelled = attempt.cancelled || attempt.cancellation.isCancelled;
      attempt.done.complete();
      if (!_closing) {
        add(
          UploadQueueEvent.taskFinished(
            task.id,
            attempt.id,
            attempt.failure,
            attempt.cancelled,
          ),
        );
      }
    }
  }

  void _onUpdateProgress(
    _UpdateProgress event,
    Emitter<UploadQueueState> emit,
  ) {
    final attempt = _active[event.taskId];
    if (_closing ||
        attempt == null ||
        attempt.id != event.attemptId ||
        attempt.removed ||
        attempt.cancellation.isCancelled ||
        !_tasks.containsKey(event.taskId)) {
      return;
    }
    final progress = event.total <= 0
        ? 0.0
        : (event.sent / event.total).clamp(0.0, 1.0);
    emit(
      state.copyWith(
        activeProgress: {...state.activeProgress, event.taskId: progress},
      ),
    );
  }

  void _onTaskFinished(_TaskFinished event, Emitter<UploadQueueState> emit) {
    final attempt = _active[event.taskId];
    if (_closing || attempt == null || attempt.id != event.attemptId) return;
    _settleAttempt(attempt);
    _pump(emit);
  }

  void _settleAttempt(_UploadAttempt attempt) {
    if (!identical(_active[attempt.taskId], attempt)) return;
    _active.remove(attempt.taskId);
    final task = _tasks[attempt.taskId];
    if (task != null && !attempt.removed) {
      if (attempt.cancelled) {
        _tasks.remove(task.id);
      } else if (attempt.failure != null) {
        _tasks[task.id] = task.copyWith(
          status: UploadStatus.error,
          failure: attempt.failure,
        );
      } else {
        _tasks[task.id] = task.copyWith(
          status: UploadStatus.completed,
          progress: 1,
        );
        _completed.add(task.id);
        while (_completed.length > _maxHistorySize) {
          _tasks.remove(_completed.removeFirst());
        }
      }
    }
    if (attempt.cancelled || attempt.failure == null) {
      _sources.remove(attempt.taskId);
    }
    _recordResult(
      attempt.batchId,
      failure: attempt.failure,
      cancelled: attempt.cancelled,
    );
    _log.fine(
      'attempt result batchId=${attempt.batchId} taskId=${attempt.taskId}'
      ' attemptId=${attempt.id} result=${attempt.cancelled ? 'cancelled' : attempt.failure?.name ?? 'completed'}',
    );
  }

  void _publishTasks(Emitter<UploadQueueState> emit) {
    emit(
      state.copyWith(
        tasks: _tasks.values.toList(growable: false),
        activeProgress: {
          for (final id in _active.keys)
            if (_tasks.containsKey(id)) id: state.activeProgress[id] ?? 0,
        },
        taskRevision: state.taskRevision + 1,
      ),
    );
  }

  void _recordResult(
    String batchId, {
    UploadFailure? failure,
    bool cancelled = false,
  }) {
    final batch = _batches[batchId];
    if (batch == null) return;
    batch.remaining--;
    if (cancelled) {
      batch.cancelled++;
    } else if (failure != null) {
      batch.failed++;
    } else {
      batch.succeeded++;
    }
    _finishBatch(batch);
  }

  void _finishBatch(_UploadBatch batch) {
    if (batch.open || batch.remaining != 0 || !_batches.containsKey(batch.id)) {
      return;
    }
    _batches.remove(batch.id);
    _log.info(
      'batch result batchId=${batch.id} count=${batch.total} succeeded=${batch.succeeded}'
      ' failed=${batch.failed} cancelled=${batch.cancelled}',
    );
    if (batch.failed > 0) {
      _log.warning('batch failed batchId=${batch.id} failed=${batch.failed}');
    }
  }

  @override
  Future<void> close() =>
      _closeFuture ??= _closeQueue().whenComplete(() => super.close());

  Future<void> _closeQueue() async {
    _closing = true;
    final scan = _scan;
    if (scan != null) {
      scan.cancelled = true;
      _log.info(
        'folder cancel batchId=${scan.batch.id} count=${scan.batch.total}',
      );
      try {
        await scan.iterator?.cancel();
      } catch (_) {
        /* cancellation is best effort */
      }
      await scan.done.future;
      scan.batch.open = false;
      _finishBatch(scan.batch);
      _scan = null;
    }
    final attempts = _active.values.toList(growable: false);
    for (final attempt in attempts) {
      attempt.cancellation.cancel();
    }
    for (final task in _tasks.values) {
      if (task.status == UploadStatus.queued) {
        _recordResult(task.batchId, cancelled: true);
      }
    }
    await Future.wait(attempts.map((attempt) => attempt.done.future));
    for (final attempt in attempts) {
      _settleAttempt(attempt);
    }
    _sources.clear();
    _waiting.clear();
  }
}

abstract interface class _UploadSource {
  Future<int?> length();
  Stream<List<int>> openRead();
}

class _FileSource implements _UploadSource {
  final File file;
  _FileSource(this.file);
  @override
  Future<int?> length() => file.length();
  @override
  Stream<List<int>> openRead() => file.openRead();
}

class _PickedSource implements _UploadSource {
  final PlatformFile file;
  _PickedSource(this.file);
  @override
  Future<int?> length() => file.length();
  @override
  Stream<List<int>> openRead() => file.readAsByteStream();
}

class _UploadAttempt {
  final int id;
  final String taskId;
  final String batchId;
  final cancellation = MediaUploadCancellation();
  final done = Completer<void>();
  bool removed = false;
  bool cancelled = false;
  UploadFailure? failure;
  _UploadAttempt(this.id, this.taskId, this.batchId);
}

class _UploadBatch {
  final String id;
  bool open;
  int total = 0;
  int remaining = 0;
  int succeeded = 0;
  int failed = 0;
  int cancelled = 0;
  _UploadBatch(this.id, this.open);
}

class _FolderScan {
  final int id;
  final _UploadBatch batch;
  final done = Completer<void>();
  StreamIterator<FileSystemEntity>? iterator;
  bool cancelled = false;
  _FolderScan(this.id, this.batch);
}
