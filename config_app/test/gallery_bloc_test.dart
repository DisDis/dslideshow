import 'dart:async';

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter_test/flutter_test.dart';

class _Client implements RealtimeService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Repository extends GalleryRepository {
  _Repository() : super(baseUri: Uri.parse('http://localhost'), code: 'code');
  final requests = <Completer<GalleryCatalogResult>>[];
  int cancellations = 0;
  @override
  Future<GalleryCatalogResult> load({bool refresh = false}) {
    final request = Completer<GalleryCatalogResult>();
    requests.add(request);
    return request.future;
  }

  @override
  void cancel() {
    cancellations++;
  }
}

GalleryCatalogResult result(String id) => GalleryCatalogResult(
  [
    GalleryItem(
      uri: Uri.parse('http://localhost/$id.jpg'),
      title: id,
      mediaId: id,
    ),
  ],
  GalleryProtocol.versioned,
  id,
);

void main() {
  late _Repository repository;
  late GallerySession session;
  late GalleryBloc bloc;
  setUp(() {
    repository = _Repository();
    session = GallerySession(
      repository: repository,
      loader: MediaImageLoader(),
    );
    bloc = GalleryBloc(
      initialState: LoadedGalleryState(items: result('old').items),
      client: _Client(),
      session: session,
    );
  });
  tearDown(() async {
    await bloc.close();
    await session.close();
  });

  test(
    'failed refresh retains the successful list and completes its indicator',
    () async {
      final refresh = bloc.refresh();
      await Future<void>.delayed(Duration.zero);
      expect((bloc.state as LoadedGalleryState).refreshing, isTrue);
      expect((bloc.state as LoadedGalleryState).items.single.mediaId, 'old');
      repository.requests.single.completeError(StateError('http://secret-url'));
      await refresh;
      expect((bloc.state as LoadedGalleryState).refreshFailed, isTrue);
      expect((bloc.state as LoadedGalleryState).items.single.mediaId, 'old');
    },
  );

  test(
    'newest refresh wins even if the previous transport ignores cancellation',
    () async {
      final first = bloc.refresh();
      await Future<void>.delayed(Duration.zero);
      final second = bloc.refresh();
      await Future<void>.delayed(Duration.zero);
      repository.requests.last.complete(result('new'));
      await second;
      repository.requests.first.complete(result('stale'));
      await first;
      expect((bloc.state as LoadedGalleryState).items.single.mediaId, 'new');
    },
  );

  test(
    'many thumbnail revision errors coalesce into one catalog recovery',
    () async {
      for (var i = 0; i < 20; i++) {
        bloc.resolveRevisionMismatch();
      }
      await Future<void>.delayed(Duration.zero);
      expect(repository.requests, hasLength(1));
      repository.requests.single.complete(result('new'));
      await Future<void>.delayed(Duration.zero);
      expect((bloc.state as LoadedGalleryState).items.single.mediaId, 'new');
    },
  );

  test('dispose before a queued refresh starts does not create network work or strand its indicator', () async {
    final refresh = bloc.refresh();
    await bloc.close();
    await refresh;
    expect(repository.requests, isEmpty);
  });
}
