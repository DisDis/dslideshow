import 'package:config_app/features/gallery/presentation/bloc/gallery_group_comparison_bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/gallery_management_harness.dart';

GalleryDuplicateMember _member(String id, int? width, int? height, {int bytes = 100}) => GalleryDuplicateMember(
  section: GalleryMediaSection.published,
  mediaId: id,
  sourceRevision: '1',
  name: '$id.jpg',
  path: 'private/$id.jpg',
  sizeBytes: bytes,
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

Future<void> _update(
  GalleryGroupComparisonBloc bloc,
  GalleryMetadata metadata,
  bool Function(GalleryGroupComparisonState) ready,
) async {
  final done = bloc.stream.firstWhere(ready).timeout(const Duration(seconds: 2));
  bloc.add(metadata);
  await done;
}

void main() {
  test('whole-group winner uses known resolutions and is corrected when missing dimensions arrive', () async {
    final bloc = _bloc([
      _member('minimum', 1000, 1000),
      _member('middle', 2000, 1000),
      _member('old-maximum', 1500, 2000),
      _member('unknown', null, null),
    ]);
    addTearDown(bloc.close);
    final oldMaximum = GalleryImageResolution.read(1500, 2000)!;
    expect(bloc.state.knownCount, 3);
    expect(bloc.state.rank('minimum', GalleryImageResolution.read(1000, 1000)), GalleryResolutionRank.minimum);
    expect(bloc.state.rank('middle', GalleryImageResolution.read(2000, 1000)), GalleryResolutionRank.other);
    expect(bloc.state.rank('old-maximum', oldMaximum), GalleryResolutionRank.recommended);
    expect(bloc.state.recommended('old-maximum'), isTrue);
    expect(bloc.state.reason, GalleryRecommendationReason.highestKnownResolution);
    expect(bloc.state.rank('unknown', null), GalleryResolutionRank.unknown);
    await _update(bloc, photoMetadata('unknown').copyWith(width: 2000, height: 2000), (s) => s.complete);
    expect(bloc.state.rank('old-maximum', oldMaximum), GalleryResolutionRank.other);
    expect(bloc.state.recommended('unknown'), isTrue);
    await _update(bloc, photoMetadata('unknown').copyWith(width: 500, height: 1000), (s) => s.minPixels == 500000);
    expect(bloc.state.maxPixels, 3000000);
    expect(bloc.state.recommended('old-maximum'), isTrue);
  });

  test('equal pixel counts choose the first highest; all other equals are yellow and bytes never break ties', () async {
    final bloc = _bloc([
      _member('portrait', 3000, 4000, bytes: 1000),
      _member('landscape', 4000, 3000, bytes: 2000),
      _member('small', 1000, 1000, bytes: 3000),
    ]);
    addTearDown(bloc.close);
    final large = GalleryImageResolution.read(3000, 4000)!;
    expect(bloc.state.maximumCount, 2);
    expect(bloc.state.reason, GalleryRecommendationReason.firstTied);
    expect(bloc.state.rank('portrait', large), GalleryResolutionRank.recommended);
    expect(bloc.state.rank('landscape', large), GalleryResolutionRank.other);
    expect(bloc.state.recommended('portrait'), isTrue);
    expect(bloc.state.recommended('landscape'), isFalse);
    expect(bloc.state.smallestFile(1000), isTrue);
    expect(bloc.state.smallestFile(3000), isFalse);
    await _update(bloc, photoMetadata('small').copyWith(width: 4000, height: 3000), (s) => s.maximumCount == 3);
    expect(bloc.state.rank('portrait', large), GalleryResolutionRank.recommended);
    expect(bloc.state.rank('landscape', large), GalleryResolutionRank.other);
    expect(bloc.state.rank('small', large), GalleryResolutionRank.other);
    expect(bloc.state.recommendedMediaId, 'portrait');
  });

  test(
    'zero or incomplete dimensions are unknown; valid CLI dimensions survive an unreadable metadata fallback',
    () async {
      final bloc = _bloc([_member('a', 0, 100), _member('b', 1000, 500)]);
      expect(bloc.state.knownCount, 1);
      expect(bloc.state.rank('b', GalleryImageResolution.read(1000, 500)), GalleryResolutionRank.recommended);
      bloc.add(photoMetadata('b').copyWith(width: null, height: null));
      await bloc.close();
      expect(bloc.state.knownCount, 1);
      expect(bloc.state.maxPixels, 500000);
      expect(GalleryImageResolution.read(0, 100), isNull);
      expect(GalleryImageResolution.read(100, -2), isNull);
      expect(GalleryImageResolution.read(100, null), isNull);
    },
  );

  test('exact copies always recommend the first instance; all other resolutions are yellow', () async {
    final bloc = _bloc([_member('a', 6000, 4000), _member('b', 6000, 4000)], exact: true);
    expect(bloc.state.exact, isTrue);
    expect(bloc.state.rank('a', GalleryImageResolution.read(6000, 4000)), GalleryResolutionRank.recommended);
    expect(bloc.state.recommended('a'), isTrue);
    expect(bloc.state.rank('b', GalleryImageResolution.read(6000, 4000)), GalleryResolutionRank.other);
    expect(bloc.state.reason, GalleryRecommendationReason.firstExactCopy);
    expect(bloc.state.smallestFile(100), isFalse);
    await bloc.close();
  });

  test(
    'unknown dimensions still yield one candidate; tied replies select by group order rather than arrival order',
    () async {
      final bloc = _bloc([_member('first', null, null), _member('second', null, null)]);
      addTearDown(bloc.close);
      expect(bloc.state.recommendedMediaId, 'first');
      expect(bloc.state.reason, GalleryRecommendationReason.firstUnknown);
      await _update(
        bloc,
        photoMetadata('second').copyWith(width: 2000, height: 1000),
        (s) => s.recommendedMediaId == 'second',
      );
      expect(bloc.state.reason, GalleryRecommendationReason.highestKnownResolution);
      await _update(
        bloc,
        photoMetadata('first').copyWith(width: 1000, height: 2000),
        (s) => s.recommendedMediaId == 'first',
      );
      expect(bloc.state.reason, GalleryRecommendationReason.firstTied);
      expect(bloc.state.maximumCount, 2);
    },
  );

  test('stale replies cannot change the assessment; lifecycle logs omit paths and remain below INFO', () async {
    final records = <LogRecord>[];
    final oldLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = oldLevel;
    });
    final bloc = _bloc([_member('a', null, null), _member('b', 1000, 1000)]);
    bloc.add(photoMetadata('a', revision: 'stale-secret').copyWith(width: 9999));
    bloc.add(photoMetadata('unknown-secret'));
    await _update(bloc, photoMetadata('a').copyWith(width: 2000, height: 1000), (s) => s.complete);
    expect(bloc.state.maxPixels, 2000000);
    await bloc.close();
    final logs = records.where((r) => r.loggerName == 'GalleryGroupComparisonBloc').toList();
    expect(logs.any((r) => r.message.contains('comparisonOpened')), isTrue);
    expect(logs.any((r) => r.message.contains('comparisonMetadataIgnored')), isTrue);
    expect(logs.any((r) => r.message.contains('comparisonUpdated')), isTrue);
    expect(
      logs.any((r) => r.message.contains('candidateIndex=0') && r.message.contains('reason=highestResolution')),
      isTrue,
    );
    expect(logs.any((r) => r.message.contains('comparisonClosed')), isTrue);
    expect(logs.every((r) => r.level < Level.INFO), isTrue);
    expect(logs.map((r) => r.message).join(), isNot(contains('private')));
    expect(logs.map((r) => r.message).join(), isNot(contains('secret')));
  });
}
