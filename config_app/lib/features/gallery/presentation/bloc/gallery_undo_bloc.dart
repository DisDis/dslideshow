import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../../src/gallery/gallery_management_repository.dart';

part 'gallery_undo_bloc.freezed.dart';

enum GalleryUndoPhase { idle, restoring, succeeded, failed }

@freezed
abstract class GalleryUndoState with _$GalleryUndoState {
  const factory GalleryUndoState({
    @Default(GalleryUndoPhase.idle) GalleryUndoPhase phase,
    GalleryOperationRequest? request,
    GalleryOperationResult? result,
    GalleryErrorCode? error,
    @Default(0) int missingCount,
  }) = _GalleryUndoState;
}

@freezed
sealed class GalleryUndoEvent with _$GalleryUndoEvent {
  const factory GalleryUndoEvent.restore(Completer<GalleryOperationResult> completion) = GalleryUndoRestoreRequested;
}

/// Lives as long as the snackbar and any request it starts, independently of
/// the originating gallery route. Every attempt reads the current trash list;
/// missing entries cannot prove whether an earlier unknown restore succeeded.
class GalleryUndoBloc extends Bloc<GalleryUndoEvent, GalleryUndoState> {
  static final _log = Logger('GalleryUndoBloc');
  GalleryUndoBloc({required this.repository, required List<String> trashIds})
    : _trashIds = Set.unmodifiable(trashIds),
      super(const GalleryUndoState()) {
    on<GalleryUndoRestoreRequested>(_restore);
  }

  final GalleryManagementRepository repository;
  final Set<String> _trashIds;
  Future<GalleryOperationResult>? _restoring;
  Future<void>? _closingFuture;
  bool _closing = false;

  Future<GalleryOperationResult> restore() {
    if (_closing || isClosed) {
      return Future.error(const GalleryManagementException(GalleryErrorCode.cancelled));
    }
    final pending = _restoring;
    if (pending != null) return pending;
    final result = state.result;
    if (state.phase == GalleryUndoPhase.succeeded && result != null) {
      _log.fine(() => 'event=restoreResultReused items=${result.items.length}');
      return Future.value(result);
    }
    final completion = Completer<GalleryOperationResult>();
    _restoring = completion.future.whenComplete(() => _restoring = null);
    add(GalleryUndoRestoreRequested(completion));
    return _restoring!;
  }

  Future<void> _restore(GalleryUndoRestoreRequested event, Emitter<GalleryUndoState> emit) async {
    final requestId = repository.newOperationId();
    final retry = state.phase == GalleryUndoPhase.failed;
    _log.info('event=restoreStarted action=restore items=${_trashIds.length} retry=$retry');
    emit(state.copyWith(phase: GalleryUndoPhase.restoring, error: null));
    try {
      final catalog = await repository.trash();
      final present = {
        for (final entry in catalog.entries)
          if (_trashIds.contains(entry.trashId)) entry.trashId: entry,
      };
      final request = GalleryOperationRequest(
        operationId: requestId,
        action: GalleryMutation.restore,
        items: present.values
            .map((entry) => GalleryMediaRef(mediaId: entry.trashId, sourceRevision: entry.sourceRevision))
            .toList(),
      );
      emit(state.copyWith(request: request));
      final response = request.items.isEmpty
          ? GalleryOperationResult(operationId: requestId, items: const [])
          : await repository.operate(request);
      final result = response;
      final missing = _trashIds.length - present.length;
      final failed = result.items.where((item) => item.state == GalleryItemOperationState.failed).length;
      final message =
          'event=${failed == 0 ? 'restoreCompleted' : 'restorePartial'} action=restore items=${result.items.length} succeeded=${result.items.length - failed} failed=$failed missing=$missing';
      failed == 0 ? _log.info(message) : _log.warning(message);
      emit(state.copyWith(phase: GalleryUndoPhase.succeeded, result: result, missingCount: missing));
      event.completion.complete(result);
    } catch (error, stack) {
      _log.warning(
        'event=restoreFailed action=restore code=${error is GalleryManagementException ? error.code.name : GalleryErrorCode.unknown.name} type=${error.runtimeType}',
      );
      emit(
        state.copyWith(
          phase: GalleryUndoPhase.failed,
          request: null,
          error: error is GalleryManagementException ? error.code : GalleryErrorCode.unknown,
        ),
      );
      event.completion.completeError(error, stack);
    }
  }

  @override
  Future<void> close() => _closingFuture ??= () async {
    _closing = true;
    _log.fine(() => 'event=closed restoring=${_restoring != null}');
    try {
      await _restoring;
    } catch (_) {
      // The caller observes the operation error. Closing still releases Bloc.
    }
    await super.close();
  }();
}
