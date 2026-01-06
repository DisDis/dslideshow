import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_state.freezed.dart';

enum SlideshowPhase {
  initial,
  loadingNext, // Блок загружает данные из storage
  precaching, // UI загружает картинку в память
  transition, // UI проигрывает анимацию перехода
  display, // Статичное отображение (работает таймер)
  error, // Ошибка загрузки
}

@freezed
sealed class SlideshowState with _$SlideshowState {
  const factory SlideshowState({
    required MediaItem? currentItem,
    required MediaItem? nextItem,
    required Effect effect, // Текущий эффект перехода
    @Default(SlideshowPhase.initial) SlideshowPhase phase,
    @Default(false) bool isScreenLocked,
    @Default(false) bool isPaused,
    @Default(false) bool fadeOut, // Для логики затемнения экрана
  }) = _SlideshowState;
}
