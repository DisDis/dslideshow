import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../../src/gallery/gallery_date_time.dart';
import '../../../../src/gallery/gallery_log.dart';

part 'gallery_group_comparison_bloc.freezed.dart';
part 'gallery_comparison_index.dart';

enum GalleryMetricRank { unknown, best, intermediate, worst }

enum GalleryMetricDirection { higher, lower }

enum GalleryComparisonMetric { resolution, jpegQuality, jpegSize, dateTaken, fileModified }

enum GalleryComparisonDateSource { dateTaken, fileModified }

enum GalleryRecommendationReason {
  hasDateTaken,
  earliestDateTaken,
  earliestFileModified,
  highestResolution,
  highestJpegQuality,
  largestJpegFile,
  firstTied,
  firstUnknown,
}

@freezed
abstract class GalleryComparisonDate with _$GalleryComparisonDate {
  const factory GalleryComparisonDate({required DateTime value, required GalleryComparisonDateSource source}) =
      _GalleryComparisonDate;

  static DateTime? throughSeconds(DateTime? value) {
    if (value == null) return null;
    final utc = value.toUtc();
    return DateTime.utc(utc.year, utc.month, utc.day, utc.hour, utc.minute, utc.second);
  }
}

@freezed
abstract class GalleryImageResolution with _$GalleryImageResolution {
  const GalleryImageResolution._();
  const factory GalleryImageResolution({required int width, required int height}) = _GalleryImageResolution;
  int get pixels => width * height;
  static GalleryImageResolution? read(int? width, int? height) =>
      width != null && height != null && width > 0 && height > 0
      ? GalleryImageResolution(width: width, height: height)
      : null;
}

@freezed
abstract class GalleryMetricAssessment with _$GalleryMetricAssessment {
  const GalleryMetricAssessment._();
  const factory GalleryMetricAssessment({
    @Default(0) int knownCount,
    int? minValue,
    int? maxValue,
    String? bestMediaId,
    @Default(0) int bestCount,
    @Default(GalleryMetricDirection.higher) GalleryMetricDirection direction,
  }) = _GalleryMetricAssessment;

  GalleryMetricRank rank(String mediaId, int? value) {
    if (value == null || knownCount < 2) return GalleryMetricRank.unknown;
    if (mediaId == bestMediaId) return GalleryMetricRank.best;
    final worst = direction == GalleryMetricDirection.higher ? minValue : maxValue;
    if (minValue != maxValue && value == worst) return GalleryMetricRank.worst;
    return GalleryMetricRank.intermediate;
  }
}

@freezed
abstract class GalleryComparisonCandidate with _$GalleryComparisonCandidate {
  const GalleryComparisonCandidate._();
  const factory GalleryComparisonCandidate({
    required String mediaId,
    required int sizeBytes,
    GalleryImageResolution? resolution,
    DateTime? dateTaken,
    DateTime? fileModified,
    GalleryJpegMetadata? jpeg,
    @Default(false) bool metadataLoaded,
  }) = _GalleryComparisonCandidate;

  GalleryComparisonDate? get date {
    final value = dateTaken ?? fileModified;
    return value == null
        ? null
        : GalleryComparisonDate(
            value: value,
            source: dateTaken == null
                ? GalleryComparisonDateSource.fileModified
                : GalleryComparisonDateSource.dateTaken,
          );
  }

  int? get quality => jpeg?.comparableQuality;

  (GalleryImageResolution, GalleryJpegMetadata)? get jpegFrame =>
      quality != null && resolution != null && jpeg?.precisionBits != null && jpeg!.samplingFactors.isNotEmpty
      ? (resolution!, jpeg!)
      : null;

  int? value(GalleryComparisonMetric metric) => switch (metric) {
    GalleryComparisonMetric.resolution => resolution?.pixels,
    GalleryComparisonMetric.jpegQuality => quality,
    GalleryComparisonMetric.jpegSize => jpeg == null ? null : sizeBytes,
    GalleryComparisonMetric.dateTaken => dateTaken?.millisecondsSinceEpoch,
    GalleryComparisonMetric.fileModified => fileModified?.millisecondsSinceEpoch,
  };
}

@freezed
abstract class GalleryGroupComparisonState with _$GalleryGroupComparisonState {
  const GalleryGroupComparisonState._();
  const factory GalleryGroupComparisonState({
    required bool exact,
    required int totalCount,
    @Default(0) int metadataCount,
    @Default(0) int knownDateCount,
    @Default(GalleryMetricAssessment()) GalleryMetricAssessment resolution,
    @Default(GalleryMetricAssessment()) GalleryMetricAssessment jpegQuality,
    @Default(GalleryMetricAssessment()) GalleryMetricAssessment jpegSize,
    @Default(GalleryMetricAssessment(direction: GalleryMetricDirection.lower)) GalleryMetricAssessment dateTaken,
    @Default(GalleryMetricAssessment(direction: GalleryMetricDirection.lower)) GalleryMetricAssessment fileModified,
    String? recommendedMediaId,
    GalleryComparisonDate? recommendedDate,
    @Default(GalleryRecommendationReason.firstUnknown) GalleryRecommendationReason reason,
  }) = _GalleryGroupComparisonState;

  bool get provisional => metadataCount < totalCount;
  bool get complete => resolution.knownCount == totalCount;
  int get knownCount => resolution.knownCount;
  int? get minPixels => resolution.minValue;
  int? get maxPixels => resolution.maxValue;
  int get maximumCount => resolution.bestCount;
  bool recommended(String id) => id == recommendedMediaId;

  GalleryMetricRank rank(String id, GalleryImageResolution? value) => resolution.rank(id, value?.pixels);
  GalleryMetricRank dateRank(String id, GalleryComparisonDateSource source, DateTime? value) {
    if (source == GalleryComparisonDateSource.fileModified && dateTaken.knownCount > 0) {
      return GalleryMetricRank.unknown;
    }
    final assessment = source == GalleryComparisonDateSource.dateTaken ? dateTaken : fileModified;
    return assessment.rank(id, GalleryComparisonDate.throughSeconds(value)?.millisecondsSinceEpoch);
  }
}

/// Owns indexed assessments for the current group; metadata arrives only from mounted cards.
class GalleryGroupComparisonBloc extends Bloc<GalleryMetadata, GalleryGroupComparisonState> {
  static final _log = Logger('GalleryGroupComparisonBloc');
  final GalleryDuplicateGroup group;
  final _ComparisonTracker _tracker;

  factory GalleryGroupComparisonBloc({required GalleryDuplicateGroup group}) =>
      GalleryGroupComparisonBloc._(group, _ComparisonTracker(group));

  GalleryGroupComparisonBloc._(this.group, this._tracker) : super(_tracker.state()) {
    _logState('comparisonOpened', state);
    on<GalleryMetadata>((metadata, emit) {
      final member = _tracker.members[metadata.mediaId];
      if (member == null || member.sourceRevision != metadata.sourceRevision || member.section != metadata.section) {
        _log.fine('event=comparisonMetadataIgnored reason=sourceChanged');
        return;
      }
      if (!_tracker.update(metadata)) return;
      final next = _tracker.state();
      _logState('comparisonUpdated', next);
      emit(next);
    });
  }

  void _logState(String event, GalleryGroupComparisonState value) => _log.fine(
    () =>
        'event=$event group=${GalleryLog.id(group.groupId)} members=${value.totalCount} known=${value.knownCount} '
        'metadata=${value.metadataCount} knownDates=${value.knownDateCount} knownJpegQuality=${value.jpegQuality.knownCount} '
        'provisional=${value.provisional} candidateIndex=${_tracker.positions[value.recommendedMediaId] ?? -1} reason=${value.reason.name}',
  );

  @override
  Future<void> close() {
    _logState('comparisonClosed', state);
    return super.close();
  }
}
