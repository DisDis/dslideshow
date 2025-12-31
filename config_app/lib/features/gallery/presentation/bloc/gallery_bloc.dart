import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/web_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'gallery_bloc.freezed.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  static final Logger _log = Logger('GalleryBloc');
  final RealtimeService _client;
  GalleryBloc(
      {required GalleryState initialState, required RealtimeService client})
      : _client = client,
        super(initialState) {
    on<GalleryLoadEvent>(_onLoad);
  }
  WebClient getWebClient(){
     return WebClient(
        host: _client.connectUri.host,
        port: _client.connectUri.port,
        code: _client.authCode);
  }
  FutureOr<void> _onLoad(GalleryLoadEvent event, emit) async {
    emit(UninitializedGalleryState());
    WebClient webClient = getWebClient();
    final items = await webClient.getMediaItems();
    _log.info("Detect ${items.length}");
    emit(LoadedGalleryState(items: items));
  }
}
