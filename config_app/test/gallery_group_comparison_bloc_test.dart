import 'package:config_app/features/gallery/presentation/bloc/gallery_group_comparison_bloc.dart';
import 'package:config_app/src/gallery/gallery_date_time.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';

import 'support/gallery_management_harness.dart';

GalleryDuplicateMember _member(String id, int? width, int? height) => GalleryDuplicateMember(
  section: GalleryMediaSection.published,
  mediaId: id,
  sourceRevision: '1',
  name: '$id.jpg',
  path: 'private/$id.jpg',
  sizeBytes: 100,
  width: width,
  height: height,
);
GalleryGroupComparisonBloc _bloc(List<GalleryDuplicateMember> members, {bool exact = false}) =>
    GalleryGroupComparisonBloc(
      group: GalleryDuplicateGroup(
        groupId: 'private-group',
        mode: exact ? GalleryDuplicateMode.exact : GalleryDuplicateMode.similar,
        items: members,
      ),
    );
Future<void> _send(GalleryGroupComparisonBloc bloc, GalleryMetadata metadata) async {
  bloc.add(metadata);
  // Comparison handlers are synchronous; unchanged assessments need not emit.
  await Future<void>(() {});
}

GalleryJpegMetadata _jpeg(int? quality, {List<int> sampling = const [0x22, 0x11, 0x11]}) => GalleryJpegMetadata(
  quality: quality,
  qualityMethod: quality == null ? GalleryJpegQualityMethod.unknown : GalleryJpegQualityMethod.standardQuantization,
  precisionBits: 8,
  samplingFactors: sampling,
);

void main() {
  test('dates parse EXIF and ISO offsets and reject invalid values', () {
    expect(GalleryDateTime.parseDateTaken('2026:10:31 15:04:05'), DateTime(2026, 10, 31, 15, 4, 5));
    expect(GalleryDateTime.parseDateTaken('2026:10:31 15:04:05+03:00'), DateTime.utc(2026, 10, 31, 12, 4, 5));
    expect(
      GalleryDateTime.parseDateTaken(' 2026-10-31T12:04:05.123456Z '),
      DateTime.utc(2026, 10, 31, 12, 4, 5, 123, 456),
    );
    expect(GalleryDateTime.parseDateTaken('2024:02:29 00:00:00-0300'), DateTime.utc(2024, 2, 29, 3));
    for (final value in [
      null,
      '',
      'unknown',
      '0000:00:00 00:00:00',
      '2026:02:29 15:04:05',
      '2026:10:31 24:04:05',
      '2026-10-31T15:04:05+03:90',
    ]) {
      expect(GalleryDateTime.parseDateTaken(value), isNull, reason: value);
    }
  });
  test('dates use locale format through seconds without subseconds', () async {
    await initializeDateFormatting();
    final date = DateTime(2026, 10, 31, 15, 4, 5, 123, 456);
    expect(GalleryDateTime.format(date, 'en'), '10/31/2026 15:04:05');
    expect(GalleryDateTime.format(date, 'ru'), '31.10.2026 15:04:05');
    expect(GalleryDateTime.format(null, 'en'), '—');
  });
  test('resolution colours have one best, all distinct minima red, and tied maxima yellow', () async {
    final bloc = _bloc([
      _member('min', 1000, 1000),
      _member('mid', 2000, 1000),
      _member('best', 4000, 1000),
      _member('tie', 2000, 2000),
      _member('unknown', null, null),
    ]);
    addTearDown(bloc.close);
    expect(bloc.state.rank('min', GalleryImageResolution.read(1000, 1000)), GalleryMetricRank.worst);
    expect(bloc.state.rank('mid', GalleryImageResolution.read(2000, 1000)), GalleryMetricRank.intermediate);
    expect(bloc.state.rank('best', GalleryImageResolution.read(4000, 1000)), GalleryMetricRank.best);
    expect(bloc.state.rank('tie', GalleryImageResolution.read(2000, 2000)), GalleryMetricRank.intermediate);
    expect(bloc.state.rank('unknown', null), GalleryMetricRank.unknown);
    await _send(bloc, photoMetadata('unknown').copyWith(width: 5000, height: 1000));
    expect(bloc.state.recommendedMediaId, 'unknown');
    expect(bloc.state.rank('best', GalleryImageResolution.read(4000, 1000)), GalleryMetricRank.intermediate);
    await _send(bloc, photoMetadata('unknown').copyWith(width: 500, height: 1000));
    expect(bloc.state.minPixels, 500000);
    expect(bloc.state.recommendedMediaId, 'best');
  });
  test('all-equal values keep one green without red; a single known value stays neutral', () async {
    final equal = _bloc([_member('a', 1000, 1000), _member('b', 1000, 1000)], exact: true);
    addTearDown(equal.close);
    expect(equal.state.rank('a', GalleryImageResolution.read(1000, 1000)), GalleryMetricRank.best);
    expect(equal.state.rank('b', GalleryImageResolution.read(1000, 1000)), GalleryMetricRank.intermediate);
    final single = _bloc([_member('a', 1000, 1000), _member('b', 0, 1000)]);
    addTearDown(single.close);
    expect(single.state.rank('a', GalleryImageResolution.read(1000, 1000)), GalleryMetricRank.unknown);
    await _send(single, photoMetadata('a').copyWith(width: null, height: null));
    expect(single.state.maxPixels, 1000000, reason: 'CLI dimensions remain a fallback');
  });
  test('capture dates outrank older mtimes and larger images in exact and similar groups', () async {
    for (final exact in [true, false]) {
      final bloc = _bloc([
        _member('large', 6000, 4000),
        _member('old', 1000, 1000),
        _member('older', 500, 500),
      ], exact: exact);
      await _send(bloc, photoMetadata('large').copyWith(fileModified: DateTime.utc(2000)));
      await _send(bloc, photoMetadata('old').copyWith(width: 1000, height: 1000, dateTaken: '2020-01-01T00:00:00Z'));
      expect(bloc.state.recommendedMediaId, 'old');
      expect(bloc.state.reason, GalleryRecommendationReason.hasDateTaken);
      expect(bloc.state.rank('large', GalleryImageResolution.read(6000, 4000)), GalleryMetricRank.best);
      expect(
        bloc.state.dateRank('large', GalleryComparisonDateSource.fileModified, DateTime.utc(2000)),
        GalleryMetricRank.unknown,
      );
      await _send(bloc, photoMetadata('older').copyWith(width: 500, height: 500, dateTaken: '2019:01:01 00:00:00Z'));
      expect(bloc.state.recommendedMediaId, 'older');
      expect(bloc.state.reason, GalleryRecommendationReason.earliestDateTaken);
      expect(bloc.state.provisional, isFalse);
      expect(
        bloc.state.dateRank('older', GalleryComparisonDateSource.dateTaken, DateTime.utc(2019)),
        GalleryMetricRank.best,
      );
      expect(
        bloc.state.dateRank('old', GalleryComparisonDateSource.dateTaken, DateTime.utc(2020)),
        GalleryMetricRank.worst,
      );
      await bloc.close();
    }
  });
  test('mtime fallback uses earliest values, offsets, equal seconds and source order', () async {
    final bloc = _bloc([_member('a', 2000, 1000), _member('b', 1000, 1000), _member('c', 1000, 1000)]);
    addTearDown(bloc.close);
    await _send(
      bloc,
      photoMetadata('b').copyWith(width: 1000, height: 1000, fileModified: DateTime.utc(2020, 1, 1, 0, 0, 0, 1)),
    );
    await _send(
      bloc,
      photoMetadata('a').copyWith(width: 2000, height: 1000, fileModified: DateTime.utc(2020, 1, 1, 0, 0, 0, 999)),
    );
    expect(bloc.state.recommendedMediaId, 'a', reason: 'Subseconds are not a hidden tie-breaker');
    await _send(bloc, photoMetadata('c').copyWith(width: 1000, height: 1000, fileModified: DateTime.utc(2021)));
    expect(
      bloc.state.dateRank('a', GalleryComparisonDateSource.fileModified, DateTime.utc(2020)),
      GalleryMetricRank.best,
    );
    expect(
      bloc.state.dateRank('b', GalleryComparisonDateSource.fileModified, DateTime.utc(2020)),
      GalleryMetricRank.intermediate,
    );
    expect(
      bloc.state.dateRank('c', GalleryComparisonDateSource.fileModified, DateTime.utc(2021)),
      GalleryMetricRank.worst,
    );
    await _send(bloc, photoMetadata('b').copyWith(width: 1000, height: 1000, dateTaken: '2026:10:31 15:04:05+03:00'));
    await _send(bloc, photoMetadata('a').copyWith(width: 2000, height: 1000, dateTaken: '2026-10-31T12:04:05Z'));
    expect(bloc.state.recommendedMediaId, 'a');
    expect(bloc.state.recommendedDate!.value, DateTime.utc(2026, 10, 31, 12, 4, 5));
  });
  test('JPEG quality and size break ties while each indicator keeps its own green value', () async {
    final bloc = _bloc([_member('a', 2000, 1000), _member('b', 2000, 1000), _member('c', 2000, 1000)]);
    addTearDown(bloc.close);
    for (final (id, q, size) in [('a', 90, 5000), ('b', 95, 2000), ('c', 95, 3000)]) {
      await _send(bloc, photoMetadata(id).copyWith(width: 2000, height: 1000, jpeg: _jpeg(q), sizeBytes: size));
    }
    expect(bloc.state.recommendedMediaId, 'c');
    expect(bloc.state.reason, GalleryRecommendationReason.largestJpegFile);
    expect(bloc.state.jpegQuality.rank('b', 95), GalleryMetricRank.best);
    expect(bloc.state.jpegQuality.rank('c', 95), GalleryMetricRank.intermediate);
    expect(bloc.state.jpegQuality.rank('a', 90), GalleryMetricRank.worst);
    expect(bloc.state.jpegSize.rank('a', 5000), GalleryMetricRank.best);
    expect(bloc.state.jpegSize.rank('b', 2000), GalleryMetricRank.worst);
    await _send(bloc, photoMetadata('a').copyWith(width: 2000, height: 1000, jpeg: _jpeg(99), sizeBytes: 1000));
    expect(bloc.state.recommendedMediaId, 'a');
    expect(bloc.state.reason, GalleryRecommendationReason.highestJpegQuality);
  });
  test(
    'unknown JPEG quality is skipped, never zero; differing dimensions and sampling prevent size tie-breaking',
    () async {
      final bloc = _bloc([_member('a', 2000, 1000), _member('b', 2000, 1000)]);
      addTearDown(bloc.close);
      await _send(bloc, photoMetadata('a').copyWith(width: 2000, height: 1000, jpeg: _jpeg(null), sizeBytes: 100));
      await _send(bloc, photoMetadata('b').copyWith(width: 2000, height: 1000, jpeg: _jpeg(99), sizeBytes: 10000));
      expect(bloc.state.recommendedMediaId, 'a');
      expect(bloc.state.jpegQuality.rank('b', 99), GalleryMetricRank.unknown);
      await _send(bloc, photoMetadata('a').copyWith(width: 1000, height: 2000, jpeg: _jpeg(99), sizeBytes: 100));
      expect(bloc.state.recommendedMediaId, 'a', reason: 'Equal pixel count does not make dimensions identical');
      await _send(
        bloc,
        photoMetadata('a')
            .copyWith(width: 2000, height: 1000, jpeg: _jpeg(99, sampling: [0x11, 0x11, 0x11]), sizeBytes: 100),
      );
      expect(bloc.state.recommendedMediaId, 'a', reason: 'Different sampling does not prove size means higher quality');
      await _send(bloc, photoMetadata('a').copyWith(width: 2000, height: 1000, jpeg: null, sizeBytes: 100));
      expect(bloc.state.recommendedMediaId, 'a');
      expect(bloc.state.jpegSize.rank('a', null), GalleryMetricRank.unknown);
    },
  );
  test(
    'removing dates restores indexes and stale versions or sections cannot affect ranking; logs explain choices',
    () async {
      final records = <LogRecord>[], oldLevel = Logger.root.level;
      Logger.root.level = Level.ALL;
      final sub = Logger.root.onRecord.listen(records.add);
      addTearDown(() async {
        await sub.cancel();
        Logger.root.level = oldLevel;
      });
      final bloc = _bloc([_member('a', 6000, 4000), _member('b', 6000, 4000)]);
      addTearDown(bloc.close);
      await _send(bloc, photoMetadata('b').copyWith(dateTaken: '2020-01-01T00:00:00Z'));
      expect(bloc.state.recommendedMediaId, 'b');
      await _send(bloc, photoMetadata('b').copyWith(dateTaken: 'invalid'));
      expect(bloc.state.recommendedMediaId, 'a');
      expect(bloc.state.knownDateCount, 0);
      bloc.add(photoMetadata('a', revision: 'stale-secret').copyWith(dateTaken: '1900-01-01T00:00:00Z'));
      bloc.add(photoMetadata('a').copyWith(section: GalleryMediaSection.hidden, dateTaken: '1900-01-01T00:00:00Z'));
      await _send(bloc, photoMetadata('b').copyWith(fileModified: DateTime.utc(2021)));
      expect(bloc.state.recommendedMediaId, 'b');
      final logs = records.where((r) => r.loggerName == 'GalleryGroupComparisonBloc').toList();
      expect(logs.any((r) => r.message.contains('comparisonOpened')), isTrue);
      expect(logs.any((r) => r.message.contains('comparisonMetadataIgnored')), isTrue);
      expect(logs.any((r) => r.message.contains('reason=hasDateTaken')), isTrue);
      expect(logs.any((r) => r.message.contains('knownJpegQuality=0') && r.message.contains('knownDates=1')), isTrue);
      expect(logs.every((r) => r.level < Level.INFO), isTrue);
      expect(logs.map((r) => r.message).join(), isNot(contains('secret')));
    },
  );
}
