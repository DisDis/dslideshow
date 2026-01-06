import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_event.freezed.dart';

@freezed
class SlideshowEvent with _$SlideshowEvent {
  // Старт
  const factory SlideshowEvent.init() = SlideshowInitEvent;

  // Логика цикла
  const factory SlideshowEvent.loadNext() = SlideshowLoadNextEvent;
  const factory SlideshowEvent.imageReady() =
      SlideshowImageReadyEvent; // Вызывается UI после precache
  const factory SlideshowEvent.transitionComplete() =
      SlideshowTransitionCompleteEvent; // Вызывается UI после анимации
  const factory SlideshowEvent.timerComplete() =
      SlideshowTimerCompleteEvent; // Вызывается таймером Блока

  // Внешние воздействия
  const factory SlideshowEvent.togglePause(bool isPaused) =
      SlideshowTogglePauseEvent;
  const factory SlideshowEvent.toggleScreenLock(bool isLocked) =
      SlideshowToggleScreenLockEvent;
  const factory SlideshowEvent.screenStatePreparation(bool enabled) =
      SlideshowScreenStatePreparationEvent;
}
