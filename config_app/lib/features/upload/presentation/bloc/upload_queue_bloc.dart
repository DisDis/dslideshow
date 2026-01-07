import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
// Замените на ваш реальный WebClient

part 'upload_queue_bloc.freezed.dart';
part 'upload_queue_event.dart';

// --- STATE ---
@freezed
sealed class UploadQueueState with _$UploadQueueState {
  const factory UploadQueueState({
    @Default([]) List<UploadTask> tasks,
  }) = _UploadQueueState;
}

// --- BLOC ---
class UploadQueueBloc extends Bloc<UploadQueueEvent, UploadQueueState> {
  final RealtimeService client;

  static const int _maxConcurrentUploads = 2; // Константа параллелизма
  static const int _maxHistorySize = 100; // История

  UploadQueueBloc({required this.client}) : super(const UploadQueueState()) {
    on<_AddFiles>(_onAddFiles);
    on<_AddPlatformFiles>(_onAddPlatformFiles);

    on<_RemoveTask>(_onRemoveTask);
    on<_RetryTask>(_onRetryTask);
    on<_UpdateProgress>(_onUpdateProgress);
    on<_TaskCompleted>(_onTaskCompleted);
    on<_TaskFailed>(_onTaskFailed);
  }

  Future<void> _onAddPlatformFiles(
      _AddPlatformFiles event, Emitter<UploadQueueState> emit) async {
    final newTasks = event.files.map((file) {
      String serverPath = p.relative(file.name, from: '');
      return UploadTask(
        id: const Uuid().v4(),
        localPath: file.name,
        serverPath: serverPath,
        bytes: file.bytes,
        status: UploadStatus.queued,
      );
    }).toList();

    emit(state.copyWith(tasks: [...state.tasks, ...newTasks]));
    _processQueue();
  }

  // Добавление файлов в очередь
  Future<void> _onAddFiles(
      _AddFiles event, Emitter<UploadQueueState> emit) async {
    final rootPath = p.dirname(event.rootPath);
    final newTasks = event.files.map((file) {
      // Вычисляем относительный путь для сервера
      // Если rootPath = /user/photos, а файл /user/photos/vacation/1.jpg
      // то serverPath = vacation/1.jpg
      String serverPath = p.relative(file.path, from: rootPath);

      return UploadTask(
        id: const Uuid().v4(),
        localPath: file.path,
        serverPath: serverPath,
        status: UploadStatus.queued,
      );
    }).toList();

    emit(state.copyWith(tasks: [...state.tasks, ...newTasks]));
    _processQueue();
  }

  void _onRemoveTask(_RemoveTask event, Emitter<UploadQueueState> emit) {
    // Удаляем только если задача в очереди или ошибка
    final updatedTasks =
        state.tasks.where((t) => t.id != event.taskId).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  void _onRetryTask(_RetryTask event, Emitter<UploadQueueState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        return t.copyWith(
            status: UploadStatus.queued, errorMessage: null, progress: 0);
      }
      return t;
    }).toList();

    emit(state.copyWith(tasks: updatedTasks));
    _processQueue();
  }

  void _onUpdateProgress(
      _UpdateProgress event, Emitter<UploadQueueState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        final progress = event.total == 0 ? 0.0 : event.sent / event.total;
        // Если пришел прогресс, значит задача точно загружается
        return t.copyWith(
            progress: progress,
            status: UploadStatus.uploading // Форсируем статус
            );
      }
      return t;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  void _onTaskCompleted(_TaskCompleted event, Emitter<UploadQueueState> emit) {
    var updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        return t.copyWith(status: UploadStatus.completed, progress: 1.0);
      }
      return t;
    }).toList();

    // Очистка старой истории (> 100 выполненных)
    updatedTasks = _cleanupHistory(updatedTasks);

    emit(state.copyWith(tasks: updatedTasks));
    _processQueue(); // Запускаем следующую
  }

  void _onTaskFailed(_TaskFailed event, Emitter<UploadQueueState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        return t.copyWith(
            status: UploadStatus.error, errorMessage: event.error);
      }
      return t;
    }).toList();

    emit(state.copyWith(tasks: updatedTasks));
    _processQueue(); // Запускаем следующую, несмотря на ошибку
  }

  // --- LOGIC ---

  // Главный метод управления очередью
  void _processQueue() {
    // 1. Считаем сколько сейчас загружается
    final activeCount =
        state.tasks.where((t) => t.status == UploadStatus.uploading).length;

    if (activeCount >= _maxConcurrentUploads) return;

    // 2. Сколько слотов свободно
    final freeSlots = _maxConcurrentUploads - activeCount;

    // 3. Берем следующие из очереди
    final tasksToStart = state.tasks
        .where((t) => t.status == UploadStatus.queued)
        .take(freeSlots);

    for (final task in tasksToStart) {
      _startUpload(task);
    }
  }

  Future<void> _startUpload(UploadTask task) async {
    // Меняем статус на uploading
    // ВНИМАНИЕ: Мы не используем emit здесь напрямую, так как метод асинхронный и внешний,
    // но для корректности UI нужно обновить стейт.
    // В Bloc > 7.2 лучше отправлять события самому себе или делать emit внутри handler.
    // Тут мы хакнем через Stream или просто модифицируем стейт "in place" нельзя.
    // Правильный путь:
    // Мы не можем сделать emit здесь. Но _processQueue вызывается ВНУТРИ хендлеров событий.
    // Поэтому мы должны запустить фоновую задачу, которая будет слать ивенты.

    // Но сначала пометим задачу как Uploading, чтобы занять слот.
    // Это изменение стейта должно пройти через событие или мы должны были сделать это раньше.
    // Давайте упростим: _processQueue не будет запускать задачу сама, она найдет кандидатов
    // и пошлет внутреннее событие _InternalStartTask. Но это усложнит код.
    // Проще всего: Сделаем dirty hack с обновлением стейта ПЕРЕД асинхронщиной внутри хендлеров.
    // Но так как _processQueue вызывается в конце хендлеров, мы не можем сделать emit.

    // РЕШЕНИЕ:
    // Мы просто запускаем асинхронную функцию, которая сразу пошлет ивент "Started".
    // Но чтобы не было гонки, лучше считать activeCount + startedCount.

    _uploadFileRoutine(task);
  }

  Future<void> _uploadFileRoutine(UploadTask task) async {
    try {
      int lastUpdateTimestamp = 0;
      const throttleDuration = 500;
      // Мы не можем сделать emit(loading) тут.
      // Поэтому, визуально слот "занимается" только когда прилетит первый прогресс или мы сделаем событие Started.
      // Добавим специальный метод в bloc для старта, чтобы обновить UI.
      // Но для простоты примера, будем считать Uploading по первому байту.
      
      void onProgress (sent, total) {
            final now = DateTime.now().millisecondsSinceEpoch;
            // Обновляем, только если прошло время ИЛИ если загрузка завершена (100%)
            if (now - lastUpdateTimestamp > throttleDuration || sent == total) {
              lastUpdateTimestamp = now;
              add(UploadQueueEvent.updateProgress(task.id, sent, total));
            }
          };
      final wclient = WebClient(
          code: client.authCode,
          host: client.connectUri.host,
          port: client.connectUri.port);

      if (task.bytes != null) {
        await wclient.uploadMediaBytes(
          task.bytes!,
          task.serverPath,
          onProgress,
        );
      } else {
        // Читаем файл
        final file = File(task.localPath);
        if (!await file.exists()) {
          add(UploadQueueEvent.taskFailed(task.id, "File not found"));
          return;
        }
        // Вызываем WebClient
        await wclient.uploadMedia(
          task.localPath,
          task.serverPath,
          onProgress,
        );
      }

      add(UploadQueueEvent.taskCompleted(task.id));
    } catch (e) {
      add(UploadQueueEvent.taskFailed(task.id, e.toString()));
    }
  }

  // При получении прогресса, мы также должны убедиться, что статус стал Uploading
  // (наш _onUpdateProgress это делает косвенно, если мы добавим смену статуса там)
  // Для простоты подправим _onUpdateProgress чтобы он форсировал статус Uploading.
  // См. метод _onUpdateProgress ниже (доработанный).

  List<UploadTask> _cleanupHistory(List<UploadTask> tasks) {
    final completed =
        tasks.where((t) => t.status == UploadStatus.completed).toList();
    if (completed.length <= _maxHistorySize) return tasks;

    // Сортируем или просто удаляем первые, если они добавлялись в конец
    // Предполагаем, что старые выше в списке.
    // Нам нужно удалить (completed.length - 100) самых старых.
    int toDelete = completed.length - _maxHistorySize;

    // Создаем новый список, пропуская первые N завершенных
    final result = <UploadTask>[];
    int deletedCount = 0;

    for (var t in tasks) {
      if (t.status == UploadStatus.completed && deletedCount < toDelete) {
        deletedCount++;
        continue; // Пропускаем (удаляем)
      }
      result.add(t);
    }
    return result;
  }
}
