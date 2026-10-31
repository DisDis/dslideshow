import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_viewer_bloc.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';
import 'support/gallery_confirmation.dart';

const _capabilities = {
  GalleryCapability.metadata,
  GalleryCapability.rotation,
  GalleryCapability.mutations,
  GalleryCapability.trash,
};

GalleryManagementRepository _repository(http.Client client) {
  final repository = GalleryManagementRepository(
    baseUri: Uri.parse('http://frame.local'),
    code: 'code',
    client: client,
  );
  addTearDown(repository.close);
  return repository;
}

GalleryViewerBloc _viewer(GalleryViewerConfiguration configuration) {
  final bloc = GalleryViewerBloc(configuration: configuration);
  addTearDown(bloc.close);
  return bloc;
}

Future<GalleryViewerState> _event(
  GalleryViewerBloc bloc,
  GalleryViewerEvent event,
  bool Function(GalleryViewerState) predicate,
) {
  final next = bloc.stream.firstWhere(predicate).timeout(const Duration(seconds: 3));
  bloc.add(event);
  return next;
}

Future<GalleryViewerState> _confirmedMutation(
  GalleryViewerBloc bloc,
  GalleryMutation action,
  bool Function(GalleryViewerState) predicate,
) async {
  final next = bloc.stream.firstWhere(predicate).timeout(const Duration(seconds: 3));
  bloc.add(GalleryViewerEvent.mutationRequested(action));
  await confirmViewerMutation(bloc, action);
  return next;
}

void main() {
  test('initial media uses the current snapshot even when its broadcast was missed', () async {
    final original = managedPhoto('a');
    final current = managedPhoto('a', revision: '2');
    final bloc = _viewer(GalleryViewerConfiguration(item: original, currentItem: () => current));
    expect(bloc.state.item.revision, '2');
    expect(bloc.state.missing, false);
    final missing = _viewer(GalleryViewerConfiguration(item: original, currentItem: () => null));
    expect(missing.state.missing, true);
    expect(missing.state.canReadMetadata, false);
  });

  test('reconfiguring the section resets superseded revisions for a matching media ID', () async {
    final first = managedPhoto('same');
    final bloc = _viewer(GalleryViewerConfiguration(item: first));
    final updated = await _event(
      bloc,
      GalleryViewerEvent.configured(GalleryViewerConfiguration(item: first.copyWith(revision: '2'))),
      (state) => state.item.revision == '2',
    );
    expect(updated.supersededRevisions, contains('1'));
    final hidden = await _event(
      bloc,
      GalleryViewerEvent.configured(
        GalleryViewerConfiguration(item: first.copyWith(section: GalleryMediaSection.hidden)),
      ),
      (state) => state.hidden,
    );
    expect(hidden.item.revision, '1');
    expect(hidden.supersededRevisions, isEmpty);
  });

  test('metadata is lazy, hiding cancels it and an explicit retry clears failure', () async {
    final client = ControlledClient();
    final repository = _repository(client);
    final bloc = _viewer(
      GalleryViewerConfiguration(item: managedPhoto('a'), management: repository, capabilities: _capabilities),
    );
    expect(client.requests, isEmpty);
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => s.metadataLoading);
    expect(client.requests, hasLength(1));
    final pending = client.requests.single;
    final aborted = expectLater(pending.headers.future, throwsA(isA<http.RequestAbortedException>()));
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => !s.showInfo);
    await aborted;
    expect(pending.aborted, true);
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => s.metadataLoading);
    final failed = bloc.stream.firstWhere((s) => s.metadataFailed);
    client.requests.last.respond(status: 503);
    client.requests.last.complete(utf8.encode('{"code":"unavailable"}'));
    expect((await failed).metadataError, GalleryErrorCode.unavailable);
    await _event(bloc, const GalleryViewerEvent.metadataRequested(), (s) => s.metadataLoading);
    final ready = bloc.stream.firstWhere((s) => s.metadataStatus == GalleryViewerMetadataStatus.ready);
    client.requests.last.respond();
    client.requests.last.complete(utf8.encode(jsonEncode(photoMetadata('a').toJson())));
    expect((await ready).metadata!.camera, 'Test camera');
    expect(bloc.state.metadataError, isNull);
    expect(client.requests, hasLength(3));
  });

  test('switching media cancels old metadata and its late error cannot fail the new file', () async {
    final updates = StreamController<GalleryItem?>.broadcast(sync: true);
    addTearDown(updates.close);
    final client = ControlledClient();
    final bloc = _viewer(
      GalleryViewerConfiguration(
        item: managedPhoto('a'),
        management: _repository(client),
        capabilities: _capabilities,
        itemUpdates: updates.stream,
      ),
    );
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => s.metadataLoading);
    final old = client.requests.single;
    final aborted = expectLater(old.headers.future, throwsA(isA<http.RequestAbortedException>()));
    final changed = bloc.stream.firstWhere((s) => s.item.mediaId == 'b' && s.metadataLoading);
    updates.add(managedPhoto('b'));
    await changed;
    await aborted;
    expect(old.aborted, true);
    expect(client.requests.last.request.url.pathSegments, contains('b'));
    final ready = bloc.stream.firstWhere((s) => s.metadata?.mediaId == 'b');
    client.requests.last.respond();
    client.requests.last.complete(utf8.encode(jsonEncode(photoMetadata('b').toJson())));
    await ready;
    expect(bloc.state.metadataFailed, false);
    expect(bloc.state.item.mediaId, 'b');
  });

  test('confirmed rotation rejects superseded refreshing and failed catalogue snapshots', () async {
    final updates = StreamController<GalleryItem?>.broadcast(sync: true);
    addTearDown(updates.close);
    final repository = _repository(
      MockClient(
        (_) async => http.Response(
          jsonEncode(photoMetadata('a', revision: '2').copyWith(width: 4000, height: 6000).toJson()),
          200,
        ),
      ),
    );
    final bloc = _viewer(
      GalleryViewerConfiguration(
        item: managedPhoto('a'),
        management: repository,
        capabilities: _capabilities,
        itemUpdates: updates.stream,
      ),
    );
    final rotated = await _event(
      bloc,
      const GalleryViewerEvent.rotationRequested(GalleryRotation.right),
      (s) => s.effect is ViewerRotationApplied,
    );
    expect(rotated.item.revision, '2');
    expect(rotated.item.uri.pathSegments, containsAllInOrder(['published', 'original', 'a', '2']));
    expect(rotated.supersededRevisions, contains('1'));
    expect(rotated.metadata!.height, 6000);
    // GalleryBloc publishes the old item for both refreshing and failed refresh.
    updates.add(managedPhoto('a'));
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => s.showInfo);
    expect(bloc.state.item.revision, '2');
    updates.add(managedPhoto('a'));
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => !s.showInfo);
    expect(bloc.state.metadata!.width, 4000);
    expect(bloc.state.item.revision, '2');
    expect(bloc.state.busy, false);
  });

  test('failed rotation requests a catalog refresh and the next action uses a fresh version and ID', () async {
    final bodies = <Map<String, dynamic>>[];
    final updates = StreamController<GalleryItem?>.broadcast(sync: true);
    addTearDown(updates.close);
    final repository = _repository(
      MockClient((request) async {
        bodies.add(jsonDecode(request.body) as Map<String, dynamic>);
        if (bodies.length == 1) throw http.ClientException('connection lost');
        return http.Response(jsonEncode(photoMetadata('a', revision: '3').toJson()), 200);
      }),
    );
    final bloc = _viewer(
      GalleryViewerConfiguration(
        item: managedPhoto('a'),
        management: repository,
        capabilities: _capabilities,
        itemUpdates: updates.stream,
      ),
    );
    final failed = await _event(
      bloc,
      const GalleryViewerEvent.rotationRequested(GalleryRotation.right),
      (state) => state.effect is ViewerOperationFailed,
    );
    expect((failed.effect as ViewerOperationFailed).refreshCatalog, isTrue);
    expect(bodies.single['sourceRevision'], '1');
    final refreshed = bloc.stream.firstWhere((state) => state.item.revision == '2');
    updates.add(managedPhoto('a', revision: '2'));
    await refreshed;
    final rotated = await _event(
      bloc,
      const GalleryViewerEvent.rotationRequested(GalleryRotation.right),
      (state) => state.effect is ViewerRotationApplied,
    );
    expect(bodies.last['operationId'], isNot(bodies.first['operationId']));
    expect(bodies.last['sourceRevision'], '2');
    expect(rotated.item.revision, '3');
  });

  test('closing aborts the viewer operation without cancelling another repository owner', () async {
    final client = ControlledClient();
    final repository = _repository(client);
    final bloc = _viewer(
      GalleryViewerConfiguration(item: managedPhoto('a'), management: repository, capabilities: _capabilities),
    );
    await _event(bloc, const GalleryViewerEvent.rotationRequested(GalleryRotation.left), (s) => s.busy);
    final rotation = client.requests.single;
    final cancelled = expectLater(rotation.headers.future, throwsA(isA<http.RequestAbortedException>()));
    final otherOwner = repository.catalog(GalleryMediaSection.trash);
    expect(client.requests, hasLength(2));
    await bloc.close();
    await cancelled;
    expect(rotation.aborted, true);
    expect(client.requests.last.aborted, false);
    expect(client.closed, false);
    client.requests.last.respond();
    client.requests.last.complete(utf8.encode("{\"entries\":[],\"section\":\"trash\"}"));
    expect((await otherOwner).entries, isEmpty);
  });

  test('failed mutations request a catalog refresh and a fresh confirmed request', () async {
    final bodies = <Map<String, dynamic>>[];
    final repository = _repository(
      MockClient((request) async {
        final data = jsonDecode(request.body) as Map<String, dynamic>;
        bodies.add(data);
        if (bodies.length == 1) throw http.ClientException('Connection lost');
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: data['operationId'] as String,
              items: [
                GalleryOperationItemResult(
                  section: GalleryMediaSection.published,
                  mediaId: 'a',
                  state: bodies.length == 2 ? GalleryItemOperationState.failed : GalleryItemOperationState.succeeded,
                  error: bodies.length == 2 ? GalleryErrorCode.busy : null,
                  destination: bodies.length == 2
                      ? null
                      : GalleryMediaRef(
                          mediaId: 'trashed-a',
                          sourceRevision: "destination-revision",
                          section: GalleryMediaSection.trash,
                        ),
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
    );
    final bloc = _viewer(
      GalleryViewerConfiguration(item: managedPhoto('a'), management: repository, capabilities: _capabilities),
    );
    final unknown = await _confirmedMutation(bloc, GalleryMutation.trash, (s) => s.effect is ViewerOperationFailed);
    expect(unknown.mutationRequest, isNull);
    expect((unknown.effect as ViewerOperationFailed).refreshCatalog, isTrue);
    final id = unknown.effectId;
    final failed = await _confirmedMutation(
      bloc,
      GalleryMutation.trash,
      (s) => s.effectId > id && s.effect is ViewerOperationFailed,
    );
    expect(bodies[0]['operationId'], isNot(bodies[1]['operationId']));
    expect(failed.mutationRequest, isNull);
    expect(failed.operationError, GalleryErrorCode.busy);
    final succeeded = await _confirmedMutation(bloc, GalleryMutation.trash, (s) => s.effect is ViewerMutationApplied);
    expect(bodies[2]['operationId'], isNot(bodies[1]['operationId']));
    expect((succeeded.effect as ViewerMutationApplied).mediaIds, ['trashed-a']);
    expect(succeeded.missing, true);
    expect(succeeded.busy, false);
  });

  test('capability guards and a tokenized purge confirmation protect file operations', () async {
    final requests = <http.Request>[];
    final repository = _repository(
      MockClient((request) async {
        requests.add(request);
        final data = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: data['operationId'] as String,
              items: const [
                GalleryOperationItemResult(
                  mediaId: 'a',
                  section: GalleryMediaSection.trash,
                  state: GalleryItemOperationState.succeeded,
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
    );
    final legacy = _viewer(GalleryViewerConfiguration(item: managedPhoto('a'), management: repository));
    legacy.add(const GalleryViewerEvent.rotationRequested(GalleryRotation.left));
    legacy.add(const GalleryViewerEvent.mutationRequested(GalleryMutation.trash));
    await _event(legacy, const GalleryViewerEvent.infoToggled(), (s) => !s.showInfo);
    expect(requests, isEmpty);
    final bloc = _viewer(
      GalleryViewerConfiguration(
        item: managedPhoto('a').copyWith(section: GalleryMediaSection.trash),
        management: repository,
        capabilities: const {GalleryCapability.mutations, GalleryCapability.trash},
        entry: GalleryEntry(
          section: GalleryMediaSection.trash,
          mediaId: 'a',
          name: 'a.jpg',
          path: 'a.jpg',
          kind: GalleryEntryKind.image,
          sourceRevision: '1',
          fileChanged: DateTime.utc(2026),
          sizeBytes: 1024,
        ),
      ),
    );
    final prompt = await _event(
      bloc,
      const GalleryViewerEvent.mutationRequested(GalleryMutation.purge),
      (s) => s.effect is ViewerConfirmMutation,
    );
    final firstId = prompt.confirmation!.token;
    expect(requests, isEmpty);
    await _event(
      bloc,
      GalleryViewerEvent.mutationDecision(confirmationId: firstId, confirmed: false),
      (s) => s.confirmation == null,
    );
    final secondPrompt = await _event(
      bloc,
      const GalleryViewerEvent.mutationRequested(GalleryMutation.purge),
      (s) => s.confirmation != null,
    );
    bloc.add(GalleryViewerEvent.mutationDecision(confirmationId: firstId, confirmed: true));
    await _event(bloc, const GalleryViewerEvent.infoToggled(), (s) => !s.showInfo);
    expect(requests, isEmpty);
    final complete = await _event(
      bloc,
      GalleryViewerEvent.mutationDecision(confirmationId: secondPrompt.confirmation!.token, confirmed: true),
      (s) => s.effect is ViewerMutationApplied,
    );
    expect((complete.effect as ViewerMutationApplied).action, GalleryMutation.purge);
    expect(jsonDecode(requests.single.body)['action'], 'purge');
  });

  test('reconfiguration replaces subscriptions and queued work cannot restart after close', () async {
    final first = StreamController<GalleryItem?>.broadcast(sync: true);
    final second = StreamController<GalleryItem?>.broadcast(sync: true);
    addTearDown(first.close);
    addTearDown(second.close);
    final configuration = GalleryViewerConfiguration(item: managedPhoto('a'), itemUpdates: first.stream);
    final bloc = _viewer(configuration);
    expect(first.hasListener, true);
    final changed = bloc.stream.firstWhere((s) => s.item.mediaId == 'b');
    bloc.configure(configuration.copyWith(item: managedPhoto('b'), itemUpdates: second.stream));
    await changed;
    expect(first.hasListener, false);
    expect(second.hasListener, true);
    bloc.configure(configuration);
    await bloc.close();
    expect(first.hasListener, false);
    expect(second.hasListener, false);
  });
}
