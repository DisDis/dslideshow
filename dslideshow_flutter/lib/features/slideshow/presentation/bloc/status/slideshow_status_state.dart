part of 'slideshow_status_bloc.dart';

@freezed
class SlideshowStatusState with _$SlideshowStatusState {
  const factory SlideshowStatusState({
    @Default(true) bool hasInternet,
    @Default(false) bool isScreenLock,
    @Default(StorageStatusEnum.done) StorageStatusEnum storageStatus,
    @Default(false) bool isDebug,
    @Default(false) bool isMenu,
    @Default(false) bool isInfo,
    @Default(false) bool isPaused,
  }) = SlideshowStatusInitial;
}

enum StorageStatusEnum {
  download,
  off,
  done;
}
