import 'package:dslideshow_backend/storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_state.freezed.dart';

@freezed
sealed class SlideshowState with _$SlideshowState {
  const factory SlideshowState({
    required MediaItem item,
  }) = _SlideshowWorkState;
}
