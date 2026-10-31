part of 'gallery_group_comparison_bloc.dart';

class _MetricIndex {
  _MetricIndex({this.direction = GalleryMetricDirection.higher});
  final GalleryMetricDirection direction;
  final values = SplayTreeMap<int, SplayTreeSet<int>>();
  final Map<int, int> _positions = {};
  int get knownCount => _positions.length;
  void put(int position, int? value) {
    final old = _positions.remove(position);
    if (old != null) {
      final positions = values[old]!..remove(position);
      if (positions.isEmpty) values.remove(old);
    }
    if (value != null) {
      _positions[position] = value;
      (values[value] ??= SplayTreeSet<int>()).add(position);
    }
  }

  GalleryMetricAssessment assessment(GalleryDuplicateGroup group) {
    final min = values.firstKey(), max = values.lastKey();
    final best = direction == GalleryMetricDirection.higher ? max : min;
    final positions = best == null ? null : values[best];
    return GalleryMetricAssessment(
      knownCount: knownCount,
      minValue: min,
      maxValue: max,
      bestMediaId: positions == null ? null : group.items[positions.first].mediaId,
      bestCount: positions?.length ?? 0,
      direction: direction,
    );
  }
}

class _SizeCandidates {
  final positions = SplayTreeSet<int>();
  final frames = <(GalleryImageResolution, GalleryJpegMetadata)?, int>{};
  final sizes = _MetricIndex();
  void add(int position, GalleryComparisonCandidate value) {
    positions.add(position);
    frames.update(value.jpegFrame, (count) => count + 1, ifAbsent: () => 1);
    sizes.put(position, value.sizeBytes);
  }

  void remove(int position, GalleryComparisonCandidate value) {
    positions.remove(position);
    final frame = value.jpegFrame, count = frames[value.jpegFrame]!;
    if (count == 1) {
      frames.remove(frame);
    } else {
      frames[frame] = count - 1;
    }
    sizes.put(position, null);
  }

  ({int position, GalleryRecommendationReason? reason}) best() {
    final comparable = frames.length == 1 && !frames.containsKey(null);
    if (comparable && sizes.values.length > 1) {
      return (
        position: sizes.values[sizes.values.lastKey()]!.first,
        reason: GalleryRecommendationReason.largestJpegFile,
      );
    }
    return (position: positions.first, reason: null);
  }
}

class _TiedCandidates {
  final all = _SizeCandidates();
  final quality = _MetricIndex();
  final byQuality = <int, _SizeCandidates>{};
  void add(int position, GalleryComparisonCandidate value) {
    all.add(position, value);
    final q = value.quality;
    if (q != null) (byQuality[q] ??= _SizeCandidates()).add(position, value);
    quality.put(position, q);
  }

  void remove(int position, GalleryComparisonCandidate value) {
    all.remove(position, value);
    final q = value.quality;
    if (q != null) {
      final bucket = byQuality[q]!..remove(position, value);
      if (bucket.positions.isEmpty) byQuality.remove(q);
    }
    quality.put(position, null);
  }

  ({int position, GalleryRecommendationReason? reason}) best() {
    if (quality.knownCount == all.positions.length) {
      final result = byQuality[quality.values.lastKey()]!.best();
      return (
        position: result.position,
        reason: result.reason ?? (quality.values.length > 1 ? GalleryRecommendationReason.highestJpegQuality : null),
      );
    }
    return all.best();
  }
}

int _comparePixels(int? a, int? b) => a == b
    ? 0
    : a == null
    ? 1
    : b == null
    ? -1
    : b.compareTo(a);
int _compareDates(GalleryComparisonDate? a, GalleryComparisonDate? b) {
  if (a == b) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  final source = a.source.index.compareTo(b.source.index);
  return source == 0 ? a.value.compareTo(b.value) : source;
}

class _ResolutionCandidates {
  final buckets = SplayTreeMap<int?, _TiedCandidates>(_comparePixels);
  int count = 0;
  void add(int position, GalleryComparisonCandidate value) {
    (buckets[value.resolution?.pixels] ??= _TiedCandidates()).add(position, value);
    count++;
  }

  void remove(int position, GalleryComparisonCandidate value) {
    final key = value.resolution?.pixels;
    final bucket = buckets[key]!..remove(position, value);
    if (bucket.all.positions.isEmpty) buckets.remove(key);
    count--;
  }

  ({int position, GalleryRecommendationReason? reason}) best() {
    final result = buckets[buckets.firstKey()]!.best();
    return (
      position: result.position,
      reason: result.reason ?? (buckets.length > 1 ? GalleryRecommendationReason.highestResolution : null),
    );
  }
}

class _ComparisonTracker {
  _ComparisonTracker(this.group) {
    for (var i = 0; i < group.items.length; i++) {
      final member = group.items[i];
      members[member.mediaId] = member;
      positions[member.mediaId] = i;
      final candidate = GalleryComparisonCandidate(
        mediaId: member.mediaId,
        sizeBytes: member.sizeBytes,
        resolution: GalleryImageResolution.read(member.width, member.height),
      );
      candidates[member.mediaId] = candidate;
      _add(i, candidate);
    }
  }
  final GalleryDuplicateGroup group;
  final members = <String, GalleryDuplicateMember>{};
  final positions = <String, int>{};
  final candidates = <String, GalleryComparisonCandidate>{};
  final metrics = {
    for (final metric in GalleryComparisonMetric.values)
      metric: _MetricIndex(
        direction: metric == GalleryComparisonMetric.dateTaken || metric == GalleryComparisonMetric.fileModified
            ? GalleryMetricDirection.lower
            : GalleryMetricDirection.higher,
      ),
  };
  final dates = SplayTreeMap<GalleryComparisonDate?, _ResolutionCandidates>(_compareDates);
  final sourceCounts = <GalleryComparisonDateSource, int>{};
  int metadataCount = 0;

  void _add(int position, GalleryComparisonCandidate value) {
    (dates[value.date] ??= _ResolutionCandidates()).add(position, value);
    if (value.date case final date?) sourceCounts.update(date.source, (count) => count + 1, ifAbsent: () => 1);
    for (final metric in GalleryComparisonMetric.values) {
      metrics[metric]!.put(position, value.value(metric));
    }
  }

  void _remove(int position, GalleryComparisonCandidate value) {
    final date = value.date;
    final bucket = dates[date]!..remove(position, value);
    if (bucket.count == 0) dates.remove(date);
    if (date != null) sourceCounts[date.source] = sourceCounts[date.source]! - 1;
  }

  bool update(GalleryMetadata metadata) {
    final member = members[metadata.mediaId]!, previous = candidates[metadata.mediaId]!;
    final next = GalleryComparisonCandidate(
      mediaId: member.mediaId,
      sizeBytes: metadata.sizeBytes,
      resolution:
          GalleryImageResolution.read(metadata.width, metadata.height) ??
          GalleryImageResolution.read(member.width, member.height),
      dateTaken: GalleryComparisonDate.throughSeconds(GalleryDateTime.parseDateTaken(metadata.dateTaken)),
      fileModified: GalleryComparisonDate.throughSeconds(metadata.fileModified),
      jpeg: metadata.jpeg,
      metadataLoaded: true,
    );
    if (next == previous) return false;
    final position = positions[member.mediaId]!;
    _remove(position, previous);
    candidates[member.mediaId] = next;
    _add(position, next);
    if (!previous.metadataLoaded) metadataCount++;
    return true;
  }

  GalleryGroupComparisonState state() {
    String? bestId;
    var reason = GalleryRecommendationReason.firstUnknown;
    if (dates.isNotEmpty) {
      final date = dates.firstKey(), bucket = dates[dates.firstKey()]!;
      final result = bucket.best();
      bestId = group.items[result.position].mediaId;
      reason =
          result.reason ??
          (date != null && dates.length > 1
              ? date.source == GalleryComparisonDateSource.fileModified
                    ? GalleryRecommendationReason.earliestFileModified
                    : (sourceCounts[GalleryComparisonDateSource.dateTaken] ?? 0) > bucket.count
                    ? GalleryRecommendationReason.earliestDateTaken
                    : GalleryRecommendationReason.hasDateTaken
              : candidates[bestId]!.resolution == null
              ? GalleryRecommendationReason.firstUnknown
              : GalleryRecommendationReason.firstTied);
    }
    return GalleryGroupComparisonState(
      exact: group.mode == GalleryDuplicateMode.exact,
      totalCount: group.items.length,
      metadataCount: metadataCount,
      knownDateCount:
          (sourceCounts[GalleryComparisonDateSource.dateTaken] ?? 0) +
          (sourceCounts[GalleryComparisonDateSource.fileModified] ?? 0),
      resolution: metrics[GalleryComparisonMetric.resolution]!.assessment(group),
      jpegQuality: metrics[GalleryComparisonMetric.jpegQuality]!.assessment(group),
      jpegSize: metrics[GalleryComparisonMetric.jpegSize]!.assessment(group),
      dateTaken: metrics[GalleryComparisonMetric.dateTaken]!.assessment(group),
      fileModified: metrics[GalleryComparisonMetric.fileModified]!.assessment(group),
      recommendedMediaId: bestId,
      recommendedDate: bestId == null ? null : candidates[bestId]!.date,
      reason: reason,
    );
  }
}
