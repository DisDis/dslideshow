import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../../src/gallery/gallery_log.dart';

part 'gallery_group_comparison_bloc.freezed.dart';

enum GalleryResolutionRank { unknown, recommended, minimum, other }

enum GalleryRecommendationReason {
  highestResolution,
  firstTied,
  firstExactCopy,
  highestKnownResolution,
  firstUnknown,
}

@freezed
abstract class GalleryImageResolution with _$GalleryImageResolution {
  const GalleryImageResolution._();
  const factory GalleryImageResolution({
    required int width,
    required int height,
  }) = _GalleryImageResolution;

  int get pixels => width * height;

  static GalleryImageResolution? read(int? width, int? height) =>
      width != null && height != null && width > 0 && height > 0
      ? GalleryImageResolution(width: width, height: height)
      : null;
}

@freezed
abstract class GalleryGroupComparisonState with _$GalleryGroupComparisonState {
  const GalleryGroupComparisonState._();
  const factory GalleryGroupComparisonState({
    required bool exact,
    required int totalCount,
    required int knownCount,
    required int? minPixels,
    required int? maxPixels,
    required int maximumCount,
    required int minSizeBytes,
    required int maxSizeBytes,
    required String? recommendedMediaId,
  }) = _GalleryGroupComparisonState;

  bool get complete => knownCount == totalCount;

  GalleryResolutionRank rank(
    String mediaId,
    GalleryImageResolution? resolution,
  ) {
    if (recommended(mediaId)) return GalleryResolutionRank.recommended;
    if (exact) return GalleryResolutionRank.other;
    if (resolution == null) return GalleryResolutionRank.unknown;
    if (minPixels != maxPixels && resolution.pixels == minPixels) {
      return GalleryResolutionRank.minimum;
    }
    return GalleryResolutionRank.other;
  }

  bool recommended(String mediaId) => recommendedMediaId == mediaId;

  GalleryRecommendationReason get reason {
    if (exact) return GalleryRecommendationReason.firstExactCopy;
    if (knownCount == 0) return GalleryRecommendationReason.firstUnknown;
    if (!complete) return GalleryRecommendationReason.highestKnownResolution;
    if (maximumCount > 1) return GalleryRecommendationReason.firstTied;
    return GalleryRecommendationReason.highestResolution;
  }

  bool smallestFile(int sizeBytes) =>
      minSizeBytes < maxSizeBytes && sizeBytes == minSizeBytes;
}

/// Holds only the current group. Mounted metadata owners supply corrections;
/// this Bloc never fetches files or details for unmounted cards.
class GalleryGroupComparisonBloc
    extends Bloc<GalleryMetadata, GalleryGroupComparisonState> {
  static final _log = Logger('GalleryGroupComparisonBloc');
  final GalleryDuplicateGroup group;
  final Map<String, GalleryDuplicateMember> _members;
  final Map<String, int> _positions;
  final Map<String, GalleryImageResolution?> _resolutions = {};
  final SplayTreeMap<int, SplayTreeSet<int>> _pixelMembers = SplayTreeMap();
  int _knownCount = 0;

  GalleryGroupComparisonBloc({required this.group})
    : _members = {for (final member in group.items) member.mediaId: member},
      _positions = {
        for (var i = 0; i < group.items.length; i++) group.items[i].mediaId: i,
      },
      super(_initial(group)) {
    for (final member in group.items) {
      final resolution = GalleryImageResolution.read(
        member.width,
        member.height,
      );
      _resolutions[member.mediaId] = resolution;
      if (resolution != null) {
        _addPixels(resolution.pixels, _positions[member.mediaId]!);
      }
    }
    _log.fine(
      () =>
          'event=comparisonOpened group=${GalleryLog.id(group.groupId)} members=${state.totalCount} known=${state.knownCount} exact=${state.exact} candidateIndex=${_positions[state.recommendedMediaId] ?? -1} reason=${state.reason.name}',
    );
    on<GalleryMetadata>((metadata, emit) {
      final member = _members[metadata.mediaId];
      if (member == null || member.sourceRevision != metadata.sourceRevision) {
        _log.fine('event=comparisonMetadataIgnored reason=sourceChanged');
        return;
      }
      final resolution =
          GalleryImageResolution.read(metadata.width, metadata.height) ??
          GalleryImageResolution.read(member.width, member.height);
      final previous = _resolutions[member.mediaId];
      if (resolution == previous) return;
      final position = _positions[member.mediaId]!;
      if (previous != null) {
        final positions = _pixelMembers[previous.pixels]!..remove(position);
        if (positions.isEmpty) _pixelMembers.remove(previous.pixels);
        _knownCount--;
      }
      _resolutions[member.mediaId] = resolution;
      if (resolution != null) _addPixels(resolution.pixels, position);
      final max = _pixelMembers.lastKey();
      final bestPosition = state.exact || max == null
          ? 0
          : _pixelMembers[max]!.first;
      final next = state.copyWith(
        knownCount: _knownCount,
        minPixels: _pixelMembers.firstKey(),
        maxPixels: max,
        maximumCount: _pixelMembers[max]?.length ?? 0,
        recommendedMediaId: group.items[bestPosition].mediaId,
      );
      _log.fine(
        () =>
            'event=comparisonUpdated group=${GalleryLog.id(group.groupId)} known=${next.knownCount} total=${next.totalCount} complete=${next.complete} maximumTies=${next.maximumCount} candidateIndex=${_positions[next.recommendedMediaId] ?? -1} reason=${next.reason.name}',
      );
      emit(next);
    });
  }

  void _addPixels(int pixels, int position) {
    (_pixelMembers[pixels] ??= SplayTreeSet<int>()).add(position);
    _knownCount++;
  }

  static GalleryGroupComparisonState _initial(GalleryDuplicateGroup group) {
    final counts = SplayTreeMap<int, int>();
    var known = 0;
    var minSize = group.items.firstOrNull?.sizeBytes ?? 0;
    var maxSize = minSize;
    var bestPosition = 0;
    int? largest;
    for (var i = 0; i < group.items.length; i++) {
      final member = group.items[i];
      final resolution = GalleryImageResolution.read(
        member.width,
        member.height,
      );
      if (resolution != null) {
        if (largest == null || resolution.pixels > largest) {
          largest = resolution.pixels;
          bestPosition = i;
        }
        counts[resolution.pixels] = (counts[resolution.pixels] ?? 0) + 1;
        known++;
      }
      if (member.sizeBytes < minSize) minSize = member.sizeBytes;
      if (member.sizeBytes > maxSize) maxSize = member.sizeBytes;
    }
    final max = counts.lastKey();
    return GalleryGroupComparisonState(
      exact: group.mode == GalleryDuplicateMode.exact,
      totalCount: group.items.length,
      knownCount: known,
      minPixels: counts.firstKey(),
      maxPixels: max,
      maximumCount: counts[max] ?? 0,
      minSizeBytes: minSize,
      maxSizeBytes: maxSize,
      recommendedMediaId: group.items.isEmpty
          ? null
          : group
                .items[group.mode == GalleryDuplicateMode.exact
                    ? 0
                    : bestPosition]
                .mediaId,
    );
  }

  @override
  Future<void> close() {
    _log.fine(
      () =>
          'event=comparisonClosed group=${GalleryLog.id(group.groupId)} known=$_knownCount',
    );
    return super.close();
  }
}
