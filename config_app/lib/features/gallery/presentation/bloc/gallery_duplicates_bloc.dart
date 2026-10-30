import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../domain/gallery_item.dart';
import '../../../../src/gallery/gallery_management_repository.dart';
import '../../../../src/gallery/gallery_log.dart';

part 'gallery_duplicates_bloc.freezed.dart';

enum GalleryDuplicateDecision { keep, trash }

enum GalleryDuplicatesNotice {
  keepOne,
  stale,
  refreshFailed,
  actionFailed,
  review,
  completed,
}

/// Collection equality belongs to a new catalogue snapshot, never to elapsed
/// clock ticks or decisions. States share this exact immutable value.
@freezed
abstract class GalleryDuplicatesCatalogSnapshot
    with _$GalleryDuplicatesCatalogSnapshot {
  const factory GalleryDuplicatesCatalogSnapshot({
    @Default([]) List<GalleryItem> items,
    @Default({}) Map<String, GalleryItem> byId,
  }) = _GalleryDuplicatesCatalogSnapshot;

  static GalleryDuplicatesCatalogSnapshot index(List<GalleryItem> items) =>
      GalleryDuplicatesCatalogSnapshot(
        items: List.unmodifiable(items),
        byId: {for (final item in items) item.mediaId: item},
      );
}

@freezed
abstract class GalleryDuplicatesEffect with _$GalleryDuplicatesEffect {
  const factory GalleryDuplicatesEffect({
    required int sequence,
    required GalleryDuplicatesNotice notice,
    String? jobId,
    @Default([]) List<GalleryDuplicateMember> members,
    GalleryOperationResult? result,
  }) = _GalleryDuplicatesEffect;
}

@freezed
abstract class GalleryDuplicatesState with _$GalleryDuplicatesState {
  const GalleryDuplicatesState._();
  const factory GalleryDuplicatesState({
    @Default(GalleryDuplicatesCatalogSnapshot())
    GalleryDuplicatesCatalogSnapshot catalogSnapshot,
    @Default({GalleryDuplicateMode.exact, GalleryDuplicateMode.similar})
    Set<GalleryDuplicateMode> modes,
    @Default({}) Map<String, GalleryDuplicateDecision> decisions,
    @Default(0) int selectedCount,
    @Default(0) int selectedBytes,
    @Default({}) Set<GalleryMediaRef> invalidated,
    GalleryDuplicateJob? job,
    GalleryDuplicateStartRequest? pendingStart,
    GalleryDuplicatesEffect? effect,
    @Default(true) bool loading,
    @Default(false) bool busy,
    @Default(false) bool failed,
    GalleryErrorCode? requestError,
    @Default(false) bool polling,
    @Default(0) int elapsedSeconds,
    @Default(0) int groupIndex,
    @Default(0) int memberOffset,
    GalleryDuplicateGroup? visibleGroup,
    @Default(false) bool groupLoading,
  }) = _GalleryDuplicatesState;

  List<GalleryItem> get catalog => catalogSnapshot.items;
  Map<String, GalleryItem> get catalogById => catalogSnapshot.byId;

  bool get running =>
      job?.status == GalleryDuplicateStatus.running ||
      job?.status == GalleryDuplicateStatus.stopping;
  bool current(GalleryDuplicateMember member) =>
      !invalidated.contains(
        GalleryMediaRef(
          mediaId: member.mediaId,
          sourceRevision: member.sourceRevision,
        ),
      ) &&
      catalogById[member.mediaId]?.revision == member.sourceRevision;
  GalleryItem? item(GalleryDuplicateMember member) =>
      current(member) ? catalogById[member.mediaId] : null;
  GalleryDuplicateGroup? get group => visibleGroup;

  List<GalleryDuplicateMember> get visibleMembers {
    final members = group?.items;
    if (members == null || members.isEmpty) return const [];
    final start = memberOffset.clamp(0, members.length - 1);
    return members.sublist(start, (start + 10).clamp(0, members.length));
  }
}

@freezed
sealed class GalleryDuplicatesEvent with _$GalleryDuplicatesEvent {
  const factory GalleryDuplicatesEvent.load() = GalleryDuplicatesLoad;
  const factory GalleryDuplicatesEvent.tick() = GalleryDuplicatesTick;
  const factory GalleryDuplicatesEvent.catalog(List<GalleryItem> items) =
      GalleryDuplicatesCatalog;
  const factory GalleryDuplicatesEvent.start({
    Set<GalleryDuplicateMode>? modes,
  }) = GalleryDuplicatesStart;
  const factory GalleryDuplicatesEvent.stop() = GalleryDuplicatesStop;
  const factory GalleryDuplicatesEvent.decide(
    String groupId,
    String mediaId,
    GalleryDuplicateDecision decision,
  ) = GalleryDuplicatesDecide;
  const factory GalleryDuplicatesEvent.members(int offset) =
      GalleryDuplicatesMembers;
  const factory GalleryDuplicatesEvent.skip() = GalleryDuplicatesSkip;
  const factory GalleryDuplicatesEvent.group(int index) =
      GalleryDuplicatesGroup;
  const factory GalleryDuplicatesEvent.clearSelection() =
      GalleryDuplicatesClearSelection;
  const factory GalleryDuplicatesEvent.invalidate(
    GalleryDuplicateMember member,
  ) = GalleryDuplicatesInvalidate;
  const factory GalleryDuplicatesEvent.review() = GalleryDuplicatesReview;
  const factory GalleryDuplicatesEvent.apply(
    String jobId,
    List<GalleryDuplicateMember> members,
  ) = GalleryDuplicatesApply;
}

/// Owns the duplicate workflow independently from widget rebuilds. The view
/// handles only user-facing effects; subscriptions, retries and identities live
/// here, and every asynchronous reply is guarded by its request generation.
class GalleryDuplicatesBloc
    extends Bloc<GalleryDuplicatesEvent, GalleryDuplicatesState> {
  static final _log = Logger('GalleryDuplicatesBloc');
  final GalleryManagementRepository repository;
  final Future<void> Function() onRefresh;
  final DateTime Function() _now;
  final Completer<void> _cancel = Completer<void>();
  StreamSubscription<List<GalleryItem>>? _catalogSubscription;
  Timer? _timer;
  Future<void>? _revisionRecovery;
  Future<void>? _closingFuture;
  int _generation = 0;
  int _groupGeneration = 0;
  int _ticks = 0;
  final Map<String, GalleryDuplicateMember> _membersById = {};
  GalleryDuplicatesState? _previousResult;
  String? _replacementJobId;
  bool _closing = false;

  GalleryDuplicatesBloc({
    required this.repository,
    required List<GalleryItem> catalog,
    required this.onRefresh,
    Stream<List<GalleryItem>>? catalogUpdates,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now,
       super(
         GalleryDuplicatesState(
           catalogSnapshot: GalleryDuplicatesCatalogSnapshot.index(catalog),
         ),
       ) {
    on<GalleryDuplicatesEvent>(_handle);
    _catalogSubscription = catalogUpdates?.listen((items) {
      if (!_closing) add(GalleryDuplicatesEvent.catalog(items));
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_closing && state.running) add(const GalleryDuplicatesEvent.tick());
    });
    add(const GalleryDuplicatesEvent.load());
  }

  void _notice(
    Emitter<GalleryDuplicatesState> emit,
    GalleryDuplicatesNotice notice, {
    String? jobId,
    List<GalleryDuplicateMember> members = const [],
    GalleryOperationResult? result,
  }) {
    emit(
      state.copyWith(
        effect: GalleryDuplicatesEffect(
          sequence: (state.effect?.sequence ?? 0) + 1,
          notice: notice,
          jobId: jobId,
          members: members,
          result: result,
        ),
      ),
    );
  }

  GalleryDuplicatesState _accepted(GalleryDuplicateJob job) {
    final changed = state.job?.jobId != job.jobId;
    final running =
        job.status == GalleryDuplicateStatus.running ||
        job.status == GalleryDuplicateStatus.stopping;
    final terminal = !running && job.status != GalleryDuplicateStatus.idle;
    if (changed || state.running && terminal) {
      _membersById.clear();
      for (final group in job.groups) {
        for (final member in group.items) {
          _membersById[member.mediaId] = member;
        }
      }
    }
    final previous =
        terminal &&
            job.jobId == _replacementJobId &&
            job.status != GalleryDuplicateStatus.completed
        ? _previousResult
        : null;
    if (changed || state.job?.status != job.status) {
      final message =
          'event=jobStatusChanged jobId=${GalleryLog.id(job.jobId)} status=${job.status.name} modes=${job.modes.map((mode) => mode.name).join(',')} groups=${job.groups.length} skipped=${job.skipped} code=${job.error?.name ?? 'none'} elapsedMs=${job.startedAt == null ? 0 : (job.finishedAt ?? _now()).difference(job.startedAt!).inMilliseconds}';
      job.status == GalleryDuplicateStatus.failed
          ? _log.warning(message)
          : _log.info(message);
    }
    var accepted = state.copyWith(
      job: job,
      loading: false,
      failed: false,
      requestError: null,
      decisions: changed ? {} : state.decisions,
      selectedCount: changed ? 0 : state.selectedCount,
      selectedBytes: changed ? 0 : state.selectedBytes,
      modes: changed && job.modes.isNotEmpty ? job.modes.toSet() : state.modes,
      invalidated: changed ? {} : state.invalidated,
      groupIndex: changed ? 0 : state.groupIndex,
      memberOffset: changed ? 0 : state.memberOffset,
      visibleGroup: changed ? null : state.visibleGroup,
      groupLoading: changed ? false : state.groupLoading,
      elapsedSeconds: job.startedAt == null
          ? 0
          : _now().difference(job.startedAt!).inSeconds.clamp(0, 1 << 30),
    );
    if (previous != null) {
      final decisions = <String, GalleryDuplicateDecision>{};
      for (final entry in previous.decisions.entries) {
        final member = _membersById[entry.key];
        if (member != null &&
            previous.catalogById[entry.key]?.revision ==
                member.sourceRevision &&
            accepted.current(member)) {
          decisions[entry.key] = entry.value;
        }
      }
      accepted = _withDecisions(accepted, decisions).copyWith(
        groupIndex: previous.groupIndex.clamp(0, job.groups.length),
        invalidated: previous.invalidated,
      );
      _log.fine(
        () =>
            'event=previousSelectionRestored jobId=${GalleryLog.id(job.jobId)} selected=${accepted.selectedCount}',
      );
    }
    if (terminal && job.jobId == _replacementJobId) {
      _previousResult = null;
      _replacementJobId = null;
    }
    return accepted;
  }

  bool _live(Emitter<GalleryDuplicatesState> emit, int generation) =>
      !_closing && !emit.isDone && generation == _generation;

  Future<void> _handle(
    GalleryDuplicatesEvent event,
    Emitter<GalleryDuplicatesState> emit,
  ) async {
    if (_closing) return;
    switch (event) {
      case GalleryDuplicatesLoad():
        if (state.polling || state.busy) return;
        final generation = ++_generation;
        final clock = Stopwatch()..start();
        _log.fine(() => 'event=statusLoadStarted generation=$generation');
        emit(state.copyWith(polling: true));
        try {
          final job = await _requestScope(
            repository.duplicates(cancel: _cancel.future),
          );
          if (_live(emit, generation)) {
            emit(_accepted(job));
            if (!state.running && job.groups.isNotEmpty) {
              await _openGroup(emit, state.groupIndex);
            }
          }
          _log.fine(
            () =>
                'event=statusLoadCompleted generation=$generation elapsedMs=${clock.elapsedMilliseconds}',
          );
        } catch (error) {
          _failure('statusLoad', error, clock: clock);
          if (_live(emit, generation)) {
            emit(
              state.copyWith(
                loading: false,
                failed: true,
                requestError: _requestError(error),
              ),
            );
          }
        } finally {
          if (!_closing && !emit.isDone) emit(state.copyWith(polling: false));
        }
      case GalleryDuplicatesTick():
        final started = state.job?.startedAt;
        emit(
          state.copyWith(
            elapsedSeconds: started == null
                ? 0
                : _now().difference(started).inSeconds.clamp(0, 1 << 30),
          ),
        );
        if (++_ticks % 2 == 0 && !state.polling && !state.busy) {
          add(const GalleryDuplicatesEvent.load());
        }
      case GalleryDuplicatesCatalog(:final items):
        final updated = state.copyWith(
          catalogSnapshot: GalleryDuplicatesCatalogSnapshot.index(items),
        );
        final decisions = Map<String, GalleryDuplicateDecision>.of(
          updated.decisions,
        );
        for (final group
            in updated.job?.groups ?? const <GalleryDuplicateGroup>[]) {
          for (final member in group.items) {
            if (!updated.current(member)) decisions.remove(member.mediaId);
          }
        }
        emit(_withDecisions(updated, decisions));
        if (state.group?.items.any((member) => !state.current(member)) ??
            false) {
          await _openGroup(emit, state.groupIndex);
        }
      case GalleryDuplicatesStart(:final modes):
        if (state.busy || state.running || (modes ?? state.modes).isEmpty) {
          return;
        }
        if (modes != null) emit(state.copyWith(modes: modes));
        final generation = ++_generation;
        final old = state.pendingStart;
        final request =
            old != null &&
                old.modes.length == state.modes.length &&
                old.modes.every(state.modes.contains)
            ? old
            : GalleryDuplicateStartRequest(
                operationId: repository.newOperationId(),
                modes: state.modes.toList(),
              );
        if (_replacementJobId != request.operationId) {
          _previousResult = state.job?.groups.isNotEmpty == true ? state : null;
          _replacementJobId = request.operationId;
        }
        final clock = Stopwatch()..start();
        _log.info(
          'event=jobStartRequested operationId=${GalleryLog.id(request.operationId)} modes=${request.modes.map((mode) => mode.name).join(',')} retry=${identical(old, request)}',
        );
        emit(
          state.copyWith(
            busy: true,
            pendingStart: request,
            failed: false,
            requestError: null,
          ),
        );
        try {
          final job = await _requestScope(
            repository.start(request, cancel: _cancel.future),
          );
          if (_live(emit, generation)) {
            emit(_accepted(job).copyWith(pendingStart: null));
            if (!state.running && job.groups.isNotEmpty) {
              await _openGroup(emit, state.groupIndex);
            }
            _log.info(
              'event=jobStartCompleted operationId=${GalleryLog.id(request.operationId)} jobId=${GalleryLog.id(job.jobId)} status=${job.status.name} elapsedMs=${clock.elapsedMilliseconds}',
            );
          }
        } catch (error) {
          _failure(
            'jobStart',
            error,
            operationId: request.operationId,
            clock: clock,
          );
          if (_live(emit, generation)) {
            emit(
              state.copyWith(failed: true, requestError: _requestError(error)),
            );
          }
        } finally {
          if (_live(emit, generation)) emit(state.copyWith(busy: false));
        }
      case GalleryDuplicatesStop():
        if (state.busy || state.job == null) return;
        final generation = ++_generation;
        final jobId = state.job!.jobId;
        final clock = Stopwatch()..start();
        _log.info('event=jobStopRequested jobId=${GalleryLog.id(jobId)}');
        emit(state.copyWith(busy: true, failed: false, requestError: null));
        try {
          final job = await _requestScope(
            repository.stop(jobId, cancel: _cancel.future),
          );
          if (_live(emit, generation)) {
            emit(_accepted(job));
            if (!state.running && job.groups.isNotEmpty) {
              await _openGroup(emit, state.groupIndex);
            }
          }
          _log.info(
            'event=jobStopCompleted jobId=${GalleryLog.id(jobId)} status=${job.status.name} elapsedMs=${clock.elapsedMilliseconds}',
          );
        } catch (error) {
          _failure('jobStop', error, jobId: jobId, clock: clock);
          if (_live(emit, generation)) {
            emit(
              state.copyWith(failed: true, requestError: _requestError(error)),
            );
          }
        } finally {
          if (_live(emit, generation)) emit(state.copyWith(busy: false));
        }
      case GalleryDuplicatesDecide(
        :final groupId,
        :final mediaId,
        :final decision,
      ):
        if (state.busy) return;
        final group = state.job?.groups
            .where((group) => group.groupId == groupId)
            .firstOrNull;
        final member = group?.items
            .where((member) => member.mediaId == mediaId)
            .firstOrNull;
        if (group == null || member == null || !state.current(member)) return;
        if (decision == GalleryDuplicateDecision.trash &&
            !group.items.any(
              (other) =>
                  other.mediaId != mediaId &&
                  state.current(other) &&
                  state.decisions[other.mediaId] !=
                      GalleryDuplicateDecision.trash,
            )) {
          _notice(emit, GalleryDuplicatesNotice.keepOne);
          return;
        }
        final wasSelected =
            state.decisions[mediaId] == GalleryDuplicateDecision.trash;
        final selected = decision == GalleryDuplicateDecision.trash;
        final delta = (selected ? 1 : 0) - (wasSelected ? 1 : 0);
        emit(
          state.copyWith(
            decisions: {...state.decisions, mediaId: decision},
            selectedCount: state.selectedCount + delta,
            selectedBytes: state.selectedBytes + delta * member.sizeBytes,
          ),
        );
      case GalleryDuplicatesClearSelection():
        if (state.busy || state.groupLoading) return;
        _log.fine(
          () =>
              'event=selectionCleared jobId=${GalleryLog.id(state.job?.jobId ?? '')} selected=${state.selectedCount}',
        );
        emit(state.copyWith(decisions: {}, selectedCount: 0, selectedBytes: 0));
      case GalleryDuplicatesGroup(:final index):
        if (!state.busy &&
            !state.groupLoading &&
            index >= 0 &&
            index < (state.job?.groups.length ?? 0)) {
          await _openGroup(emit, index);
        }
      case GalleryDuplicatesMembers(:final offset):
        final count = state.group?.items.length ?? 0;
        if (!state.busy &&
            !state.groupLoading &&
            offset >= 0 &&
            offset < count) {
          emit(state.copyWith(memberOffset: offset));
        }
      case GalleryDuplicatesSkip():
        if (!state.busy && !state.groupLoading && state.job != null) {
          await _openGroup(
            emit,
            state.group == null ? 0 : state.groupIndex + 1,
          );
        }
      case GalleryDuplicatesInvalidate(:final member):
        _log.fine(
          () =>
              'event=revisionInvalidated source=${GalleryLog.source(member.mediaId)} revision=${GalleryLog.source(member.sourceRevision)} recoveryPending=${_revisionRecovery != null}',
        );
        final decisions = Map<String, GalleryDuplicateDecision>.of(
          state.decisions,
        )..remove(member.mediaId);
        emit(
          _withDecisions(state, decisions).copyWith(
            invalidated: {
              ...state.invalidated,
              GalleryMediaRef(
                mediaId: member.mediaId,
                sourceRevision: member.sourceRevision,
              ),
            },
          ),
        );
        if (_revisionRecovery != null) return;
        final recovery = _revisionRecovery = _refreshScope();
        try {
          await recovery;
          if (!_closing && !emit.isDone) {
            await _openGroup(emit, state.groupIndex);
          }
        } catch (_) {
          if (!_closing && !emit.isDone) {
            _notice(emit, GalleryDuplicatesNotice.refreshFailed);
          }
        } finally {
          if (identical(_revisionRecovery, recovery)) _revisionRecovery = null;
        }
      case GalleryDuplicatesReview():
        if (state.busy || state.job == null) return;
        final members = <String, GalleryDuplicateMember>{
          for (final group in state.job!.groups)
            for (final item in group.items)
              if (state.decisions[item.mediaId] ==
                  GalleryDuplicateDecision.trash)
                item.mediaId: item,
        };
        if (!_validSelection(members.values.toList())) {
          _notice(emit, GalleryDuplicatesNotice.keepOne);
        } else {
          _notice(
            emit,
            GalleryDuplicatesNotice.review,
            jobId: state.job!.jobId,
            members: members.values.toList(),
          );
        }
      case GalleryDuplicatesApply(:final jobId, :final members):
        if (state.busy) return;
        if (state.job?.jobId != jobId || !_validSelection(members)) {
          _log.fine(
            () =>
                'event=mutationRejected jobId=${GalleryLog.id(jobId)} code=revisionMismatch items=${members.length}',
          );
          _notice(emit, GalleryDuplicatesNotice.stale);
          return;
        }
        final refs = members
            .map(
              (item) => GalleryMediaRef(
                mediaId: item.mediaId,
                sourceRevision: item.sourceRevision,
              ),
            )
            .toList();
        final request = GalleryOperationRequest(
          operationId: repository.newOperationId(),
          action: GalleryMutation.trash,
          duplicateJobId: jobId,
          items: refs,
        );
        final clock = Stopwatch()..start();
        _log.info(
          'event=mutationStarted operationId=${GalleryLog.id(request.operationId)} jobId=${GalleryLog.id(jobId)} action=trash items=${refs.length}',
        );
        emit(state.copyWith(busy: true));
        try {
          final result = await _requestScope(
            repository.operate(request, cancel: _cancel.future),
          );
          if (_closing || emit.isDone) return;
          final failed = result.items
              .where((item) => item.state == GalleryItemOperationState.failed)
              .length;
          final message =
              'event=${failed == 0 ? 'mutationCompleted' : 'mutationPartial'} operationId=${GalleryLog.id(request.operationId)} jobId=${GalleryLog.id(jobId)} action=trash items=${result.items.length} succeeded=${result.items.length - failed} failed=$failed elapsedMs=${clock.elapsedMilliseconds}';
          failed == 0 ? _log.info(message) : _log.warning(message);
          final decisions = Map<String, GalleryDuplicateDecision>.of(
            state.decisions,
          );
          for (final item in result.items) {
            if (item.state == GalleryItemOperationState.succeeded) {
              decisions.remove(item.mediaId);
            }
          }
          emit(_withDecisions(state, decisions));
          _notice(emit, GalleryDuplicatesNotice.completed, result: result);
          try {
            await _refreshScope();
          } catch (_) {
            if (!_closing && !emit.isDone) {
              _notice(emit, GalleryDuplicatesNotice.refreshFailed);
            }
          }
          if (!_closing && !emit.isDone) {
            await _openGroup(emit, state.groupIndex);
          }
        } catch (error) {
          _failure(
            'mutation',
            error,
            operationId: request.operationId,
            jobId: jobId,
            clock: clock,
          );
          if (!_closing && !emit.isDone) {
            _notice(emit, GalleryDuplicatesNotice.actionFailed);
            try {
              await _refreshScope();
            } catch (_) {
              if (!_closing && !emit.isDone) {
                _notice(emit, GalleryDuplicatesNotice.refreshFailed);
              }
            }
            if (!_closing && !emit.isDone) {
              await _openGroup(emit, state.groupIndex);
            }
          }
        } finally {
          if (!_closing && !emit.isDone) emit(state.copyWith(busy: false));
        }
    }
  }

  Future<void> _openGroup(
    Emitter<GalleryDuplicatesState> emit,
    int index,
  ) async {
    final job = state.job;
    if (job == null || _closing || emit.isDone) return;
    final generation = ++_groupGeneration;
    emit(state.copyWith(groupLoading: true));
    try {
      final page = await _requestScope(
        repository.duplicateGroup(job.jobId, index, cancel: _cancel.future),
      );
      if (_closing ||
          emit.isDone ||
          generation != _groupGeneration ||
          state.job?.jobId != job.jobId) {
        return;
      }
      if (page.jobId != job.jobId ||
          page.index < index ||
          page.index > job.groups.length ||
          (page.group == null
              ? page.index != job.groups.length
              : page.index >= job.groups.length ||
                    page.group!.groupId != job.groups[page.index].groupId ||
                    page.group!.items.length < 2)) {
        throw const FormatException('Invalid duplicate group response');
      }
      _log.fine(
        () =>
            'event=groupOpened index=${page.index} members=${page.group?.items.length ?? 0}',
      );
      final decisions = Map<String, GalleryDuplicateDecision>.of(
        state.decisions,
      );
      for (var skipped = index; skipped < page.index; skipped++) {
        for (final member in job.groups[skipped].items) {
          decisions.remove(member.mediaId);
        }
      }
      final invalidated = Set<GalleryMediaRef>.of(state.invalidated);
      if (page.group != null) {
        final available = page.group!.items
            .map((member) => member.mediaId)
            .toSet();
        for (final member in job.groups[page.index].items) {
          if (!available.contains(member.mediaId)) {
            decisions.remove(member.mediaId);
            invalidated.add(
              GalleryMediaRef(
                mediaId: member.mediaId,
                sourceRevision: member.sourceRevision,
              ),
            );
          }
        }
      }
      emit(
        _withDecisions(state, decisions).copyWith(
          visibleGroup: page.group,
          groupIndex: page.index,
          memberOffset: 0,
          groupLoading: false,
          failed: false,
          requestError: null,
          invalidated: invalidated,
        ),
      );
    } catch (error) {
      if (_closing ||
          emit.isDone ||
          generation != _groupGeneration ||
          state.job?.jobId != job.jobId) {
        return;
      }
      _log.warning(
        'event=groupLoadFailed code=${_requestError(error).name} type=${error.runtimeType}',
      );
      emit(
        state.copyWith(
          groupLoading: false,
          failed: true,
          requestError: _requestError(error),
        ),
      );
    }
  }

  bool _validSelection(List<GalleryDuplicateMember> members) {
    if (members.isEmpty || members.any((member) => !state.current(member))) {
      return false;
    }
    final allowed = {
      for (final group in state.job?.groups ?? const <GalleryDuplicateGroup>[])
        for (final member in group.items)
          GalleryMediaRef(
            mediaId: member.mediaId,
            sourceRevision: member.sourceRevision,
          ),
    };
    if (members.any(
      (member) => !allowed.contains(
        GalleryMediaRef(
          mediaId: member.mediaId,
          sourceRevision: member.sourceRevision,
        ),
      ),
    )) {
      return false;
    }
    final ids = members.map((member) => member.mediaId).toSet();
    for (final group in state.job?.groups ?? const <GalleryDuplicateGroup>[]) {
      if (group.items.any((member) => ids.contains(member.mediaId)) &&
          !group.items.any(
            (member) => !ids.contains(member.mediaId) && state.current(member),
          )) {
        return false;
      }
    }
    return true;
  }

  // Reconcile totals only after bulk changes. Individual checkbox actions above
  // update them by delta, without walking the library or all previous choices.
  GalleryDuplicatesState _withDecisions(
    GalleryDuplicatesState base,
    Map<String, GalleryDuplicateDecision> decisions,
  ) {
    var count = 0, bytes = 0;
    for (final entry in decisions.entries) {
      if (entry.value == GalleryDuplicateDecision.trash) {
        count++;
        bytes += _membersById[entry.key]?.sizeBytes ?? 0;
      }
    }
    return base.copyWith(
      decisions: decisions,
      selectedCount: count,
      selectedBytes: bytes,
    );
  }

  Future<void> _refreshScope() async {
    if (_closing) return;
    await Future.any<void>([Future<void>.sync(onRefresh), _cancel.future]);
  }

  void _failure(
    String event,
    Object error, {
    String operationId = '',
    String jobId = '',
    required Stopwatch clock,
  }) {
    final code = error is GalleryManagementException
        ? error.code
        : GalleryErrorCode.unknown;
    final cancelled = _closing || code == GalleryErrorCode.cancelled;
    final message =
        'event=$event${cancelled ? 'Cancelled' : 'Failed'} operationId=${GalleryLog.id(operationId)} jobId=${GalleryLog.id(jobId)} code=${code.name} type=${error.runtimeType} elapsedMs=${clock.elapsedMilliseconds}';
    cancelled ? _log.fine(message) : _log.warning(message);
  }

  static GalleryErrorCode _requestError(Object error) =>
      error is GalleryManagementException
      ? error.code
      : GalleryErrorCode.unknown;

  Future<T> _requestScope<T>(Future<T> request) => Future.any<T>([
    request,
    _cancel.future.then<T>(
      (_) => throw const GalleryManagementException(GalleryErrorCode.cancelled),
    ),
  ]);

  @override
  Future<void> close() {
    final previous = _closingFuture;
    if (previous != null) return previous;
    _closing = true;
    _log.fine(
      () =>
          'event=closed jobId=${GalleryLog.id(state.job?.jobId ?? '')} running=${state.running} selected=${state.decisions.length}',
    );
    ++_generation;
    _timer?.cancel();
    _cancel.complete();
    final subscription = _catalogSubscription?.cancel();
    final closing = super.close();
    return _closingFuture = Future.wait<void>([?subscription, closing])
        .then<void>((_) {});
  }
}
