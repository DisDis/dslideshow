import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_duplicate_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_file_operations.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'support/gallery_tool_stub.dart';
import 'support/gallery_tool_runner.dart' show CallbackGalleryToolRunner;
import 'helpers/capture_logs.dart';

Future<GalleryDuplicateJob> _finished(GalleryDuplicateService service) async {
  final clock = Stopwatch()..start();
  while (clock.elapsed < const Duration(seconds: 15)) {
    final state = await service.status();
    if (state.status != GalleryDuplicateStatus.running && state.status != GalleryDuplicateStatus.stopping) return state;
    await Future<void>(() {});
  }
  fail('Search failed to finish: ${(await service.status()).toJson()}');
}

void main() {
  late Directory root;
  late Directory originals;
  late GalleryCatalogService catalog;
  late GalleryDuplicateService service;
  late GalleryToolStub runner;
  late File first;
  late File second;
  const ok = GalleryToolResult(exitCode: 0, stdout: '', stderr: '');

  Map<String, dynamic> entry(File file) => {
    'path': file.absolute.path,
    'size': 4,
    'hash': 'independent-hash',
    'modified_date': 0,
  };
  File output(List<String> args) => File(args[args.indexOf('--compact-file-to-save') + 1]);
  Future<void> normalJson(List<String> args) async {
    final group = [entry(first), entry(second)];
    await output(args).writeAsString(
      jsonEncode(
        args.first == 'dup'
            ? {
                '4': [group],
              }
            : [group],
      ),
    );
  }

  GalleryDuplicateStartRequest start(
    String id, {
    List<GalleryDuplicateMode> modes = const [GalleryDuplicateMode.exact],
  }) => GalleryDuplicateStartRequest(operationId: id, modes: modes);

  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-duplicates-');
    originals = await Directory('${root.path}/images').create();
    first = await File('${originals.path}/a space.jpg').writeAsBytes([1, 2, 3, 4]);
    second = await File('${originals.path}/б.jpg').writeAsBytes([1, 2, 3, 4]);
    catalog = GalleryCatalogService(originals: originals, stateDirectory: Directory('${root.path}/images.gallery'));
    runner = GalleryToolStub((executable, args, cancel, env) async {
      await normalJson(args);
      return ok;
    });
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
  });
  tearDown(() async {
    await service.close();
    await catalog.close();
    await root.delete(recursive: true);
  });

  test('review filters missing or changed members, skips singletons, and does not persist decisions', () async {
    await File('${originals.path}/c.jpg').writeAsBytes([1, 2, 3, 4]);
    final snapshot = await catalog.catalog();
    final members = [
      for (final item in snapshot.entries)
        GalleryDuplicateMember(
          section: item.section,
          mediaId: item.mediaId,
          sourceRevision: item.sourceRevision,
          path: item.path,
          name: item.name,
          sizeBytes: 4,
        ),
    ];
    final job = GalleryDuplicateJob(
      jobId: 'review',
      status: GalleryDuplicateStatus.completed,
      groups: [
        GalleryDuplicateGroup(groupId: 'pair', mode: GalleryDuplicateMode.exact, items: members.take(2).toList()),
        GalleryDuplicateGroup(groupId: 'triple', mode: GalleryDuplicateMode.similar, items: members),
      ],
    );
    await service.directory.create(recursive: true);
    final state = File('${service.directory.path}/job.json');
    final encoded = jsonEncode(job.toJson());
    await state.writeAsString(encoded);
    final removed = members[1];
    await File('${originals.path}/${removed.path}').delete();
    final page = await service.group('review', 0);
    expect(page.index, 1);
    expect(page.group!.groupId, 'triple');
    expect(
      page.group!.items.map((item) => item.mediaId).toSet(),
      members.where((item) => item != removed).map((item) => item.mediaId).toSet(),
    );
    await File('${originals.path}/${page.group!.items.last.path}').writeAsBytes([9, 8, 7, 6, 5]);
    final done = await service.group('review', 0);
    expect(done.index, 2);
    expect(done.group, isNull);
    expect(await state.readAsString(), encoded);
    expect((await service.status()).groups, job.groups);
    await expectLater(
      service.group('another', 0),
      throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', GalleryErrorCode.revisionMismatch)),
    );
    await expectLater(
      service.group('review', -1),
      throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', GalleryErrorCode.invalidRequest)),
    );
  });

  test(
    'loaded results collapse equal member sets regardless of order/mode, preferring exact and retaining broader groups',
    () async {
      final member = GalleryDuplicateMember(
        section: GalleryMediaSection.published,
        mediaId: 'a',
        sourceRevision: '1',
        path: 'a.jpg',
        name: 'a.jpg',
        sizeBytes: 4,
      );
      final pair = [member, member.copyWith(mediaId: 'b', path: 'b.jpg', name: 'b.jpg')];
      final job = GalleryDuplicateJob(
        jobId: 'overlap',
        status: GalleryDuplicateStatus.completed,
        groups: [
          GalleryDuplicateGroup(
            groupId: 'similar-pair',
            mode: GalleryDuplicateMode.similar,
            items: pair.reversed.toList(),
          ),
          GalleryDuplicateGroup(groupId: 'exact-pair', mode: GalleryDuplicateMode.exact, items: pair),
          GalleryDuplicateGroup(
            groupId: 'repeated-exact',
            mode: GalleryDuplicateMode.exact,
            items: pair.reversed.toList(),
          ),
          GalleryDuplicateGroup(
            groupId: 'broader',
            mode: GalleryDuplicateMode.similar,
            items: [
              ...pair,
              member.copyWith(mediaId: 'c', path: 'c.jpg', name: 'c.jpg'),
            ],
          ),
        ],
      );
      await service.directory.create(recursive: true);
      final state = File('${service.directory.path}/job.json');
      final encoded = jsonEncode(job.toJson());
      await state.writeAsString(encoded);
      final restored = await service.status();
      expect(restored.groups.map((group) => group.groupId), ['exact-pair', 'broader']);
      expect(restored.groups.first.mode, GalleryDuplicateMode.exact);
      expect(restored.groups.last.items, hasLength(3));
      expect(await state.readAsString(), encoded);
    },
  );

  test('stored 50001-candidate results in both modes are restored in full', () async {
    final members = List.generate(
      50001,
      (index) => GalleryDuplicateMember(
        section: GalleryMediaSection.published,
        mediaId: 'media-$index',
        sourceRevision: 'revision-$index',
        path: '2026/10/family-albums/photo-$index.jpg',
        name: 'photo-$index.jpg',
        sizeBytes: 1024,
      ),
    );
    final completed = GalleryDuplicateJob(
      jobId: 'large-completed-job',
      status: GalleryDuplicateStatus.completed,
      modes: GalleryDuplicateMode.values,
      groups: [
        for (final mode in GalleryDuplicateMode.values)
          GalleryDuplicateGroup(
            groupId: mode.name,
            mode: mode,
            items: mode == GalleryDuplicateMode.exact
                ? members
                : [
                    ...members,
                    members.last.copyWith(mediaId: 'another-similar-file', path: 'another.jpg', name: 'another.jpg'),
                  ],
          ),
      ],
    );
    await service.directory.create(recursive: true);
    final state = File('${service.directory.path}/job.json');
    await state.writeAsString(jsonEncode(completed.toJson()));
    expect(await state.length(), greaterThan(16 << 20));
    final restored = await service.status();
    expect(restored.status, GalleryDuplicateStatus.completed);
    expect(restored.groups, hasLength(2));
    expect(restored.groups.first.items, hasLength(50001));
    expect(restored.groups.last.items, hasLength(50002));
    expect(restored.groups.last.items[50000].mediaId, 'media-50000');
  });

  test('pinned exact and similar JSON map to snapshot identities and never request deletion', () async {
    await captureLogs((records) async {
      final before = await catalog.catalog();
      expect((await service.status()).status, GalleryDuplicateStatus.idle);
      await service.start(start('both', modes: GalleryDuplicateMode.values));
      final done = await _finished(service);
      expect(done.status, GalleryDuplicateStatus.completed);
      expect(done.diagnostics!.candidateCount, 2);
      expect(done.diagnostics!.matchedFileCount, 2);
      expect(done.diagnostics!.rejectedResultCount, 0);
      expect(done.diagnostics!.toolVersion, '12.0.2');
      expect(done.groups, hasLength(1));
      expect(done.groups.single.mode, GalleryDuplicateMode.exact);
      expect(
        records.singleWhere((record) => record.message.startsWith('Search groups normalized')).message,
        contains('reportedGroups=2 groups=1'),
      );
      expect(done.groups.first.items.map((m) => m.mediaId).toSet(), before.entries.map((e) => e.mediaId).toSet());
      expect(
        done.groups.first.items.map((m) => m.sourceRevision).toSet(),
        before.entries.map((e) => e.sourceRevision).toSet(),
      );
      expect(runner.calls.map((args) => args.first), ['dup', 'image']);
      expect(runner.calls.first, isNot(contains('--image-filter')));
      final similarArgs = runner.calls.last;
      expect(similarArgs[similarArgs.indexOf('--image-filter') + 1], 'Lanczos3');
      expect(
        runner.calls.every((args) => !args.contains('--delete-method') && !args.contains('--move-to-trash')),
        isTrue,
      );
      expect(await first.readAsBytes(), [1, 2, 3, 4]);
      expect(second.existsSync(), isTrue);
      expect(await Directory('${catalog.stateDirectory.path}/duplicates').list().any((e) => e is Directory), isFalse);
      final diagnostics = records.where((record) => record.loggerName == 'GalleryDuplicateService').toList();
      final messages = diagnostics.map((record) => record.message).join('\n');
      expect(messages, contains('Search started'));
      expect(messages, isNot(contains('operation=')));
      expect(messages, contains('Search probe completed'));
      expect(messages, contains('mode=exact'));
      expect(messages, contains('mode=similar'));
      expect(messages, contains('imageFilter=Lanczos3'));
      expect(messages, contains('Search mode completed'));
      expect(messages, contains('status=completed'));
      expect(messages, contains('candidates=2 matchedFiles=2'));
      expect(messages, contains('rejectedResults=0'));
      expect(messages, contains('snapshotSkipped=0 rootAliased=false'));
      expect(diagnostics.any((record) => record.level == Level.INFO), isTrue);
      for (final sensitive in [root.path, first.path, second.path, 'a space.jpg', 'б.jpg', 'independent-hash']) {
        expect(messages, isNot(contains(sensitive)));
      }
      expect(diagnostics.every((record) => record.error == null && record.stackTrace == null), isTrue);
    });
  });

  test('exit 11 with valid JSON is a successful finding; repeated operation is idempotent', () async {
    runner = GalleryToolStub((e, args, c, env) async {
      await normalJson(args);
      return ok.copyWith(exitCode: 11);
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('findings'));
    final done = await _finished(service);
    expect(done.groups, hasLength(1));
    expect(await service.start(start('findings')), done);
    expect(runner.calls, hasLength(1));
    await expectLater(
      service.start(start('findings', modes: const [GalleryDuplicateMode.similar])),
      throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', GalleryErrorCode.invalidRequest)),
    );
  });

  test('nonzero CLI exit publishes and persists a safe failure diagnostic', () async {
    const privateOutput = 'private/photo.jpg https://frame/cache/access-secret/';
    runner = GalleryToolStub(
      (e, args, c, env) async => ok.copyWith(exitCode: 101, stdout: privateOutput, stderr: privateOutput),
    );
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await captureLogs((records) async {
      await service.start(start('failed-process'));
      final done = await _finished(service);
      expect(done.status, GalleryDuplicateStatus.failed);
      expect(done.error, GalleryErrorCode.processingFailed);
      final diagnostics = done.diagnostics!;
      expect(diagnostics.stage, GalleryDuplicateStage.scanning);
      expect(diagnostics.failureReason, GalleryDuplicateFailureReason.processFailed);
      expect(diagnostics.mode, GalleryDuplicateMode.exact);
      expect(diagnostics.exitCode, 101);
      expect(diagnostics.toolVersion, '12.0.2');
      expect(diagnostics.candidateCount, 2);
      final messages = records
          .where((record) => record.loggerName == 'GalleryDuplicateService')
          .map((record) => record.message)
          .join('\n');
      expect(messages, contains('reason=processFailed exit=101 exitClass=error'));
      expect(messages, contains('version=12.0.2 stage=scanning mode=exact'));
      expect(messages, isNot(contains(privateOutput)));
      expect(messages, isNot(contains(root.path)));
      await service.close();
      service = GalleryDuplicateService(catalog: catalog, runner: runner);
      expect((await service.status()).diagnostics, diagnostics);
    });
  });

  test('probe distinguishes unavailable, unsupported and nonzero version outcomes', () async {
    var variant = 0;
    final probe = CallbackGalleryToolRunner((
      executable,
      args, {
      timeout,
      cancellation,
      environment,
      discardStdout = false,
      maxOutputBytes = 4096,
    }) async {
      expect(args, ['--version']);
      if (variant == 0) {
        throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
      }
      if (variant == 1) return ok.copyWith(stdout: 'czkawka 99.1.2');
      return ok.copyWith(exitCode: 126, stderr: 'private path must stay private');
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: probe);
    final reasons = [
      GalleryDuplicateFailureReason.toolUnavailable,
      GalleryDuplicateFailureReason.unsupportedVersion,
      GalleryDuplicateFailureReason.versionProbeFailed,
    ];
    for (variant = 0; variant < reasons.length; variant++) {
      await service.start(start('probe-$variant'));
      final done = await _finished(service);
      expect(done.status, GalleryDuplicateStatus.failed);
      expect(done.diagnostics!.stage, GalleryDuplicateStage.versionProbe);
      expect(done.diagnostics!.failureReason, reasons[variant]);
      expect(done.diagnostics!.toolVersion, variant == 1 ? '99.1.2' : null);
      expect(
        done.diagnostics!.exitCode,
        variant == 0
            ? null
            : variant == 1
            ? 0
            : 126,
      );
    }
  });

  test('a root removed during a zero-exit empty scan is a storage failure', () async {
    runner = GalleryToolStub((e, args, c, env) async {
      await output(args).writeAsString('{}');
      await originals.rename('${root.path}/moved-images');
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('removed-root'));
    final done = await _finished(service);
    expect(done.status, GalleryDuplicateStatus.failed);
    expect(done.error, GalleryErrorCode.unavailable);
    expect(done.diagnostics!.failureReason, GalleryDuplicateFailureReason.storageUnavailable);
    expect(done.diagnostics!.candidateCount, 2);
    expect(done.diagnostics!.exitCode, 0);
    expect(done.groups, isEmpty);
  });

  test('stat-readable but access-denied photos cannot become a successful empty scan', () async {
    final permissions = await Process.run('chmod', ['000', first.path, second.path]);
    expect(permissions.exitCode, 0);
    addTearDown(() async {
      await Process.run('chmod', ['600', first.path, second.path]);
    });
    expect(await first.length(), 4);
    var accessDenied = false;
    try {
      final handle = await first.open(mode: FileMode.read);
      await handle.close();
    } on FileSystemException {
      accessDenied = true;
    }
    await captureLogs((records) async {
      await service.start(start('unreadable-files'));
      final done = await _finished(service);
      if (accessDenied) {
        expect(done.status, GalleryDuplicateStatus.failed);
        expect(done.error, GalleryErrorCode.unavailable);
        expect(done.diagnostics!.stage, GalleryDuplicateStage.snapshot);
        expect(done.diagnostics!.failureReason, GalleryDuplicateFailureReason.storageUnavailable);
        expect(done.diagnostics!.candidateCount, 0);
        expect(done.diagnostics!.snapshotSkippedCount, 2);
        expect(done.groups, isEmpty);
        expect(runner.calls, isEmpty);
        final summary = records.singleWhere(
          (record) => record.loggerName == 'GalleryDuplicateService' && record.message.startsWith('Search snapshot'),
        );
        expect(summary.level, Level.WARNING);
        expect(summary.message, contains('unreadable=2'));
        expect(summary.message, isNot(contains(first.path)));
      } else {
        // Privileged processes may read chmod000 files; they remain eligible.
        expect(done.status, GalleryDuplicateStatus.completed);
        expect(done.diagnostics!.candidateCount, 2);
        expect(done.groups, hasLength(1));
      }
    });

    final readable = await File('${originals.path}/readable-copy.jpg').writeAsBytes([1, 2, 3, 4]);
    expect((await Process.run('chmod', ['600', first.path])).exitCode, 0);
    await catalog.refresh(
      const GalleryRefreshRequest(operationId: 'read-access-refresh', mode: GalleryRefreshMode.scan),
    );
    await service.close();
    runner = GalleryToolStub((e, args, c, env) async {
      await output(args).writeAsString(
        jsonEncode({
          '4': [
            [entry(first), entry(readable)],
          ],
        }),
      );
      return ok;
    });
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('partly-readable'));
    final partial = await _finished(service);
    expect(partial.status, GalleryDuplicateStatus.completed);
    expect(partial.diagnostics!.candidateCount, accessDenied ? 2 : 3);
    expect(partial.diagnostics!.snapshotSkippedCount, accessDenied ? 1 : 0);
    expect(partial.diagnostics!.matchedFileCount, 2);
    expect(partial.groups.single.items.map((item) => item.name), isNot(contains(second.uri.pathSegments.last)));
  });

  test('zero eligible candidates has a bounded warning and explicit counts', () async {
    await first.delete();
    await second.delete();
    runner = GalleryToolStub((e, args, c, env) async {
      await output(args).writeAsString('{}');
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await captureLogs((records) async {
      await service.start(start('empty-library'));
      final done = await _finished(service);
      expect(done.status, GalleryDuplicateStatus.completed);
      expect(done.diagnostics!.candidateCount, 0);
      expect(done.diagnostics!.matchedFileCount, 0);
      final snapshot = records.singleWhere(
        (record) => record.loggerName == 'GalleryDuplicateService' && record.message.startsWith('Search snapshot'),
      );
      expect(snapshot.level, Level.WARNING);
      expect(snapshot.message, contains('candidates=0'));
      expect(snapshot.message, isNot(contains(root.path)));
    });
  });

  test('files replaced or created during CLI are excluded instead of acquiring fresh revisions', () async {
    runner = GalleryToolStub((e, args, c, env) async {
      await first.writeAsBytes([5, 6, 7, 8, 9]);
      catalog.markDirty();
      final fresh = await File('${originals.path}/new.jpg').writeAsBytes([1, 2, 3, 4]);
      await output(args).writeAsString(
        jsonEncode({
          '4': [
            [entry(first), entry(second), entry(fresh)],
          ],
        }),
      );
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('replaced'));
    final done = await _finished(service);
    expect(done.status, GalleryDuplicateStatus.completed);
    expect(done.groups, isEmpty);
    expect(done.skipped, 2);
  });

  test('foreign paths and symlink aliases never become actionable members', () async {
    final outside = await File('${root.path}/outside.jpg').writeAsBytes([1, 2, 3, 4]);
    final linked = Link('${originals.path}/linked.jpg');
    await linked.create(outside.path);
    runner = GalleryToolStub((e, args, c, env) async {
      await output(args).writeAsString(
        jsonEncode({
          '4': [
            [entry(first), entry(outside), entry(File(linked.path))],
          ],
        }),
      );
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('foreign'));
    final done = await _finished(service);
    expect(done.groups, isEmpty);
    expect(done.skipped, 2);
    expect(done.diagnostics!.snapshotSkippedCount, 1);
    expect(done.diagnostics!.rejectedResultCount, 2);
    expect(await outside.readAsBytes(), [1, 2, 3, 4]);
  });

  test('empty valid results differ from missing or malformed JSON', () async {
    String? contents = '{}';
    runner = GalleryToolStub((e, args, c, env) async {
      if (contents != null) await output(args).writeAsString(contents);
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('empty'));
    expect((await _finished(service)).status, GalleryDuplicateStatus.completed);
    var index = 0;
    for (final malformed in <String?>[null, '{bad', ' ' * 2048]) {
      contents = malformed;
      await service.start(start('bad-${index++}'));
      final done = await _finished(service);
      expect(done.status, GalleryDuplicateStatus.failed);
      expect(done.error, GalleryErrorCode.processingFailed);
      expect(done.diagnostics!.failureReason, GalleryDuplicateFailureReason.invalidResult);
    }
  });

  test('stop waits for command cleanup, prevents overlap, and releases slot', () async {
    final entered = Completer<void>(), cleaning = Completer<void>(), cleanup = Completer<void>();
    var blocked = true;
    runner = GalleryToolStub((e, args, cancel, env) async {
      if (!blocked) {
        await normalJson(args);
        return ok;
      }
      entered.complete();
      await cancel;
      cleaning.complete();
      await cleanup.future;
      throw const GalleryCatalogFailure(GalleryErrorCode.cancelled);
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('cancel'));
    await entered.future;
    await expectLater(
      service.start(start('overlap')),
      throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', GalleryErrorCode.busy)),
    );
    final stop = service.stop('cancel');
    await cleaning.future;
    expect((await service.status()).status, GalleryDuplicateStatus.stopping);
    var finished = false;
    unawaited(
      stop.then((_) {
        finished = true;
      }),
    );
    await Future<void>(() {});
    expect(finished, isFalse);
    cleanup.complete();
    final cancelled = await stop;
    expect(cancelled.status, GalleryDuplicateStatus.cancelled);
    expect(cancelled.diagnostics!.failureReason, isNull);
    expect(cancelled.diagnostics!.candidateCount, 2);
    blocked = false;
    await service.start(start('after-stop'));
    expect((await _finished(service)).status, GalleryDuplicateStatus.completed);
    expect(runner.closed, isFalse);
  });

  test('search includes hidden same-path media and remains a snapshot after file operations', () async {
    await second.delete();
    final hiddenDirectory = await Directory(path.join(catalog.stateDirectory.path, 'hidden')).create(recursive: true);
    final hidden = await File(path.join(hiddenDirectory.path, path.basename(first.path))).writeAsBytes([1, 2, 3, 4]);
    runner = GalleryToolStub((executable, args, cancel, env) async {
      expect(args, contains(hiddenDirectory.absolute.path));
      await output(args).writeAsString(
        jsonEncode({
          '4': [
            [entry(first), entry(hidden)],
          ],
        }),
      );
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('hidden-pair'));
    final done = await _finished(service);
    expect(done.status, GalleryDuplicateStatus.completed);
    expect(done.diagnostics!.candidateCount, 2);
    final members = done.groups.single.items;
    expect(members.map((member) => member.section).toSet(), {
      GalleryMediaSection.published,
      GalleryMediaSection.hidden,
    });
    expect(members.map((member) => member.path).toSet(), {path.basename(first.path)});
    expect(members.map((member) => member.mediaId).toSet(), hasLength(2));
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    expect((await service.group('hidden-pair', 0)).group!.items, members);
    final operations = GalleryFileOperations(catalog: catalog);
    addTearDown(operations.close);
    GalleryOperationRequest request(List<GalleryDuplicateMember> selected) => GalleryOperationRequest(
      operationId: 'hidden-dedup',
      action: GalleryMutation.trash,
      items: [
        for (final member in selected)
          GalleryMediaRef(mediaId: member.mediaId, sourceRevision: member.sourceRevision, section: member.section),
      ],
    );
    final selected = members.singleWhere((member) => member.section == GalleryMediaSection.hidden);
    final moved = await operations.mutate(request([selected]));
    expect(moved.items.single.state, GalleryItemOperationState.succeeded);
    expect(first.existsSync(), isTrue);
    expect(hidden.existsSync(), isFalse);
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single.path, path.basename(first.path));
    expect((await service.group('hidden-pair', 0)).group, isNull);
  });

  test('hidden media changed during CLI is excluded from actionable results', () async {
    await second.delete();
    final hiddenDirectory = await Directory(path.join(catalog.stateDirectory.path, 'hidden')).create(recursive: true);
    final hidden = await File(path.join(hiddenDirectory.path, 'hidden.jpg')).writeAsBytes([1, 2, 3, 4]);
    runner = GalleryToolStub((executable, args, cancel, env) async {
      await output(args).writeAsString(
        jsonEncode({
          '4': [
            [entry(first), entry(hidden)],
          ],
        }),
      );
      await hidden.writeAsBytes([9, 8, 7, 6, 5]);
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('changed-hidden'));
    final done = await _finished(service);
    expect(done.status, GalleryDuplicateStatus.completed);
    expect(done.groups, isEmpty);
    expect(done.diagnostics!.candidateCount, 2);
    expect(done.diagnostics!.rejectedResultCount, 1);
  });

  test('mutations use file revisions without changing the duplicate snapshot', () async {
    await service.start(start('snapshot'));
    final done = await _finished(service);
    final members = done.groups.single.items;
    final operations = GalleryFileOperations(catalog: catalog);
    addTearDown(operations.close);
    await second.writeAsBytes([9, 8, 7, 6, 5]);
    final result = await operations.mutate(
      GalleryOperationRequest(
        operationId: 'move-snapshot',
        action: GalleryMutation.trash,
        items: [
          for (final member in members)
            GalleryMediaRef(section: member.section, mediaId: member.mediaId, sourceRevision: member.sourceRevision),
        ],
      ),
    );
    expect(result.items.first.state, GalleryItemOperationState.succeeded);
    expect(result.items.last.error, GalleryErrorCode.revisionMismatch);
    expect((await service.status()).groups, done.groups);
    expect((await service.group('snapshot', 0)).group, isNull);
  });

  test('restart marks persisted running task interrupted; completed results survive restart', () async {
    await service.start(start('saved'));
    final done = await _finished(service);
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    expect(await service.status(), done);
    await service.close();
    await File('${catalog.stateDirectory.path}/duplicates/job.json')
        .writeAsString(jsonEncode(done.copyWith(status: GalleryDuplicateStatus.running).toJson()));
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    expect((await service.status()).status, GalleryDuplicateStatus.interrupted);
  });

  test('failed initial journal write does not leave an immortal running task', () async {
    await service.status();
    await Directory('${catalog.stateDirectory.path}/duplicates/job.json').create();
    await expectLater(service.start(start('cannot-save')), throwsA(isA<FileSystemException>()));
    expect((await service.status()).status, GalleryDuplicateStatus.failed);
    expect(runner.calls, isEmpty);
    expect((await service.start(start('cannot-save'))).status, GalleryDuplicateStatus.failed);
  });

  test('expired results cannot rerun an old operation and only recent groups are retained', () async {
    for (final id in ['first-result', 'second-result', 'third-result']) {
      await service.start(start(id));
      expect((await _finished(service)).status, GalleryDuplicateStatus.completed);
    }
    expect((await service.start(start('second-result'))).groups, hasLength(1));
    await expectLater(
      service.start(start('first-result')),
      throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', GalleryErrorCode.notFound)),
    );
    expect(runner.calls, hasLength(3));
  });

  test('full JSON results are saved and remain readable after restart', () async {
    final pairs = <List<File>>[
      [first, second],
    ];
    for (var index = 1; index < 6; index++) {
      pairs.add([
        await File(path.join(originals.path, 'pair-$index-a.jpg')).writeAsBytes([index, 2, 3, 4]),
        await File(path.join(originals.path, 'pair-$index-b.jpg')).writeAsBytes([index, 2, 3, 4]),
      ]);
    }
    runner = GalleryToolStub((e, args, c, env) async {
      await output(args).writeAsString(
        jsonEncode({
          '4': [for (final pair in pairs) pair.map(entry).toList()],
        }),
      );
      return ok;
    });
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    await service.start(start('full-result'));
    final state = await _finished(service);
    expect(state.status, GalleryDuplicateStatus.completed);
    expect(state.groups, hasLength(6));
    expect(await File('${catalog.stateDirectory.path}/duplicates/job.json').length(), greaterThan(1024));
    await service.close();
    service = GalleryDuplicateService(catalog: catalog, runner: runner);
    final restored = await service.status();
    expect(restored.status, GalleryDuplicateStatus.completed);
    expect(restored.toJson(), state.toJson());
  });
}
