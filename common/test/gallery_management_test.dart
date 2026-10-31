import 'dart:convert';

import 'package:dslideshow_common/gallery.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

Map<String, dynamic> _wire(String text) => jsonDecode(text) as Map<String, dynamic>;

void main() {
  test('media references, operations and duplicate members preserve explicit sections', () {
    for (final section in GalleryMediaSection.values) {
      final ref = GalleryMediaRef(mediaId: 'photo', sourceRevision: 'v1', section: section);
      expect(ref.toJson()['section'], section.name);
      expect(GalleryMediaRef.fromJson(_wire(jsonEncode(ref.toJson()))), ref);
      final request = GalleryOperationRequest(operationId: 'move', action: GalleryMutation.trash, items: [ref]);
      expect(request.toJson().containsKey('section'), isFalse);
      expect(GalleryOperationRequest.fromJson(_wire(jsonEncode(request.toJson()))), request);
      final member = GalleryDuplicateMember(
        mediaId: ref.mediaId,
        sourceRevision: ref.sourceRevision,
        section: section,
        path: 'photo.jpg',
        name: 'photo.jpg',
        sizeBytes: 10,
      );
      expect(member.toJson()['section'], section.name);
      expect(GalleryDuplicateMember.fromJson(_wire(jsonEncode(member.toJson()))), member);
    }
    expect(
      () => GalleryMediaRef.fromJson({'mediaId': 'photo', 'sourceRevision': 'v1'}),
      throwsA(isA<BadKeyException>()),
    );
    expect(
      () => GalleryMediaRef.fromJson({'section': null, 'mediaId': 'photo', 'sourceRevision': 'v1'}),
      throwsA(isA<BadKeyException>()),
    );
    for (final section in ['future', 'library']) {
      expect(
        () => GalleryMediaRef.fromJson({'section': section, 'mediaId': 'photo', 'sourceRevision': 'v1'}),
        throwsArgumentError,
      );
    }
  });

  test('one catalog and entry contract serves all three sections without trash aliases', () {
    for (final section in GalleryMediaSection.values) {
      final entry = GalleryEntry(
        section: section,
        mediaId: 'media',
        sourceRevision: 'revision',
        path: 'album/photo.jpg',
        name: 'photo.jpg',
        kind: GalleryEntryKind.image,
        fileChanged: DateTime.utc(2026, 10, 31),
        sizeBytes: 42,
        thumbnailSupported: true,
      );
      final catalog = GalleryCatalog(section: section, catalogRevision: 'catalog-revision', entries: [entry]);
      final json = _wire(jsonEncode(catalog.toJson()));
      expect(GalleryCatalog.fromJson(json), catalog);
      expect(entry.ref.section, section);
      expect(entry.toJson().keys, containsAll(['section', 'mediaId', 'path', 'fileChanged']));
      expect(entry.toJson().keys, isNot(contains(anyOf('trashId', 'originalPath', 'trashedAt'))));
      expect(() => GalleryCatalog.fromJson({...json, 'section': 'library'}), throwsArgumentError);
      final missing = Map<String, dynamic>.of(json)..remove('section');
      expect(() => GalleryCatalog.fromJson(missing), throwsA(isA<BadKeyException>()));
    }
  });

  test('selected-media command preserves optimistic versions and source sections', () {
    final request = GalleryOperationRequest.fromJson(
      _wire(
        "{\"operationId\":\"move-01\",\"action\":\"trash\",\"items\":[{\"mediaId\":\"photo-a\",\"sourceRevision\":\"revision-a\",\"section\":\"published\"},{\"mediaId\":\"photo-b\",\"sourceRevision\":\"revision-b\",\"section\":\"published\"}]}",
      ),
    );
    expect(request.action, GalleryMutation.trash);
    expect(request.items.map((e) => e.sourceRevision), ['revision-a', 'revision-b']);
    expect(GalleryOperationRequest.fromJson(_wire(jsonEncode(request.toJson()))), request);
    expect(() => request.items.clear(), throwsUnsupportedError);
    final updated = request.copyWith(items: [request.items.first.copyWith(sourceRevision: 'new')]);
    expect(updated.items.single.sourceRevision, 'new');
    expect(request.items.first.sourceRevision, 'revision-a');
    expect(updated, isNot(request));
  });

  test('duplicate page preserves skipped index and end of review', () {
    final page = GalleryDuplicateGroupPage.fromJson(
      _wire('{"jobId":"scan","index":4,"group":{"groupId":"g","mode":"exact","items":[]}}'),
    );
    expect(page.index, 4);
    expect(page.group!.groupId, 'g');
    expect(() => page.group!.items.clear(), throwsUnsupportedError);
    expect(GalleryDuplicateGroupPage.fromJson(_wire(jsonEncode(page.toJson()))), page);
    expect(GalleryDuplicateGroupPage.fromJson(_wire('{"jobId":"scan","index":9}')).group, isNull);
  });

  test('partial mutation results retain per-file success and unknown server error', () {
    final result = GalleryOperationResult.fromJson(
      _wire(
        "{\"operationId\":\"move-01\",\"items\":[{\"mediaId\":\"photo-a\",\"state\":\"succeeded\",\"destination\":{\"mediaId\":\"trash-a\",\"sourceRevision\":\"destination-revision\",\"section\":\"trash\"},\"section\":\"published\"},{\"mediaId\":\"photo-b\",\"state\":\"failed\",\"error\":\"futureStorageError\",\"section\":\"published\"},{\"mediaId\":\"trash-c\",\"state\":\"succeeded\",\"restoredPath\":\"album/c (restored 1).jpg\",\"section\":\"published\"}]}",
      ),
    );
    expect(result.items[0].state, GalleryItemOperationState.succeeded);
    expect(result.items[0].destination?.mediaId, 'trash-a');
    expect(result.items[0].error, isNull);
    expect(result.items[1].state, GalleryItemOperationState.failed);
    expect(result.items[1].error, GalleryErrorCode.unknown);
    expect(result.items[2].restoredPath, 'album/c (restored 1).jpg');
    expect(() => result.items.removeLast(), throwsUnsupportedError);
    expect(GalleryOperationResult.fromJson(_wire(jsonEncode(result.toJson()))), result);
  });

  test('trash wire format preserves source path, UTC deletion time and byte count', () {
    final catalog = GalleryCatalog.fromJson(
      _wire(
        "{\"entries\":[{\"name\":\"фото.jpg\",\"kind\":\"futureMedia\",\"sourceRevision\":\"trash-rev\",\"sizeBytes\":12345678,\"mediaId\":\"entry-1\",\"section\":\"trash\",\"path\":\"Альбом/фото.jpg\",\"fileChanged\":\"2026-10-29T12:34:56.000Z\"}],\"section\":\"trash\"}",
      ),
    );
    final entry = catalog.entries.single;
    expect(entry.path, 'Альбом/фото.jpg');
    expect(entry.fileChanged, DateTime.utc(2026, 10, 29, 12, 34, 56));
    expect(entry.kind, GalleryEntryKind.unknown);
    expect(entry.sizeBytes, 12345678);
    expect(() => catalog.entries.add(entry), throwsUnsupportedError);
    expect(GalleryCatalog.fromJson(_wire(jsonEncode(catalog.toJson()))), catalog);
  });

  test('metadata distinguishes absent EXIF and capture date without a timezone', () {
    final data = GalleryMetadata.fromJson(
      _wire(
        "{\"mediaId\":\"photo\",\"sourceRevision\":\"rev\",\"name\":\"a.png\",\"path\":\"album/a.png\",\"kind\":\"image\",\"sizeBytes\":1024,\"width\":4000,\"height\":3000,\"dateTaken\":\"2026:07:12 10:11:12\",\"fileModified\":\"2026-10-29T12:00:00.000Z\",\"format\":\"PNG\",\"orientation\":6,\"bitDepth\":16,\"hasAlpha\":true,\"section\":\"published\"}",
      ),
    );
    expect(data.dateTaken, '2026:07:12 10:11:12');
    expect(data.fileModified, DateTime.utc(2026, 10, 29, 12));
    expect(data.bitDepth, 16);
    expect(data.hasAlpha, true);
    expect(data.camera, isNull);
    expect(data.latitude, isNull);
    expect(data.durationSeconds, isNull);
    expect(GalleryMetadata.fromJson(_wire(jsonEncode(data.toJson()))), data);
    final futureKind = GalleryMetadata.fromJson({...data.toJson(), 'kind': 'future'});
    expect(futureKind.kind, GalleryEntryKind.unknown);
  });

  test('nested search results are immutable and retain snapshot identities', () {
    final json = _wire(
      "{\"jobId\":\"scan\",\"status\":\"completed\",\"modes\":[\"exact\",\"similar\"],\"startedAt\":\"2026-10-29T10:00:00Z\",\"finishedAt\":\"2026-10-29T10:01:00Z\",\"groups\":[{\"groupId\":\"group-1\",\"mode\":\"exact\",\"items\":[{\"mediaId\":\"a\",\"sourceRevision\":\"a-v1\",\"path\":\"album/a.jpg\",\"name\":\"a.jpg\",\"sizeBytes\":42,\"section\":\"published\"},{\"mediaId\":\"b\",\"sourceRevision\":\"b-v1\",\"path\":\"b.jpg\",\"name\":\"b.jpg\",\"sizeBytes\":42,\"section\":\"published\"}]}],\"skipped\":3}",
    );
    final job = GalleryDuplicateJob.fromJson(json);
    expect(job.status, GalleryDuplicateStatus.completed);
    expect(job.modes, [GalleryDuplicateMode.exact, GalleryDuplicateMode.similar]);
    expect(job.groups.single.items.map((e) => e.sourceRevision), ['a-v1', 'b-v1']);
    expect(job.skipped, 3);
    expect(() => job.modes.clear(), throwsUnsupportedError);
    expect(() => job.groups.clear(), throwsUnsupportedError);
    expect(() => job.groups.single.items.clear(), throwsUnsupportedError);
    // Parsed state must not retain aliases to the caller's mutable JSON lists.
    (json['groups'] as List<dynamic>).clear();
    expect(job.groups.single.items, hasLength(2));
    final restored = GalleryDuplicateJob.fromJson(_wire(jsonEncode(job.toJson())));
    expect(restored, job);
    expect(restored.hashCode, job.hashCode);
    expect(job.copyWith(status: GalleryDuplicateStatus.interrupted).groups, job.groups);
    expect(job.status, GalleryDuplicateStatus.completed);
  });

  test('minimal jobs use explicit idle defaults and unknown error stays unknown', () {
    final idle = GalleryDuplicateJob.fromJson({'jobId': '', 'status': 'idle'});
    expect(idle.modes, isEmpty);
    expect(idle.groups, isEmpty);
    expect(idle.skipped, 0);
    expect(idle.startedAt, isNull);
    expect(idle.error, isNull);
    expect(idle.diagnostics, isNull);
    expect(
      GalleryDuplicateJob.fromJson({'jobId': 'future', 'status': 'failed', 'error': 'futureReason'}).error,
      GalleryErrorCode.unknown,
    );
  });

  test('duplicate diagnostics preserve typed progress and failure evidence', () {
    final job = GalleryDuplicateJob.fromJson(
      _wire('''{
        "jobId":"scan-diagnostics", "status":"failed", "error":"processingFailed",
        "diagnostics":{
          "stage":"validation", "failureReason":"invalidResult",
          "toolVersion":"12.0.1", "exitCode":0, "candidateCount":50002,
          "matchedFileCount":2, "rejectedResultCount":3,
          "snapshotSkippedCount":1, "rootAliased":true, "mode":"exact"
        }
      }'''),
    );
    final diagnostics = job.diagnostics!;
    expect(diagnostics.stage, GalleryDuplicateStage.validation);
    expect(diagnostics.failureReason, GalleryDuplicateFailureReason.invalidResult);
    expect(diagnostics.toolVersion, '12.0.1');
    expect(diagnostics.exitCode, 0);
    expect(diagnostics.candidateCount, 50002);
    expect(diagnostics.matchedFileCount, 2);
    expect(diagnostics.rejectedResultCount, 3);
    expect(diagnostics.snapshotSkippedCount, 1);
    expect(diagnostics.rootAliased, isTrue);
    expect(diagnostics.mode, GalleryDuplicateMode.exact);
    final wire = job.toJson();
    expect(wire['diagnostics'], isA<Map<String, dynamic>>());
    final restored = GalleryDuplicateJob.fromJson(_wire(jsonEncode(wire)));
    expect(restored, job);
    expect(restored.hashCode, job.hashCode);
    final changed = job.copyWith(
      diagnostics: diagnostics.copyWith(
        stage: GalleryDuplicateStage.persistence,
        failureReason: GalleryDuplicateFailureReason.storageUnavailable,
      ),
    );
    expect(changed.diagnostics!.stage, GalleryDuplicateStage.persistence);
    expect(job.diagnostics!.stage, GalleryDuplicateStage.validation);
    expect(changed.groups, job.groups);
    expect(() => changed.groups.clear(), throwsUnsupportedError);
  });

  test('new diagnostic values degrade safely without changing command modes', () {
    final diagnostics = GalleryDuplicateDiagnostics.fromJson(
      _wire('''{
        "stage":"futureStage", "failureReason":"futureFailure",
        "mode":"futureMode"
      }'''),
    );
    expect(diagnostics.stage, GalleryDuplicateStage.unknown);
    expect(diagnostics.failureReason, GalleryDuplicateFailureReason.unknown);
    expect(diagnostics.mode, isNull);
    expect(diagnostics.toolVersion, isNull);
    expect(diagnostics.exitCode, isNull);
    expect(diagnostics.candidateCount, 0);
    expect(diagnostics.matchedFileCount, 0);
    expect(diagnostics.rejectedResultCount, 0);
    expect(diagnostics.snapshotSkippedCount, 0);
    expect(diagnostics.rootAliased, isFalse);
    expect(GalleryDuplicateDiagnostics.fromJson(_wire(jsonEncode(diagnostics.toJson()))), diagnostics);
    expect(GalleryDuplicateDiagnostics.fromJson({'stage': 'snapshot'}).failureReason, isNull);
    expect(
      () => GalleryDuplicateDiagnostics.fromJson({}),
      throwsArgumentError,
      reason: 'A present diagnostics record must identify its stage',
    );
  });

  test('unknown commands or lifecycle states cannot silently become actionable', () {
    expect(
      () => GalleryOperationRequest.fromJson({'operationId': 'op', 'action': 'erase', 'items': []}),
      throwsArgumentError,
    );
    expect(
      () => GalleryRotateRequest.fromJson({
        'section': 'published',
        'operationId': 'op',
        'mediaId': 'id',
        'sourceRevision': 'rev',
        'rotation': 'flip',
      }),
      throwsArgumentError,
    );
    expect(
      () => GalleryDuplicateStartRequest.fromJson({
        'operationId': 'scan',
        'modes': ['futureMode'],
      }),
      throwsArgumentError,
    );
    expect(() => GalleryDuplicateJob.fromJson({'jobId': 'scan', 'status': 'futureStatus'}), throwsArgumentError);
    expect(
      () => GalleryOperationItemResult.fromJson({'section': 'published', 'mediaId': 'id', 'state': 'futureState'}),
      throwsArgumentError,
    );
    expect(() => GalleryMediaRef.fromJson({'section': 'published', 'mediaId': 'id'}), throwsA(isA<TypeError>()));
    expect(() => GalleryDuplicateJob.fromJson({'jobId': 'id'}), throwsArgumentError);
  });
}
