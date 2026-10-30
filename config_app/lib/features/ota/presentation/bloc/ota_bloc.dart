import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'ota_client.dart';
import 'ota_event.dart';
import 'ota_state.dart';

typedef OtaFilePicker = Future<PlatformFile?> Function();
typedef OtaClientFactory = OTAClient Function(Uri baseUri);

enum _OtaAction { initialize, selectFile, upload }

enum _OtaCancelReason { reset, close }

/// Owns selection, lazy file access and one cancellable panel action at a time.
class OtaBloc extends Bloc<OtaEvent, OtaState> {
  OtaBloc({
    OtaState initialState = const OtaState(),
    required this.client,
    OtaFilePicker? picker,
    OtaClientFactory? otaClientFactory,
  }) : _picker = picker ?? _pickFirmware,
       _otaClientFactory = otaClientFactory ?? ((uri) => OTAClient(baseUri: uri)),
       super(initialState) {
    on<InitOtaEvent>(_onInit);
    on<PickFileOtaEvent>(_onPickFile);
    on<CodeChangedOtaEvent>((event, emit) {
      if (!_closing && state.phase != OtaPhase.uploading) {
        emit(state.copyWith(code: event.value, failure: null));
      }
    });
    on<UploadFileOtaEvent>(_onUploadFile);
    on<ResetOtaEvent>(_onReset);
  }

  static final _log = Logger('OtaBloc');
  final RealtimeService client;
  final OtaFilePicker _picker;
  final OtaClientFactory _otaClientFactory;
  PlatformFile? _selectedFile;
  _OtaAttempt? _attempt;
  bool _closing = false;
  Future<void>? _closeFuture;

  Uri get otaBaseUri => Uri(scheme: 'http', host: client.connectUri.host, port: 8282);
  Uri get otaStartUri => otaBaseUri.resolve('/ota_start');

  static Future<PlatformFile?> _pickFirmware() =>
      FilePicker.pickFile(type: FileType.custom, allowedExtensions: const ['deb']);

  _OtaAttempt _begin(_OtaAction action) {
    final attempt = _OtaAttempt(action);
    _attempt = attempt;
    _log.info('event=started action=${action.name}');
    return attempt;
  }

  bool _current(_OtaAttempt attempt, Emitter<OtaState> emit) =>
      !_closing && !emit.isDone && identical(_attempt, attempt) && !attempt.cancelled;

  Future<T> _wait<T>(Future<T> pending, _OtaAttempt attempt) => Future.any<T>([
    pending,
    attempt.cancellation.future.then<T>((_) => throw const OtaClientException(OtaFailure.cancelled)),
  ]);

  Future<int?> _readLength(PlatformFile file, _OtaAttempt attempt) {
    final pending = Future<int?>.sync(file.length);
    // PlatformFile metadata can perform fallback I/O and has no abort API.
    // Observe errors immediately, and retain ownership until that I/O settles.
    attempt.metadataFinished = pending.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return _wait(pending, attempt);
  }

  Future<void> _finish(_OtaAttempt attempt) async {
    try {
      await attempt.metadataFinished;
      await attempt.gateway?.close();
    } finally {
      if (identical(_attempt, attempt)) _attempt = null;
      attempt.finished.complete();
    }
  }

  void _completed(_OtaAttempt attempt, {String details = ''}) {
    _log.info('event=completed action=${attempt.action.name}$details');
  }

  void _failed(_OtaAttempt attempt, OtaFailure failure) {
    _log.warning('event=failed action=${attempt.action.name} code=${failure.name}');
  }

  Future<void> _onInit(InitOtaEvent event, Emitter<OtaState> emit) async {
    if (_closing ||
        _attempt != null ||
        (state.phase != OtaPhase.uninitialized && !(state.phase == OtaPhase.failed && state.version.isEmpty))) {
      return;
    }
    final attempt = _begin(_OtaAction.initialize);
    emit(state.copyWith(phase: OtaPhase.initializing, failure: null));
    try {
      final gateway = attempt.gateway = _otaClientFactory(otaBaseUri);
      final version = await _wait(gateway.start(cancellation: attempt.cancellation.future), attempt);
      if (!_current(attempt, emit)) return;
      emit(state.copyWith(phase: OtaPhase.ready, version: version));
      _completed(attempt);
    } catch (error) {
      if (!_current(attempt, emit)) return;
      final failure = error is OtaClientException ? error.failure : OtaFailure.requestFailed;
      _failed(attempt, failure);
      emit(state.copyWith(phase: OtaPhase.failed, failure: failure));
    } finally {
      await _finish(attempt);
    }
  }

  Future<void> _onPickFile(PickFileOtaEvent event, Emitter<OtaState> emit) async {
    if (_closing || _attempt != null || state.version.isEmpty || state.phase == OtaPhase.completed) {
      return;
    }
    final attempt = _begin(_OtaAction.selectFile);
    // A cancelled dialog must never leave a previously chosen file ready to send.
    _selectedFile = null;
    emit(state.copyWith(phase: OtaPhase.ready, pickingFile: true, filename: null, fileSize: null, failure: null));
    try {
      final file = await _wait(_picker(), attempt);
      if (!_current(attempt, emit)) return;
      if (file == null) {
        emit(state.copyWith(pickingFile: false));
        _log.info('event=cancelled action=selectFile reason=picker');
        return;
      }
      if (path.extension(file.name).toLowerCase() != '.deb') {
        throw const OtaClientException(OtaFailure.invalidFile);
      }
      final length = await _readLength(file, attempt);
      if (!_current(attempt, emit)) return;
      if (length == null) {
        throw const OtaClientException(OtaFailure.fileUnavailable);
      }
      if (length <= 0) throw const OtaClientException(OtaFailure.emptyFile);
      _selectedFile = file;
      emit(state.copyWith(pickingFile: false, filename: file.name, fileSize: length));
      _completed(attempt, details: ' bytes=$length');
    } catch (error) {
      if (!_current(attempt, emit)) return;
      final failure = error is OtaClientException ? error.failure : OtaFailure.fileUnavailable;
      _failed(attempt, failure);
      emit(state.copyWith(pickingFile: false, failure: failure));
    } finally {
      await _finish(attempt);
    }
  }

  Future<void> _onUploadFile(UploadFileOtaEvent event, Emitter<OtaState> emit) async {
    final file = _selectedFile;
    if (_closing || _attempt != null || !state.canSubmit || file == null) {
      return;
    }
    final code = state.code;
    final attempt = _begin(_OtaAction.upload);
    emit(state.copyWith(phase: OtaPhase.uploading, progress: 0, failure: null));
    try {
      final length = await _readLength(file, attempt);
      if (!_current(attempt, emit)) return;
      if (length == null) {
        throw const OtaClientException(OtaFailure.fileUnavailable);
      }
      if (length <= 0) throw const OtaClientException(OtaFailure.emptyFile);
      final gateway = attempt.gateway = _otaClientFactory(otaBaseUri);
      final progressClock = Stopwatch()..start();
      var lastProgressMs = -250;
      await _wait(
        gateway.uploadFile(
          code: code,
          file: file,
          length: length,
          cancellation: attempt.cancellation.future,
          onProgress: (sent, total) {
            if (!_current(attempt, emit)) return;
            final now = progressClock.elapsedMilliseconds;
            if (now - lastProgressMs < 250 && sent != total) return;
            lastProgressMs = now;
            emit(state.copyWith(progress: total <= 0 ? 0 : (sent / total).clamp(0.0, .99)));
          },
        ),
        attempt,
      );
      if (!_current(attempt, emit)) return;
      emit(state.copyWith(phase: OtaPhase.completed, progress: 1, fileSize: length));
      _completed(attempt, details: ' bytes=$length');
    } catch (error) {
      if (!_current(attempt, emit)) return;
      final failure = error is OtaClientException ? error.failure : OtaFailure.requestFailed;
      _failed(attempt, failure);
      if (failure == OtaFailure.emptyFile || failure == OtaFailure.fileUnavailable) {
        _selectedFile = null;
        emit(state.copyWith(phase: OtaPhase.failed, failure: failure, filename: null, fileSize: null));
      } else {
        emit(state.copyWith(phase: OtaPhase.failed, failure: failure));
      }
    } finally {
      await _finish(attempt);
    }
  }

  Future<void> _cancel(_OtaCancelReason reason) async {
    final attempt = _attempt;
    if (attempt == null) return;
    if (attempt.cancelled) return attempt.finished.future;
    attempt.cancelled = true;
    attempt.cancellation.complete();
    await attempt.gateway?.close();
    await attempt.finished.future;
    _log.info('event=cancelled action=${attempt.action.name} reason=${reason.name}');
  }

  Future<void> _onReset(ResetOtaEvent event, Emitter<OtaState> emit) async {
    if (_closing) return;
    await _cancel(_OtaCancelReason.reset);
    if (_closing || emit.isDone) return;
    _selectedFile = null;
    emit(OtaState(formGeneration: state.formGeneration + 1));
  }

  @override
  Future<void> close() => _closeFuture ??= _close().whenComplete(() => super.close());

  Future<void> _close() async {
    _closing = true;
    await _cancel(_OtaCancelReason.close);
    _selectedFile = null;
  }
}

class _OtaAttempt {
  _OtaAttempt(this.action);
  final _OtaAction action;
  final cancellation = Completer<void>();
  final finished = Completer<void>();
  Future<void>? metadataFinished;
  OTAClient? gateway;
  bool cancelled = false;
}
