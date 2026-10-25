import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'slideshow_slide.dart';

part 'slideshow_state.freezed.dart';

enum SlideshowPhase {
  initial,
  loadingNext, // Блок загружает данные из storage
  precaching, // UI загружает картинку в память
  ready, // Подготовлен; ожидает снятия паузы или включения экрана
  transition, // UI проигрывает анимацию перехода
  display, // Статичное отображение (работает таймер)
  error, // Ошибка загрузки
}

@freezed
sealed class SlideshowState with _$SlideshowState {
  const SlideshowState._();
  MediaItem? get currentItem =>
      currentSlide is MediaSlide ? (currentSlide as MediaSlide).item : null;
  MediaItem? get nextItem =>
      nextSlide is MediaSlide ? (nextSlide as MediaSlide).item : null;
  const factory SlideshowState({
    SlideshowSlide? currentSlide,
    SlideshowSlide? nextSlide,
    required Effect effect, // Текущий эффект перехода
    @Default(SlideshowPhase.initial) SlideshowPhase phase,
    @Default(false) bool isScreenLocked,
    @Default(false) bool isPaused,
    @Default(false) bool fadeOut, // Для логики затемнения экрана
  }) = _SlideshowState;
}
