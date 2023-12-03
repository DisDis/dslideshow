import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_event.freezed.dart';

@freezed
class SlideshowEvent with _$SlideshowEvent {
  const factory SlideshowEvent() = _SlideshowEvent;
  const factory SlideshowEvent.toggleScreenLock(bool value) = SlideshowScreenLockEvent;
  const factory SlideshowEvent.pause(bool value) = SlideshowPauseEvent;
  const factory SlideshowEvent.showMenu(bool value) = SlideshowMenuEvent;
  const factory SlideshowEvent.showInfo(bool value) = SlideshowSystemInfoEvent;
  const factory SlideshowEvent.changeInternetConnection(bool value) = SlideshowInternetEvent;
  const factory SlideshowEvent.showDebug(bool value) = SlideshowDebugEvent;
  const factory SlideshowEvent.changeStorageStatus(StorageStatusEnum value) = SlideshowChangeStorageStatusEvent;
  const factory SlideshowEvent.changeItem() = SlideshowChageItemEvent;
}
