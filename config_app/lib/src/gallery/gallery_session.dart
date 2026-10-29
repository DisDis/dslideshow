import 'dart:async';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';

import 'gallery_encoded_cache.dart';
import 'gallery_image_widget.dart';
import 'gallery_repository.dart';
import 'gallery_management_repository.dart';
import 'media_image_loader.dart';

/// One image transport/cache scope is shared by gallery and fullscreen routes.
/// Injected construction is useful to hosts as well as lifecycle tests.
final class GallerySession {
  GallerySession({
    required this.repository,
    required this.loader,
    GalleryDecodePool? decodePool,
    GalleryManagementRepository? management,
  }) : decodePool = decodePool ?? GalleryDecodePool(),
       management =
           management ??
           GalleryManagementRepository(
             baseUri: repository.baseUri,
             code: repository.code,
           );

  static final _sessions = Expando<GallerySession>();

  factory GallerySession.forClient(RealtimeService client) {
    final identity = '${client.connectUri}|${client.authCode}';
    final previous = _sessions[client];
    if (previous != null &&
        previous._identity == identity &&
        !previous._closed) {
      return previous;
    }
    if (previous != null) unawaited(previous.close());
    final uri = client.connectUri;
    final session = GallerySession(
      repository: GalleryRepository(
        baseUri: Uri(
          scheme: uri.scheme == 'wss' || uri.scheme == 'https'
              ? 'https'
              : 'http',
          host: uri.host,
          port: uri.port,
        ),
        code: client.authCode,
      ),
      loader: MediaImageLoader(cache: createGalleryEncodedCache()),
    );
    session._identity = identity;
    session._disconnect = client.onDisconnect.listen((_) {
      if (identical(_sessions[client], session)) _sessions[client] = null;
      unawaited(session.close());
    });
    return _sessions[client] = session;
  }

  String? _identity;
  final GalleryRepository repository;
  final MediaImageLoader loader;
  final GalleryDecodePool decodePool;
  final GalleryManagementRepository management;
  StreamSubscription<dynamic>? _disconnect;
  bool _closed = false;
  Future<void>? _closing;

  Future<void> close() => _closing ??= _close();
  Future<void> _close() async {
    _closed = true;
    repository.close();
    management.close();
    decodePool.close();
    final disconnect = _disconnect;
    if (disconnect != null) await disconnect.cancel();
    await loader.close();
  }
}
