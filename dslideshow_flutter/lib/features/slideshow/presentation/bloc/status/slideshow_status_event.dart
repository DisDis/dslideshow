part of 'slideshow_status_bloc.dart';

@freezed
sealed class SlideshowStatusEvent with _$SlideshowStatusEvent {
  const factory SlideshowStatusEvent.toggleScreenLock(bool value) = SlideshowScreenLockEvent;
  const factory SlideshowStatusEvent.pause(bool value) = SlideshowPauseEvent;
  const factory SlideshowStatusEvent.showMenu(bool value) = SlideshowMenuEvent;
  const factory SlideshowStatusEvent.showInfo(bool value) = SlideshowSystemInfoEvent;
  const factory SlideshowStatusEvent.changeInternetConnection(bool value) = SlideshowInternetEvent;
  const factory SlideshowStatusEvent.showDebug(bool value) = SlideshowDebugEvent;
  const factory SlideshowStatusEvent.changeStorageStatus(StorageStatusEnum value) = SlideshowChangeStorageStatusEvent;
}
