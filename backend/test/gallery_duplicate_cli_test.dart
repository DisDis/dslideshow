// Real headless CLI contract regression; missing tools are failed prerequisites.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_duplicate_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_file_operations.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:image/image.dart' as image;
import 'package:test/test.dart';

final _supportedVersionPattern = RegExp(r'\b(?:8|12)\.\d+\.\d+\b');

Future<GalleryDuplicateJob> _finished(GalleryDuplicateService service) async {
  final clock = Stopwatch()..start();
  while (clock.elapsed < const Duration(seconds: 40)) {
    final job = await service.status();
    if (job.status != GalleryDuplicateStatus.running && job.status != GalleryDuplicateStatus.stopping) return job;
    await Future<void>(() {});
  }
  fail('CLI task did not finish: ${(await service.status()).status.name}');
}

void main() {
  test(
    'real Czkawka exact/similar JSON maps a two-hop root alias to revisioned groups and leaves originals intact',
    () async {
      final root = await Directory.systemTemp.createTemp('gallery-real-cli-');
      final physical = await Directory('${root.path}/physical-images').create();
      await Link('${root.path}/first-hop').create(physical.path);
      await Link('${root.path}/images').create('${root.path}/first-hop');
      final media = Directory('${root.path}/images');
      final state = Directory('${root.path}/images.gallery');
      final runner = ProcessGalleryToolRunner();
      final catalog = GalleryCatalogService(originals: media, stateDirectory: state);
      final executable = Platform.environment['CZKAWKA_CLI'] ?? 'czkawka_cli';
      final service = GalleryDuplicateService(
        catalog: catalog,
        runner: runner,
        executable: executable,
        processTimeout: const Duration(seconds: 30),
      );
      addTearDown(() async {
        await service.close();
        await runner.close();
        await catalog.close();
        await root.delete(recursive: true);
      });

      GalleryToolResult version;
      try {
        version = await runner.run(executable, ['--version'], timeout: const Duration(seconds: 10));
      } on GalleryCatalogFailure catch (error) {
        fail(
          'Czkawka CLI 8.x or 12.x is required for this real integration test '
          '(executable=$executable, error=${error.code.name}). '
          'Set PATH or CZKAWKA_CLI to a verified headless binary; see backend/README.md.',
        );
      }
      expect(version.exitCode, 0, reason: version.stderr);
      expect(
        _supportedVersionPattern.hasMatch(version.stdout),
        true,
        reason: 'Tested adapters require CLI8.x or12.x; actual version: ${version.stdout}',
      );

      final photo = image.Image(width: 128, height: 96);
      for (final pixel in photo) {
        pixel.setRgb(
          (pixel.x * 2 + pixel.y) % 256,
          (pixel.y * 2 + (pixel.x < 40 ? 90 : 0)) % 256,
          (pixel.x > 70 && pixel.y > 30) ? 220 : 20,
        );
      }
      final originalBytes = image.encodePng(photo);
      const originalName = r'source ; $literal.png';
      final fixtures = <String, List<int>>{
        originalName: originalBytes,
        'copy of source.png': originalBytes,
        'resaved.jpg': image.encodeJpg(photo, quality: 92),
      };
      final unique = image.Image(width: 128, height: 96);
      for (final pixel in unique) {
        final light = ((pixel.x ~/ 8) + (pixel.y ~/ 8)).isEven ? 240 : 10;
        pixel.setRgb(light, 30, 255 - light);
      }
      fixtures['different.png'] = image.encodePng(unique);
      final before = <String, String>{};
      for (final fixture in fixtures.entries) {
        await File('${media.path}/${fixture.key}').writeAsBytes(fixture.value);
        before[fixture.key] = sha256.convert(fixture.value).toString();
      }
      // A real photo outside originals is neither scanned nor admitted by JSON
      // mapping; trash and generated state remain independent from the library.
      final trashed = await Directory('${state.path}/trash/album').create(recursive: true);
      await File('${trashed.path}/trashed.png').writeAsBytes(originalBytes);
      final initial = await catalog.catalog();
      final byPath = {for (final entry in initial.entries) entry.path: entry};

      await service.start(
        const GalleryDuplicateStartRequest(
          operationId: 'real-exact-and-similar',
          modes: [GalleryDuplicateMode.exact, GalleryDuplicateMode.similar],
        ),
      );
      final job = await _finished(service);
      expect(
        job.status,
        GalleryDuplicateStatus.completed,
        reason: 'Real CLI job failed: ${job.error?.name}, version=${version.stdout}',
      );
      expect(job.error, null);
      expect(job.diagnostics!.rootAliased, isTrue);
      expect(job.diagnostics!.candidateCount, fixtures.length);
      expect(job.diagnostics!.matchedFileCount, 3);
      expect(job.diagnostics!.rejectedResultCount, 0);
      expect(job.diagnostics!.snapshotSkippedCount, 0);
      final exact = job.groups.where((group) => group.mode == GalleryDuplicateMode.exact);
      expect(
        exact.any(
          (group) => group.items.map((item) => item.path).toSet().containsAll({originalName, 'copy of source.png'}),
        ),
        true,
      );
      expect(exact.expand((group) => group.items).any((item) => item.path == 'resaved.jpg'), false);
      final similar = job.groups.where((group) => group.mode == GalleryDuplicateMode.similar);
      expect(
        similar.any((group) => group.items.map((item) => item.path).toSet().containsAll({originalName, 'resaved.jpg'})),
        true,
      );
      for (final member in job.groups.expand((group) => group.items)) {
        expect(member.path, isNot('trashed.png'));
        expect(member.mediaId, byPath[member.path]!.mediaId);
        expect(member.sourceRevision, byPath[member.path]!.sourceRevision);
        expect(member.sizeBytes, fixtures[member.path]!.length);
      }
      for (final fixture in fixtures.entries) {
        expect(
          sha256.convert(await File('${media.path}/${fixture.key}').readAsBytes()).toString(),
          before[fixture.key],
          reason: 'Search must not alter ${fixture.key}',
        );
      }
      expect((await service.directory.list().toList()).map((file) => file.uri.pathSegments.last).toSet(), {
        'job.json',
      }, reason: 'No CLI JSON, cache, config or scan directories may survive cleanup');
      expect((await media.list().toList()).length, fixtures.length);

      // Regression: both modes must report one group for eight identical files.
      await File('${media.path}/resaved.jpg').delete();
      await File('${media.path}/different.png').delete();
      for (var index = 2; index < 8; index++) {
        await File('${media.path}/identical-$index.png').writeAsBytes(originalBytes);
      }
      catalog.markDirty();
      await service.start(
        const GalleryDuplicateStartRequest(operationId: 'eight-identical', modes: GalleryDuplicateMode.values),
      );
      final identical = await _finished(service);
      expect(identical.status, GalleryDuplicateStatus.completed);
      expect(identical.diagnostics!.matchedFileCount, 8);
      expect(identical.groups, hasLength(1));
      expect(identical.groups.single.mode, GalleryDuplicateMode.exact);
      expect(identical.groups.single.items, hasLength(8));
      expect(identical.groups.single.items.map((item) => item.mediaId).toSet(), hasLength(8));

      // Seven byte-identical originals and one resized frame must all be
      // available for visual comparison; the exact subset remains separate.
      await File('${media.path}/identical-7.png').delete();
      final resized = image.copyResize(photo, width: 96, height: 72, interpolation: image.Interpolation.average);
      await File('${media.path}/resized.png').writeAsBytes(image.encodePng(resized));
      catalog.markDirty();
      await service.start(
        const GalleryDuplicateStartRequest(operationId: 'seven-and-resized', modes: GalleryDuplicateMode.values),
      );
      final resizedJob = await _finished(service);
      expect(resizedJob.status, GalleryDuplicateStatus.completed);
      expect(resizedJob.diagnostics!.matchedFileCount, 8);
      final resizedGroup = resizedJob.groups.singleWhere((g) => g.mode == GalleryDuplicateMode.similar);
      expect(resizedGroup.items, hasLength(8));
      expect(resizedGroup.items.singleWhere((m) => m.path == 'resized.png').width, 96);
      expect(resizedGroup.items.singleWhere((m) => m.path == 'resized.png').height, 72);
      expect(resizedJob.groups.singleWhere((g) => g.mode == GalleryDuplicateMode.exact).items, hasLength(7));
      for (final original in resizedGroup.items.where((m) => m.path != 'resized.png')) {
        expect(
          sha256.convert(await File('${media.path}/${original.path}').readAsBytes()).toString(),
          sha256.convert(originalBytes).toString(),
        );
      }
      expect((await service.directory.list().toList()).map((file) => file.uri.pathSegments.last).toSet(), {'job.json'});

      // Real CLI receives both roots; an equal relative path stays a distinct
      // actionable hidden member rather than aliasing the visible source.
      final hiddenDirectory = await Directory('${state.path}/hidden').create();
      final hiddenFile = await File('${hiddenDirectory.path}/$originalName').writeAsBytes(originalBytes);
      final hiddenEntry = GalleryFileOperations.hiddenEntry(originalName, await hiddenFile.stat());
      await service.start(
        const GalleryDuplicateStartRequest(operationId: 'visible-and-hidden', modes: GalleryDuplicateMode.values),
      );
      final mixed = await _finished(service);
      expect(mixed.status, GalleryDuplicateStatus.completed, reason: mixed.diagnostics.toString());
      expect(mixed.diagnostics!.candidateCount, 9);
      final exactMixed = mixed.groups.singleWhere((group) => group.mode == GalleryDuplicateMode.exact);
      expect(exactMixed.items, hasLength(8));
      final hiddenMember = exactMixed.items.singleWhere((member) => member.section == GalleryMediaSection.hidden);
      expect(hiddenMember.mediaId, hiddenEntry.mediaId);
      expect(hiddenMember.sourceRevision, hiddenEntry.sourceRevision);
      expect(exactMixed.items.where((member) => member.path == originalName), hasLength(2));
      expect(exactMixed.items.map((member) => member.mediaId).toSet(), hasLength(8));
      expect(await hiddenFile.readAsBytes(), originalBytes);
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );
}
