import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../domain/gallery_item.dart';
import '../../../../src/gallery/gallery_management_repository.dart';
import '../../../../src/gallery/gallery_log.dart';

part 'gallery_comparison_metadata_bloc.freezed.dart';

@freezed
abstract class GalleryComparisonMetadataState with _$GalleryComparisonMetadataState {
  const factory GalleryComparisonMetadataState({
    required GalleryItem? item,
    GalleryMetadata? metadata,
    @Default(false) bool loading,
    @Default(false) bool failed,
    GalleryErrorCode? error,
    @Default(0) int revisionMismatch,
  }) = _GalleryComparisonMetadataState;
}

@freezed
sealed class GalleryComparisonMetadataEvent with _$GalleryComparisonMetadataEvent {
  const factory GalleryComparisonMetadataEvent.load() = GalleryComparisonMetadataLoad;
}

/// One visible comparison card owns one cancellable read. A keyed provider
/// replaces this owner on media, revision or repository changes.
class GalleryComparisonMetadataBloc extends Bloc<GalleryComparisonMetadataEvent, GalleryComparisonMetadataState> {
  static final _log = Logger('GalleryComparisonMetadataBloc');
  final GalleryManagementRepository repository;
  Completer<void>? _cancel;
  int _generation = 0;
  bool _closing = false;
  Future<void>? _closingFuture;

  GalleryComparisonMetadataBloc({required this.repository, required GalleryItem? item})
    : super(GalleryComparisonMetadataState(item: item)) {
    on<GalleryComparisonMetadataLoad>(_load);
    add(const GalleryComparisonMetadataEvent.load());
  }

  Future<void> _load(GalleryComparisonMetadataLoad event, Emitter<GalleryComparisonMetadataState> emit) async {
    final generation = ++_generation;
    _cancelRead();
    final item = state.item;
    if (item == null || _closing) return;
    final cancel = _cancel = Completer<void>();
    _log.fine(
      () =>
          'event=metadataStarted generation=$generation source=${GalleryLog.source(item.mediaId)} revision=${GalleryLog.source(item.revision)}',
    );
    emit(state.copyWith(loading: true, failed: false, error: null));
    try {
      final data = await Future.any<GalleryMetadata>([
        repository.metadata(item, cancel: cancel.future),
        cancel.future.then<GalleryMetadata>((_) => throw const GalleryManagementException(GalleryErrorCode.cancelled)),
      ]);
      if (!_closing && !emit.isDone && generation == _generation) {
        _log.fine(() => 'event=metadataCompleted generation=$generation');
        emit(state.copyWith(metadata: data, loading: false, failed: false, error: null));
      }
    } catch (error) {
      if (_closing || emit.isDone || generation != _generation) {
        _log.fine(() => 'event=metadataCancelled generation=$generation');
        return;
      }
      final code = error is GalleryManagementException
          ? error.code
          : error is FormatException || error is TypeError
          ? GalleryErrorCode.processingFailed
          : GalleryErrorCode.unknown;
      _log.warning('event=metadataFailed generation=$generation code=${code.name} type=${error.runtimeType}');
      emit(
        state.copyWith(
          loading: false,
          failed: true,
          error: code,
          revisionMismatch:
              state.revisionMismatch +
              (error is GalleryManagementException && error.code == GalleryErrorCode.revisionMismatch ? 1 : 0),
        ),
      );
    }
  }

  void _cancelRead() {
    final cancel = _cancel;
    if (cancel != null && !cancel.isCompleted) cancel.complete();
    _cancel = null;
  }

  @override
  Future<void> close() {
    final previous = _closingFuture;
    if (previous != null) return previous;
    _closing = true;
    _log.fine(() => 'event=closed loading=${state.loading}');
    ++_generation;
    _cancelRead();
    return _closingFuture = super.close();
  }
}
