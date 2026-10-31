import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../domain/gallery_item.dart';
import '../../../../src/gallery/gallery_management_repository.dart';
import 'gallery_bloc.dart';
import 'gallery_mutation_confirmation.dart';

part 'gallery_management_event.dart';
part 'gallery_management_state.dart';
part 'gallery_management_bloc.freezed.dart';

/// Owns media-management state while the existing GalleryBloc keeps ownership
/// of catalog refreshes. The shared session repository outlives this screen, so
/// close cancels only this Bloc's requests, leaving snackbar Undo independent.
class GalleryManagementBloc extends Bloc<GalleryManagementEvent, GalleryManagementState> {
  static final _log = Logger('GalleryManagementBloc');
  static const _mutationBatchItems = 1000;
  static const _mutationBatchBytes = 256 * 1024;
  GalleryManagementBloc({required this.catalogBloc, GalleryManagementRepository? repository})
    : repository = repository ?? catalogBloc.session.management,
      super(_initial(catalogBloc)) {
    final catalog = catalogBloc.state;
    _log.fine(() => 'event=opened items=${state.items.length} capabilities=${state.capabilities.length}');
    _librarySnapshot = state.snapshot;
    if (catalog is LoadedGalleryState) {
      _catalogSnapshots[catalog] = _librarySnapshot;
    }
    _updateCombinedCatalog();
    confirmedCatalogUpdates = _combinedCatalogUpdates.stream;
    on<GalleryManagementEvent>(_handle);
    _catalogSubscription = catalogBloc.stream.listen((catalog) {
      if (!_closing) add(GalleryManagementEvent.catalogChanged(catalog));
    });
  }

  final GalleryBloc catalogBloc;
  final GalleryManagementRepository repository;
  late final StreamSubscription<GalleryState> _catalogSubscription;
  late final Stream<List<GalleryItem>> confirmedCatalogUpdates;
  GalleryManagementSnapshot _librarySnapshot = const GalleryManagementSnapshot();
  GalleryManagementSnapshot _trashSnapshot = const GalleryManagementSnapshot();
  GalleryManagementSnapshot _hiddenSnapshot = const GalleryManagementSnapshot();
  List<GalleryItem> _combinedItems = const [];
  final _combinedCatalogUpdates = StreamController<List<GalleryItem>>.broadcast();
  final _catalogSnapshots = Expando<GalleryManagementSnapshot>();
  final _cancel = Completer<void>();
  final _refreshCompletions = <Completer<void>>{};
  final _closeWaiters = <void Function()>{};
  int _trashGeneration = 0;
  int _confirmationEpoch = 0;
  bool _closing = false;
  Future<void>? _closeFuture;

  GalleryManagementSnapshot get _currentLibrarySnapshot {
    final catalog = catalogBloc.state;
    return catalog is LoadedGalleryState && !catalog.refreshing && !catalog.refreshFailed
        ? _indexCatalog(catalog)
        : _librarySnapshot;
  }

  List<GalleryItem> get currentLibraryItems => _currentLibrarySnapshot.items;
  List<GalleryItem> get currentDuplicateItems => _combinedItems;

  void _updateCombinedCatalog() {
    _combinedItems = List.unmodifiable([..._librarySnapshot.items, ..._hiddenSnapshot.items]);
    _combinedCatalogUpdates.add(_combinedItems);
  }

  GalleryItem? currentItem(String id, {GalleryMediaSection mediaSection = GalleryMediaSection.published}) =>
      mediaSection == GalleryMediaSection.hidden
      ? _hiddenSnapshot.byMediaId[id]
      : _currentLibrarySnapshot.byMediaId[id];
  Stream<GalleryItem?> itemUpdates(String id, {GalleryMediaSection mediaSection = GalleryMediaSection.published}) =>
      mediaSection == GalleryMediaSection.hidden
      ? confirmedCatalogUpdates.map((_) => _hiddenSnapshot.byMediaId[id])
      : catalogBloc.stream
            .where((state) => state is LoadedGalleryState && !state.refreshing && !state.refreshFailed)
            .map((state) => _indexCatalog(state as LoadedGalleryState).byMediaId[id]);

  GalleryManagementSnapshot _indexCatalog(LoadedGalleryState catalog) =>
      _catalogSnapshots[catalog] ??= _snapshot(catalog.items);

  static GalleryManagementSnapshot _snapshot(List<GalleryItem> items, {GalleryCatalog? catalog}) {
    final frozenItems = List<GalleryItem>.unmodifiable(items);
    return GalleryManagementSnapshot(
      items: frozenItems,
      bySelectionIdentity: {for (final item in frozenItems) item.selectionIdentity: item},
      byMediaId: {for (final item in frozenItems) item.mediaId: item},
      entriesById: {for (final entry in catalog?.entries ?? const <GalleryEntry>[]) entry.mediaId: entry},
    );
  }

  static GalleryManagementState _initial(GalleryBloc bloc) {
    final catalog = bloc.state;
    return GalleryManagementState(
      snapshot: catalog is LoadedGalleryState ? _snapshot(catalog.items) : const GalleryManagementSnapshot(),
      capabilities: bloc.repository.capabilities,
      catalogStatus: catalog is LoadedGalleryState
          ? GalleryManagementLoadStatus.ready
          : catalog is ErrorGalleryState
          ? GalleryManagementLoadStatus.failed
          : GalleryManagementLoadStatus.loading,
      catalogRefreshing: catalog is LoadedGalleryState && catalog.refreshing,
      catalogRefreshFailed: catalog is LoadedGalleryState && catalog.refreshFailed,
    );
  }

  Future<void> refresh() {
    if (_closing || isClosed) return Future.value();
    final completion = Completer<void>();
    _refreshCompletions.add(completion);
    add(GalleryManagementEvent.refreshRequested(completion));
    return completion.future;
  }

  Future<T> _whileOpen<T>(Future<T> request) {
    final completion = Completer<T>();
    void cancelWait() {
      if (!completion.isCompleted) {
        completion.completeError(const _ManagementClosed());
      }
    }

    _closeWaiters.add(cancelWait);
    unawaited(
      request.then<void>(
        (value) {
          _closeWaiters.remove(cancelWait);
          if (!completion.isCompleted) completion.complete(value);
        },
        onError: (Object error, StackTrace stack) {
          _closeWaiters.remove(cancelWait);
          if (!completion.isCompleted) completion.completeError(error, stack);
        },
      ),
    );
    if (_closing) cancelWait();
    return completion.future;
  }

  Future<void> _handle(GalleryManagementEvent event, Emitter<GalleryManagementState> emit) async {
    if (_closing) {
      if (event is GalleryManagementRefreshRequested) {
        _completeRefresh(event.completion);
      }
      return;
    }
    switch (event) {
      case GalleryManagementCatalogChanged(:final catalog):
        if (catalog is LoadedGalleryState && !catalog.refreshing && !catalog.refreshFailed) {
          _librarySnapshot = _indexCatalog(catalog);
          _updateCombinedCatalog();
        }
        final snapshot = state.isStored ? state.snapshot : _librarySnapshot;
        final selection = state.selectedIds.where(snapshot.bySelectionIdentity.containsKey).toSet();
        if (selection.length != state.selectedIds.length) ++_confirmationEpoch;
        emit(
          state.copyWith(
            snapshot: snapshot,
            selectedIds: selection,
            capabilities: catalogBloc.repository.capabilities,
            catalogStatus: catalog is LoadedGalleryState
                ? GalleryManagementLoadStatus.ready
                : catalog is ErrorGalleryState
                ? GalleryManagementLoadStatus.failed
                : GalleryManagementLoadStatus.loading,
            catalogRefreshing: catalog is LoadedGalleryState && catalog.refreshing,
            catalogRefreshFailed: catalog is LoadedGalleryState && catalog.refreshFailed,
          ),
        );
      case GalleryManagementSectionChanged(:final section):
        if (state.busy || section == state.section) {
          return;
        }
        if (section == GallerySection.duplicates && !state.capabilities.contains(GalleryCapability.duplicates) ||
            section == GallerySection.hidden && !state.capabilities.contains(GalleryCapability.hidden) ||
            section == GallerySection.trash && !state.capabilities.contains(GalleryCapability.trash)) {
          return;
        }
        _log.fine(
          () =>
              'event=sectionChanged from=${state.section.name} to=${section.name} selected=${state.selectedIds.length}',
        );
        ++_trashGeneration;
        ++_confirmationEpoch;
        final snapshot = section == GallerySection.trash
            ? _trashSnapshot
            : section == GallerySection.hidden
            ? _hiddenSnapshot
            : _librarySnapshot;
        emit(
          state.copyWith(
            section: section,
            snapshot: snapshot,
            selectedIds: {},
            failures: [],
            failureSnapshot: null,
            trashLoading: false,
            hiddenLoading: false,
          ),
        );
        if (section == GallerySection.trash) await _loadTrash(emit);
        if (section == GallerySection.hidden || section == GallerySection.duplicates) {
          if (state.capabilities.contains(GalleryCapability.hidden)) await _loadHidden(emit);
        }
      case GalleryManagementSelectionToggled(:final selectionIdentity):
        if (state.busy ||
            state.section == GallerySection.duplicates ||
            state.snapshot.bySelectionIdentity[selectionIdentity] == null ||
            state.snapshot.bySelectionIdentity[selectionIdentity]!.isFolder) {
          return;
        }
        final selection = {...state.selectedIds};
        ++_confirmationEpoch;
        if (!selection.remove(selectionIdentity)) {
          selection.add(selectionIdentity);
        }
        emit(state.copyWith(selectedIds: selection));
      case GalleryManagementSelectionCleared():
        if (!state.busy) {
          ++_confirmationEpoch;
          emit(state.copyWith(selectedIds: {}));
        }
      case GalleryManagementTrashSelectionAllRequested():
        if (!state.isTrash || state.busy || state.confirmation != null) return;
        ++_confirmationEpoch;
        emit(state.copyWith(selectedIds: state.snapshot.bySelectionIdentity.keys.toSet()));
      case GalleryManagementClearTrashRequested():
        if (state.confirmation != null) {
          return;
        }
        _requestConfirmation(GalleryMutation.purge, emit, scope: GalleryMutationScope.allTrash);
      case GalleryManagementTrashRequested():
        if (state.isStored && !state.busy) {
          state.isHidden ? await _loadHidden(emit) : await _loadTrash(emit);
        }
      case GalleryManagementMutationRequested(:final action):
        if (state.confirmation != null) return;
        if (action == GalleryMutation.restore || action == GalleryMutation.unhide) {
          await _mutate(action, emit);
        } else {
          _requestConfirmation(action, emit);
        }
      case GalleryManagementMutationDecision(:final confirmationId, :final confirmed):
        final confirmation = state.confirmation;
        if (confirmation == null || confirmation.token != confirmationId) {
          return;
        }
        final valid = _confirmationValid(confirmation);
        emit(state.copyWith(confirmation: null));
        if (!confirmed) {
          _log.fine(
            () =>
                'event=confirmationCancelled token=$confirmationId action=${confirmation.action.name} items=${confirmation.items.length}',
          );
          return;
        }
        if (!valid) {
          _log.fine(
            () =>
                'event=confirmationRejected token=$confirmationId action=${confirmation.action.name} code=revisionMismatch',
          );
          emit(
            state.copyWith(notice: GalleryManagementNotice.confirmationChanged, noticeSerial: state.noticeSerial + 1),
          );
          return;
        }
        _log.info(
          'event=confirmationAccepted token=$confirmationId action=${confirmation.action.name} items=${confirmation.items.length}',
        );
        await _mutate(confirmation.action, emit, confirmation: confirmation);
      case GalleryManagementRefreshRequested(:final completion):
        try {
          await _whileOpen(catalogBloc.refresh());
          if (!_closing && !emit.isDone && state.isTrash) {
            await _loadTrash(emit);
          }
          if (!_closing &&
              !emit.isDone &&
              (state.isHidden || state.section == GallerySection.duplicates) &&
              state.capabilities.contains(GalleryCapability.hidden)) {
            await _loadHidden(emit);
          }
        } on _ManagementClosed {
          /* The shared catalog operation may finish later. */
        } finally {
          _completeRefresh(completion);
        }
    }
  }

  List<GalleryItem> _trashItems(GalleryCatalog? catalog) =>
      catalog?.entries
          .map(
            (entry) =>
                repository.mediaItem(entry, catalogBloc.repository.authScope, thumbnailPolicy: catalog.thumbnailPolicy),
          )
          .toList(growable: false) ??
      const [];

  Future<void> _loadTrash(Emitter<GalleryManagementState> emit) async {
    final generation = ++_trashGeneration;
    _log.info('event=trashLoadStarted generation=$generation');
    emit(state.copyWith(trashLoading: true, trashFailed: false));
    try {
      final catalog = await _whileOpen(repository.catalog(GalleryMediaSection.trash, cancel: _cancel.future));
      if (_closing || emit.isDone || generation != _trashGeneration) {
        _log.fine(() => 'event=trashLoadDiscarded generation=$generation');
        return;
      }
      _log.info('event=trashLoadCompleted generation=$generation entries=${catalog.entries.length}');
      _trashSnapshot = _snapshot(_trashItems(catalog), catalog: catalog);
      final snapshot = state.isTrash ? _trashSnapshot : state.snapshot;
      final selection = state.selectedIds.where(snapshot.bySelectionIdentity.containsKey).toSet();
      if (selection.length != state.selectedIds.length) ++_confirmationEpoch;
      emit(
        state.copyWith(
          trash: catalog,
          snapshot: snapshot,
          selectedIds: selection,
          trashLoading: false,
          trashFailed: false,
        ),
      );
    } catch (error, stack) {
      if (_closing || error is _ManagementClosed) {
        _log.fine(() => 'event=trashLoadCancelled generation=$generation', error, stack);
      } else {
        final code = error is GalleryManagementException ? error.code.name : GalleryErrorCode.unknown.name;
        _log.warning('event=trashLoadFailed generation=$generation code=$code type=${error.runtimeType}', error, stack);
      }
      if (!_closing && !emit.isDone && generation == _trashGeneration) {
        emit(state.copyWith(trashLoading: false, trashFailed: true));
      }
    }
  }

  Future<void> _loadHidden(Emitter<GalleryManagementState> emit) async {
    final generation = ++_trashGeneration;
    _log.info('event=hiddenLoadStarted');
    emit(state.copyWith(hiddenLoading: true, hiddenFailed: false));
    try {
      final catalog = await _whileOpen(repository.catalog(GalleryMediaSection.hidden, cancel: _cancel.future));
      if (_closing || emit.isDone || generation != _trashGeneration) {
        _log.fine('event=hiddenLoadDiscarded');
        return;
      }
      _hiddenSnapshot = _snapshot([
        for (final entry in catalog.entries)
          repository.mediaItem(entry, catalogBloc.repository.authScope, thumbnailPolicy: catalog.thumbnailPolicy),
      ], catalog: catalog);
      _updateCombinedCatalog();
      final snapshot = state.isHidden ? _hiddenSnapshot : state.snapshot;
      emit(
        state.copyWith(
          hidden: catalog,
          hiddenLoading: false,
          hiddenFailed: false,
          snapshot: snapshot,
          selectedIds: state.selectedIds.where(snapshot.bySelectionIdentity.containsKey).toSet(),
        ),
      );
      _log.info('event=hiddenLoadCompleted entries=${catalog.entries.length}');
    } catch (error, stack) {
      if (_closing || error is _ManagementClosed) {
        _log.fine('event=hiddenLoadCancelled', error, stack);
      } else {
        final code = error is GalleryManagementException ? error.code.name : GalleryErrorCode.unknown.name;
        _log.warning('event=hiddenLoadFailed code=$code type=${error.runtimeType}', error, stack);
      }
      if (!_closing && !emit.isDone && generation == _trashGeneration) {
        emit(state.copyWith(hiddenLoading: false, hiddenFailed: true));
      }
    }
  }

  bool _canMutate(GalleryMutation action) =>
      !state.busy &&
      !state.needsMutationRefresh &&
      state.section != GallerySection.duplicates &&
      state.capabilities.contains(GalleryCapability.mutations) &&
      (state.isTrash
          ? {GalleryMutation.restore, GalleryMutation.purge}.contains(action) &&
                state.capabilities.contains(GalleryCapability.trash)
          : state.isHidden
          ? {GalleryMutation.unhide, GalleryMutation.trash}.contains(action) &&
                state.capabilities.contains(GalleryCapability.hidden)
          : action == GalleryMutation.trash ||
                action == GalleryMutation.hide && state.capabilities.contains(GalleryCapability.hidden));

  void _requestConfirmation(
    GalleryMutation action,
    Emitter<GalleryManagementState> emit, {
    GalleryMutationScope scope = GalleryMutationScope.selection,
  }) {
    if (!_canMutate(action)) return;
    if (scope == GalleryMutationScope.allTrash && !state.isTrash) return;
    final selected = scope == GalleryMutationScope.allTrash ? state.items : state.selectedItems;
    if (selected.isEmpty) return;
    final confirmation = GalleryMutationConfirmation(
      token: ++_confirmationEpoch,
      action: action,
      items: [
        for (final item in selected)
          GalleryMediaRef(mediaId: item.mediaId, sourceRevision: item.revision, section: item.section),
      ],
      names: [for (final item in selected.take(galleryConfirmationNameLimit)) item.title],
      sizeBytes: action == GalleryMutation.purge
          ? selected.fold<int>(0, (sum, item) => sum + (state.snapshot.entriesById[item.mediaId]?.sizeBytes ?? 0))
          : null,
      scope: scope,
    );
    _log.info('event=confirmationRequested token=${confirmation.token} action=${action.name} items=${selected.length}');
    emit(state.copyWith(confirmation: confirmation));
  }

  bool _confirmationValid(GalleryMutationConfirmation confirmation) {
    if (confirmation.token != _confirmationEpoch || !_canMutate(confirmation.action)) {
      return false;
    }
    if (confirmation.scope == GalleryMutationScope.selection &&
        state.selectedItems.length != confirmation.items.length) {
      return false;
    }
    final snapshot = state.isStored ? state.snapshot : _currentLibrarySnapshot;
    return confirmation.items.every((ref) {
      final item = snapshot.byMediaId[ref.mediaId];
      return item != null &&
          item.revision == ref.sourceRevision &&
          (confirmation.scope == GalleryMutationScope.allTrash || state.selectedIds.contains(item.selectionIdentity));
    });
  }

  Future<void> _mutate(
    GalleryMutation action,
    Emitter<GalleryManagementState> emit, {
    GalleryMutationConfirmation? confirmation,
  }) async {
    if (!_canMutate(action)) return;
    final refs =
        confirmation?.items ??
        [
          for (final item in state.selectedItems)
            GalleryMediaRef(mediaId: item.mediaId, sourceRevision: item.revision, section: item.section),
        ];
    if (refs.isEmpty) return;
    try {
      final canBatch = state.isStored || action == GalleryMutation.hide;
      final batchItems = action == GalleryMutation.restore ? 50 : _mutationBatchItems;
      if (!canBatch && refs.length > _mutationBatchItems) {
        throw const GalleryManagementException(GalleryErrorCode.invalidRequest);
      }
      final requests = <GalleryOperationRequest>[];
      var current = <GalleryMediaRef>[];
      var id = repository.newOperationId();
      int envelopeBytes() => utf8
          .encode(jsonEncode(GalleryOperationRequest(operationId: id, action: action, items: const []).toJson()))
          .length;
      var encodedBytes = envelopeBytes();
      for (final ref in refs) {
        final itemBytes = utf8.encode(jsonEncode(ref.toJson())).length;
        if (current.isNotEmpty &&
            (current.length >= batchItems || encodedBytes + itemBytes + 1 > _mutationBatchBytes)) {
          if (!canBatch) {
            throw const GalleryManagementException(GalleryErrorCode.invalidRequest);
          }
          requests.add(GalleryOperationRequest(operationId: id, action: action, items: current));
          current = [];
          id = repository.newOperationId();
          encodedBytes = envelopeBytes();
        }
        if (encodedBytes + itemBytes > _mutationBatchBytes) {
          throw const GalleryManagementException(GalleryErrorCode.invalidRequest);
        }
        encodedBytes += itemBytes + (current.isEmpty ? 0 : 1);
        current.add(ref);
      }
      if (current.isNotEmpty) {
        requests.add(GalleryOperationRequest(operationId: id, action: action, items: current));
      }
      await _runPlan(
        GalleryManagementOperationPlan(action: action, snapshot: state.snapshot, items: refs, requests: requests),
        emit,
      );
    } catch (error, stack) {
      if (!_closing && !emit.isDone) {
        final code = error is GalleryManagementException ? error.code : GalleryErrorCode.unknown;
        _log.warning(
          'event=mutationRejected action=${action.name} items=${refs.length} '
          'code=${code.name} type=${error.runtimeType}',
          error,
          stack,
        );
        emit(state.copyWith(notice: GalleryManagementNotice.failed, noticeSerial: state.noticeSerial + 1, error: code));
      }
    }
  }

  Future<void> _runPlan(GalleryManagementOperationPlan plan, Emitter<GalleryManagementState> emit) async {
    if (!_canMutate(plan.action)) return;
    var completed = 0;
    final results = <GalleryOperationItemResult>[];
    _log.info(
      'event=mutationStarted action=${plan.action.name} '
      'items=${plan.items.length} batches=${plan.requests.length}',
    );
    emit(
      state.copyWith(
        busy: true,
        operationPlan: plan,
        completedBatches: completed,
        processedItems: results.length,
        succeededItems: results.where((item) => item.state == GalleryItemOperationState.succeeded).length,
        failures: [],
        failureSnapshot: null,
        lastResult: null,
        error: null,
      ),
    );
    try {
      for (; completed < plan.requests.length; completed++) {
        final request = plan.requests[completed];
        emit(state.copyWith(pendingOperation: request));
        final result = await _whileOpen(repository.operate(request, cancel: _cancel.future));
        if (_closing || emit.isDone) return;
        results.addAll(result.items);
        final failures = results.where((item) => item.state == GalleryItemOperationState.failed).toList();
        final succeededIds = result.items
            .where((item) => item.state == GalleryItemOperationState.succeeded)
            .map((item) => item.mediaId)
            .toSet();
        final succeededSelection = {
          for (final id in succeededIds)
            if (plan.snapshot.byMediaId[id] case final GalleryItem item) item.selectionIdentity,
        };
        emit(
          state.copyWith(
            completedBatches: completed + 1,
            processedItems: results.length,
            succeededItems: results.length - failures.length,
            selectedIds: state.selectedIds.difference(succeededSelection),
            pendingOperation: null,
            failures: failures,
            failureSnapshot: failures.isEmpty ? null : plan.snapshot,
            lastResult: GalleryOperationResult(operationId: plan.requests.first.operationId, items: List.of(results)),
          ),
        );
        _log.fine(
          'event=mutationBatchCompleted '
          'action=${plan.action.name} batch=${completed + 1} batches=${plan.requests.length} '
          'processed=${results.length} total=${plan.items.length} failed=${failures.length}',
        );
      }
      final failures = state.failures;
      final failedSelection = {
        for (final failure in failures)
          if (plan.snapshot.byMediaId[failure.mediaId] case final GalleryItem item) item.selectionIdentity,
      };
      final summary =
          'action=${plan.action.name} items=${results.length} '
          'succeeded=${results.length - failures.length} failed=${failures.length}';
      if (failures.isEmpty) {
        _log.info('event=mutationCompleted $summary');
      } else {
        final codes = failures.map((item) => item.error?.name ?? GalleryErrorCode.unknown.name).toSet().join(',');
        _log.warning('event=mutationPartial $summary codes=$codes');
      }
      emit(
        state.copyWith(
          selectedIds: failedSelection,
          operationPlan: null,
          pendingOperation: null,
          error: null,
          notice: plan.action == GalleryMutation.trash && state.succeededItems > 0
              ? GalleryManagementNotice.trashed
              : plan.action == GalleryMutation.hide && state.succeededItems > 0
              ? GalleryManagementNotice.hidden
              : failures.isNotEmpty
              ? GalleryManagementNotice.partialFailure
              : plan.action == GalleryMutation.unhide
              ? GalleryManagementNotice.unhidden
              : plan.action == GalleryMutation.restore
              ? GalleryManagementNotice.restored
              : GalleryManagementNotice.purged,
          noticeSerial: state.noticeSerial + 1,
        ),
      );
      await _refreshAfterMutation(emit);
    } on _ManagementClosed {
      _log.fine('event=mutationCancelled action=${plan.action.name}');
    } catch (error, stack) {
      final code = error is GalleryManagementException ? error.code : GalleryErrorCode.unknown;
      final cancelled = _closing || code == GalleryErrorCode.cancelled;
      final message =
          'event=${cancelled ? 'mutationCancelled' : 'mutationFailed'} '
          'action=${plan.action.name} code=${code.name} '
          'processed=${results.length} total=${plan.items.length} '
          'type=${error.runtimeType}';
      cancelled ? _log.fine(message, error, stack) : _log.warning(message, error, stack);
      if (!_closing && !emit.isDone) {
        emit(state.copyWith(error: code, operationPlan: null, pendingOperation: null));
        // No server receipt is retained. Stop the unsubmitted tail and rebuild
        // the visible truth, including a request that may have completed.
        await _refreshAfterMutation(emit);
        if (!_closing && !emit.isDone) {
          emit(state.copyWith(notice: GalleryManagementNotice.unknownOutcome, noticeSerial: state.noticeSerial + 1));
        }
      }
    } finally {
      if (!_closing && !emit.isDone) emit(state.copyWith(busy: false));
    }
  }

  Future<void> _refreshAfterMutation(Emitter<GalleryManagementState> emit) async {
    try {
      await _whileOpen(catalogBloc.refresh());
      if (!_closing && !emit.isDone && state.isTrash) await _loadTrash(emit);
      if (!_closing &&
          !emit.isDone &&
          (state.isHidden || state.section == GallerySection.duplicates) &&
          state.capabilities.contains(GalleryCapability.hidden)) {
        await _loadHidden(emit);
      }
    } on _ManagementClosed {
      // Screen closure does not change an acknowledged server result.
    } catch (_) {
      // Catalog refresh has its own error state; confirmed mutations succeeded.
    }
  }

  void _completeRefresh(Completer<void> completion) {
    _refreshCompletions.remove(completion);
    if (!completion.isCompleted) completion.complete();
  }

  @override
  Future<void> close() => _closeFuture ??= () async {
    _closing = true;
    _log.fine(
      () =>
          'event=closed section=${state.section.name} selected=${state.selectedIds.length} activeRequests=${_closeWaiters.length}',
    );
    ++_trashGeneration;
    _cancel.complete();
    for (final cancelWait in _closeWaiters.toList()) {
      cancelWait();
    }
    _closeWaiters.clear();
    for (final completion in _refreshCompletions.toList()) {
      _completeRefresh(completion);
    }
    await _catalogSubscription.cancel();
    await _combinedCatalogUpdates.close();
    await super.close();
  }();
}

class _ManagementClosed implements Exception {
  const _ManagementClosed();
}
