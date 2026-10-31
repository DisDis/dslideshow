import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'gallery_bloc.freezed.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  static final Logger _log = Logger('GalleryBloc');
  final RealtimeService _client;
  final GalleryRepository repository;
  final GallerySession session;
  int _generation = 0;
  Future<void>? _revisionRecovery;
  bool _closing = false;
  Future<void>? _closeFuture;
  final _refreshCompletions = <Completer<void>>{};
  GalleryBloc({
    required GalleryState initialState,
    required RealtimeService client,
    GalleryRepository? repository,
    GallerySession? session,
  }) : _client = client,
       session = session ?? GallerySession.forClient(client),
       repository = repository ?? session?.repository ?? GallerySession.forClient(client).repository,
       super(initialState) {
    on<GalleryLoadEvent>(_onLoad);
  }
  WebClient getWebClient() {
    return WebClient(host: _client.connectUri.host, port: _client.connectUri.port, code: _client.authCode);
  }

  FutureOr<void> _onLoad(GalleryLoadEvent event, emit) async {
    if (_closing) {
      _finishRefresh(event.completion);
      return;
    }
    final generation = ++_generation;
    final previous = state is LoadedGalleryState ? state as LoadedGalleryState : null;
    _log.info(
      'event=catalogLoadStarted generation=$generation scan=${event.scan} previousItems=${previous?.items.length ?? 0}',
    );
    if (previous != null) {
      emit(LoadedGalleryState(items: previous.items, refreshing: true));
    } else {
      emit(const UninitializedGalleryState());
    }
    try {
      final result = await repository.load(refresh: event.scan);
      if (_closing || emit.isDone || generation != _generation) {
        _log.fine(() => 'event=catalogLoadDiscarded generation=$generation closing=$_closing');
        return;
      }
      _log.info('event=catalogLoadCompleted generation=$generation items=${result.items.length}');
      emit(LoadedGalleryState(items: result.items));
    } catch (error, stack) {
      if (_closing || emit.isDone || generation != _generation) {
        _log.fine(() => 'event=catalogLoadCancelled generation=$generation closing=$_closing', error, stack);
        return;
      }
      _log.warning(
        'event=catalogLoadFailed generation=$generation status=${error is GalleryImageHttpException ? error.statusCode : 'none'} type=${error.runtimeType} retainedItems=${previous?.items.length ?? 0}',
        error,
        stack,
      );
      if (previous != null) {
        emit(LoadedGalleryState(items: previous.items, refreshFailed: true));
      } else {
        // Technical exceptions may contain an authenticated URL. The UI uses a
        // localized message rather than displaying transport exception text.
        emit(const ErrorGalleryState(''));
      }
    } finally {
      _finishRefresh(event.completion);
    }
  }

  Future<void> refresh({bool scan = true}) {
    if (_closing) return Future<void>.value();
    final completion = Completer<void>();
    _refreshCompletions.add(completion);
    add(GalleryLoadEvent(scan: scan, completion: completion));
    return completion.future;
  }

  void resolveRevisionMismatch() {
    if (_revisionRecovery != null || _closing) return;
    _log.fine(() => 'event=catalogRevisionRecoveryStarted');
    _revisionRecovery = refresh(scan: false).whenComplete(() => _revisionRecovery = null);
  }

  @override
  Future<void> close() {
    final previous = _closeFuture;
    if (previous != null) return previous;
    _closing = true;
    _log.fine(() => 'event=closed pendingRefreshes=${_refreshCompletions.length}');
    ++_generation;
    repository.cancel();
    for (final completion in _refreshCompletions.toList()) {
      _finishRefresh(completion);
    }
    return _closeFuture = super.close();
  }

  void _finishRefresh(Completer<void>? completion) {
    if (completion == null) return;
    _refreshCompletions.remove(completion);
    if (!completion.isCompleted) completion.complete();
  }
}
