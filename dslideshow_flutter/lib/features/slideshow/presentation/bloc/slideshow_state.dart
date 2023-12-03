import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_state.freezed.dart';

enum StorageStatusEnum {
  download,
  off,
  done;
}

@freezed
class SlideshowState with _$SlideshowState {
  const factory SlideshowState(
      {required bool hasInternet,
      required bool isScreenLock,
      @Default(StorageStatusEnum.done) StorageStatusEnum storageStatus,
      required bool isDebug,
      required bool isMenu,
      required bool isInfo,
      required bool isPaused,
      required MediaItem item,
      required MediaSliderItemEffect effect}) = _SlideshowWorkState;
}

@freezed
class IndicatorState with _$IndicatorState {
  const factory IndicatorState(
      {required bool hasInternet,
      required StorageStatusEnum storageStatus,
      required bool isDebug,
      required bool isMenu,
      required bool isPaused}) = _IndicatorState;
}
