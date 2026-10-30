import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:config_app/src/gallery/gallery_log.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'gallery_mutation_confirmation.dart';

part 'gallery_viewer_bloc.freezed.dart';
part 'gallery_viewer_event.dart';
part 'gallery_viewer_state.dart';

/// Owns the viewer's media/revision and request lifecycle. Presentation effects
/// carry no context, navigation, dialogs, animation controllers or sessions.
class GalleryViewerBloc extends Bloc<GalleryViewerEvent, GalleryViewerState> {
  static final _log = Logger('GalleryViewerBloc');
  GalleryViewerBloc({required GalleryViewerConfiguration configuration})
    : _configuration = configuration,
      _queuedConfiguration = configuration,
      super(_initialState(configuration)) {
    on<ViewerConfigured>(_onConfigured);
    on<ViewerItemChanged>((event, emit) {
      if (event.subscriptionGeneration == _subscriptionGeneration) {
        _receiveItem(event.item, emit);
      }
    });
    on<ViewerInfoToggled>(_onInfoToggled);
    on<ViewerMetadataRequested>((event, emit) => _loadMetadata(emit));
    on<ViewerMetadataCompleted>(_onMetadataCompleted);
    on<ViewerRotationRequested>(_onRotationRequested);
    on<ViewerRotationCompleted>(_onRotationCompleted);
    on<ViewerMutationRequested>(_onMutationRequested);
    on<ViewerMutationDecision>(_onMutationDecision);
    on<ViewerMutationCompleted>(_onMutationCompleted);
    _subscribe();
  }

  GalleryViewerConfiguration _configuration;
  GalleryViewerConfiguration _queuedConfiguration;
  StreamSubscription<GalleryItem?>? _subscription;
  Future<void> _subscriptionCleanup = Future.value();
  int _subscriptionGeneration = 0;
  int _metadataGeneration = 0;
  int _operationGeneration = 0;
  int _confirmationId = 0;
  Completer<void>? _metadataCancel;
  Completer<void>? _operationCancel;
  bool _closing = false;
  Future<void>? _closeFuture;

  static GalleryViewerState _initialState(GalleryViewerConfiguration inputs) {
    final current = inputs.currentItem == null ? inputs.item : inputs.currentItem!();
    return GalleryViewerState(
      item: current ?? inputs.item,
      missing: current == null,
      managementAvailable: inputs.management != null,
      capabilities: Set.unmodifiable(inputs.capabilities),
      trashEntry: inputs.trashEntry,
      showInfo: !inputs.capabilities.contains(GalleryCapability.metadata),
    );
  }

  /// A stateless host can submit changing route inputs without owning a second
  /// subscription or mirroring this state in widget fields.
  void configure(GalleryViewerConfiguration configuration) {
    if (_closing || configuration == _queuedConfiguration) return;
    _queuedConfiguration = configuration;
    add(GalleryViewerEvent.configured(configuration));
  }

  void _subscribe() {
    final previous = _subscription;
    final generation = ++_subscriptionGeneration;
    if (previous != null) {
      _subscriptionCleanup = Future.wait([_subscriptionCleanup, previous.cancel()]).then((_) {});
    }
    _subscription = _configuration.itemUpdates?.listen(
      (item) {
        _post(GalleryViewerEvent.itemChanged(item, generation));
      },
      onError: (Object _) {
        // A failed optional catalogue stream must not replace a confirmed frame
        // with an older snapshot or infer that its original was deleted.
      },
    );
  }

  void _onConfigured(ViewerConfigured event, Emitter<GalleryViewerState> emit) {
    if (_closing) return;
    final previous = _configuration;
    _configuration = event.configuration;
    if (previous.itemUpdates != _configuration.itemUpdates) _subscribe();
    final contextChanged =
        previous.management != _configuration.management ||
        previous.trashEntry?.trashId != _configuration.trashEntry?.trashId ||
        previous.trashEntry?.sourceRevision != _configuration.trashEntry?.sourceRevision;
    if (contextChanged) {
      if (state.confirmation != null) ++_confirmationId;
      _cancelMetadata();
      _cancelOperation();
    }
    emit(
      state.copyWith(
        capabilities: Set.unmodifiable(_configuration.capabilities),
        managementAvailable: _configuration.management != null,
        trashEntry: _configuration.trashEntry,
        metadata: contextChanged ? null : state.metadata,
        metadataStatus: contextChanged ? GalleryViewerMetadataStatus.idle : state.metadataStatus,
        operation: contextChanged ? GalleryViewerOperation.idle : state.operation,
        mutationRequest: contextChanged ? null : state.mutationRequest,
      ),
    );
    if (previous.item != _configuration.item) {
      _receiveItem(_configuration.item, emit);
    }
    if (_configuration.currentItem != null) {
      _receiveItem(_configuration.currentItem!(), emit);
    }
    if (!state.canReadMetadata) {
      _cancelMetadata();
      emit(
        state.copyWith(
          metadataStatus: state.metadata == null ? GalleryViewerMetadataStatus.idle : GalleryViewerMetadataStatus.ready,
        ),
      );
    } else if (state.showInfo && state.metadata == null && !state.metadataLoading) {
      _loadMetadata(emit);
    }
  }

  bool _canAccept(GalleryItem item) =>
      item.mediaId != state.item.mediaId ||
      item.scope != state.item.scope ||
      !state.supersededRevisions.contains(item.revision);

  Set<String> _superseded(GalleryItem item) => item.mediaId != state.item.mediaId || item.scope != state.item.scope
      ? {}
      : {...state.supersededRevisions, if (item.revision != state.item.revision) state.item.revision};

  void _receiveItem(GalleryItem? item, Emitter<GalleryViewerState> emit) {
    if (item != null && !_canAccept(item)) {
      _log.fine(
        () =>
            'event=supersededRevisionIgnored source=${GalleryLog.source(item.mediaId)} revision=${GalleryLog.source(item.revision)}',
      );
      return;
    }
    final changed = item == null
        ? !state.missing
        : state.missing || item.selectionIdentity != state.item.selectionIdentity || item.scope != state.item.scope;
    if (!changed) {
      if (item != null && item != state.item) emit(state.copyWith(item: item));
      return;
    }
    if (state.confirmation != null) ++_confirmationId;
    _cancelMetadata();
    _cancelOperation();
    emit(
      state.copyWith(
        item: item ?? state.item,
        missing: item == null,
        supersededRevisions: item == null ? state.supersededRevisions : _superseded(item),
        metadata: null,
        metadataStatus: GalleryViewerMetadataStatus.idle,
        metadataError: null,
        operation: GalleryViewerOperation.idle,
        operationError: null,
        mutationRequest: null,
      ),
    );
    if (state.showInfo && state.canReadMetadata) _loadMetadata(emit);
  }

  void _onInfoToggled(ViewerInfoToggled event, Emitter<GalleryViewerState> emit) {
    if (_closing) return;
    if (state.showInfo) {
      _cancelMetadata();
      emit(
        state.copyWith(
          showInfo: false,
          metadataStatus: state.metadata == null ? GalleryViewerMetadataStatus.idle : GalleryViewerMetadataStatus.ready,
        ),
      );
    } else {
      emit(state.copyWith(showInfo: true));
      if (state.metadata == null) _loadMetadata(emit);
    }
  }

  void _loadMetadata(Emitter<GalleryViewerState> emit) {
    if (!state.showInfo || !state.canReadMetadata || _closing) return;
    _cancelMetadata();
    final generation = _metadataGeneration;
    final cancel = _metadataCancel = Completer<void>();
    final item = state.item;
    final trash = state.trash;
    final repository = _configuration.management!;
    _log.fine(
      () =>
          'event=metadataStarted generation=$generation source=${GalleryLog.source(item.mediaId)} revision=${GalleryLog.source(item.revision)} trash=$trash',
    );
    emit(state.copyWith(metadataStatus: GalleryViewerMetadataStatus.loading, metadataError: null));
    unawaited(() async {
      try {
        final data = await repository.metadata(item, cancel: cancel.future, trash: trash);
        _post(GalleryViewerEvent.metadataCompleted(generation: generation, data: data));
      } catch (error) {
        _post(GalleryViewerEvent.metadataCompleted(generation: generation, error: _code(error)));
      }
    }());
  }

  void _onMetadataCompleted(ViewerMetadataCompleted event, Emitter<GalleryViewerState> emit) {
    if (event.generation != _metadataGeneration || !state.showInfo || state.missing) {
      return;
    }
    _finishMetadata();
    final data = event.data;
    final valid = data != null && data.mediaId == state.item.mediaId && data.sourceRevision == state.item.revision;
    if (valid) {
      _log.fine(() => 'event=metadataCompleted generation=${event.generation}');
    } else {
      _log.warning(
        'event=metadataFailed generation=${event.generation} code=${(event.error ?? GalleryErrorCode.revisionMismatch).name}',
      );
    }
    emit(
      state.copyWith(
        metadata: valid ? data : null,
        metadataStatus: valid ? GalleryViewerMetadataStatus.ready : GalleryViewerMetadataStatus.failed,
        metadataError: valid ? null : event.error ?? GalleryErrorCode.revisionMismatch,
      ),
    );
  }

  void _onRotationRequested(ViewerRotationRequested event, Emitter<GalleryViewerState> emit) {
    if (_closing || state.busy || state.confirmation != null || !state.canRotate) {
      return;
    }
    final repository = _configuration.management!;
    final request = GalleryRotateRequest(
      operationId: repository.newOperationId(),
      mediaId: state.item.mediaId,
      sourceRevision: state.item.revision,
      rotation: event.rotation,
    );
    _cancelMetadata();
    _cancelOperation();
    final generation = _operationGeneration;
    final cancel = _operationCancel = Completer<void>();
    _log.info('event=rotationStarted rotation=${request.rotation.name} items=1');
    emit(
      state.copyWith(
        operation: GalleryViewerOperation.rotating,
        operationError: null,
        metadataStatus: state.metadata == null ? GalleryViewerMetadataStatus.idle : GalleryViewerMetadataStatus.ready,
      ),
    );
    unawaited(() async {
      try {
        final data = await repository.rotate(request, cancel: cancel.future);
        _post(GalleryViewerEvent.rotationCompleted(generation: generation, data: data));
      } catch (error) {
        _post(GalleryViewerEvent.rotationCompleted(generation: generation, error: _code(error)));
      }
    }());
  }

  void _onRotationCompleted(ViewerRotationCompleted event, Emitter<GalleryViewerState> emit) {
    if (event.generation != _operationGeneration || state.operation != GalleryViewerOperation.rotating) {
      return;
    }
    _finishOperation();
    final data = event.data;
    if (data == null || data.mediaId != state.item.mediaId) {
      _operationFailed(event.error ?? GalleryErrorCode.processingFailed, emit, refreshCatalog: true);
      return;
    }
    final item = _configuration.management!.updatedItem(state.item, data);
    if (item.revision.isEmpty || !_canAccept(item)) {
      _operationFailed(GalleryErrorCode.revisionMismatch, emit, refreshCatalog: true);
      return;
    }
    _cancelMetadata();
    _log.info('event=rotationCompleted items=1');
    emit(
      state.copyWith(
        item: item,
        supersededRevisions: _superseded(item),
        metadata: data,
        metadataStatus: GalleryViewerMetadataStatus.ready,
        metadataError: null,
        operation: GalleryViewerOperation.idle,
        operationError: null,
        effectId: state.effectId + 1,
        effect: const GalleryViewerEffect.rotationApplied(),
      ),
    );
  }

  void _onMutationRequested(ViewerMutationRequested event, Emitter<GalleryViewerState> emit) {
    if (_closing || state.busy || state.confirmation != null || !state.canMutate(event.action)) {
      return;
    }
    if (event.action == GalleryMutation.purge || event.action == GalleryMutation.trash) {
      final confirmation = GalleryMutationConfirmation(
        token: ++_confirmationId,
        action: event.action,
        items: [GalleryMediaRef(mediaId: state.item.mediaId, sourceRevision: state.item.revision)],
        names: [state.item.title],
        sizeBytes: event.action == GalleryMutation.purge ? state.trashEntry!.sizeBytes : null,
      );
      _log.info('event=confirmationRequested token=${confirmation.token} action=${event.action.name} items=1');
      emit(
        state.copyWith(
          confirmation: confirmation,
          effectId: state.effectId + 1,
          effect: GalleryViewerEffect.mutationConfirmation(confirmation),
        ),
      );
      return;
    }
    _beginMutation(event.action, emit);
  }

  void _onMutationDecision(ViewerMutationDecision event, Emitter<GalleryViewerState> emit) {
    if (_closing) return;
    final confirmation = state.confirmation;
    if (confirmation == null || confirmation.token != event.confirmationId) {
      return;
    }
    final ref = confirmation.items.single;
    final current = _configuration.currentItem == null ? state.item : _configuration.currentItem!();
    final valid =
        confirmation.token == _confirmationId &&
        !state.busy &&
        state.canMutate(confirmation.action) &&
        current != null &&
        current.mediaId == ref.mediaId &&
        current.revision == ref.sourceRevision &&
        current.scope == state.item.scope &&
        state.item.mediaId == ref.mediaId &&
        state.item.revision == ref.sourceRevision;
    emit(state.copyWith(confirmation: null));
    if (!event.confirmed) {
      _log.fine(
        () => 'event=confirmationCancelled token=${event.confirmationId} action=${confirmation.action.name} items=1',
      );
      return;
    }
    if (!valid) {
      _log.fine(
        () =>
            'event=confirmationRejected token=${event.confirmationId} action=${confirmation.action.name} code=revisionMismatch',
      );
      emit(state.copyWith(effectId: state.effectId + 1, effect: const GalleryViewerEffect.confirmationChanged()));
      return;
    }
    _log.info('event=confirmationAccepted token=${event.confirmationId} action=${confirmation.action.name} items=1');
    _beginMutation(confirmation.action, emit);
  }

  void _beginMutation(GalleryMutation action, Emitter<GalleryViewerState> emit) {
    final repository = _configuration.management!;
    final request = GalleryOperationRequest(
      operationId: repository.newOperationId(),
      action: action,
      items: [GalleryMediaRef(mediaId: state.item.mediaId, sourceRevision: state.item.revision)],
    );
    _cancelMetadata();
    _cancelOperation();
    final generation = _operationGeneration;
    final cancel = _operationCancel = Completer<void>();
    _log.info('event=mutationStarted action=${request.action.name} items=1');
    emit(
      state.copyWith(
        mutationRequest: request,
        operationError: null,
        metadataStatus: state.metadata == null ? GalleryViewerMetadataStatus.idle : GalleryViewerMetadataStatus.ready,
        operation: switch (action) {
          GalleryMutation.trash => GalleryViewerOperation.trashing,
          GalleryMutation.restore => GalleryViewerOperation.restoring,
          GalleryMutation.purge => GalleryViewerOperation.purging,
        },
      ),
    );
    unawaited(() async {
      try {
        final result = await repository.operate(request, cancel: cancel.future);
        _post(GalleryViewerEvent.mutationCompleted(generation: generation, result: result));
      } catch (error) {
        _post(GalleryViewerEvent.mutationCompleted(generation: generation, error: _code(error)));
      }
    }());
  }

  void _onMutationCompleted(ViewerMutationCompleted event, Emitter<GalleryViewerState> emit) {
    if (event.generation != _operationGeneration || state.mutationRequest == null || !state.busy) {
      return;
    }
    _finishOperation();
    final result = event.result;
    if (result == null) {
      _operationFailed(event.error ?? GalleryErrorCode.processingFailed, emit, refreshCatalog: true);
      return;
    }
    final request = state.mutationRequest!;
    if (result.operationId != request.operationId ||
        result.items.length != 1 ||
        result.items.single.mediaId != request.items.single.mediaId) {
      _operationFailed(GalleryErrorCode.processingFailed, emit, refreshCatalog: true);
      return;
    }
    emit(state.copyWith(mutationRequest: null));
    final item = result.items.single;
    if (item.state != GalleryItemOperationState.succeeded) {
      _operationFailed(item.error ?? GalleryErrorCode.unknown, emit, refreshCatalog: true);
      return;
    }
    _log.info('event=mutationCompleted action=${request.action.name} items=1 succeeded=1 failed=0');
    emit(
      state.copyWith(
        missing: true,
        operation: GalleryViewerOperation.idle,
        operationError: null,
        effectId: state.effectId + 1,
        effect: GalleryViewerEffect.mutationApplied(
          action: request.action,
          trashIds: [if (item.trashId != null) item.trashId!],
        ),
      ),
    );
  }

  void _operationFailed(GalleryErrorCode code, Emitter<GalleryViewerState> emit, {bool refreshCatalog = false}) {
    _log.warning('event=operationFailed action=${state.operation.name} code=${code.name}');
    emit(
      state.copyWith(
        operation: GalleryViewerOperation.idle,
        operationError: code,
        mutationRequest: refreshCatalog ? null : state.mutationRequest,
        effectId: state.effectId + 1,
        effect: GalleryViewerEffect.operationFailed(code, refreshCatalog: refreshCatalog),
      ),
    );
    if (state.showInfo && state.metadata == null) _loadMetadata(emit);
  }

  void _cancelMetadata() {
    if (_metadataCancel != null) {
      _log.fine(() => 'event=metadataCancelled generation=$_metadataGeneration');
    }
    ++_metadataGeneration;
    _finishMetadata();
  }

  void _finishMetadata() {
    final cancel = _metadataCancel;
    _metadataCancel = null;
    if (cancel != null && !cancel.isCompleted) cancel.complete();
  }

  void _cancelOperation() {
    if (_operationCancel != null) {
      _log.fine(() => 'event=operationCancelled action=${state.operation.name}');
    }
    ++_operationGeneration;
    _finishOperation();
  }

  void _finishOperation() {
    final cancel = _operationCancel;
    _operationCancel = null;
    if (cancel != null && !cancel.isCompleted) cancel.complete();
  }

  static GalleryErrorCode _code(Object error) =>
      error is GalleryManagementException ? error.code : GalleryErrorCode.unknown;
  void _post(GalleryViewerEvent event) {
    if (!_closing && !isClosed) add(event);
  }

  @override
  Future<void> close() {
    if (_closeFuture != null) return _closeFuture!;
    _closing = true;
    _log.fine(() => 'event=closed operation=${state.operation.name} metadataLoading=${state.metadataLoading}');
    _cancelMetadata();
    _cancelOperation();
    ++_subscriptionGeneration;
    final subscription = _subscription;
    _subscription = null;
    return _closeFuture = Future.wait([
      _subscriptionCleanup,
      if (subscription != null) subscription.cancel(),
      super.close(),
    ]).then((_) {});
  }
}
