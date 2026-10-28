import 'package:dslideshow_flutter/effect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'preview_photo.dart';

part 'preview_transition.freezed.dart';

/// Immutable borrowed inputs. Slide sessions retain ownership of the pixels.
@freezed
abstract class PreviewTransition with _$PreviewTransition {
  const factory PreviewTransition({
    required MediaSliderItemEffect effect,
    required EffectSlideInput outgoing,
    required EffectSlideInput incoming,
    required Duration duration,
  }) = _PreviewTransition;
}

/// Repeat retains identities and motion seeds, never the old image handles.
@freezed
abstract class PreviewPhotoPair with _$PreviewPhotoPair {
  const factory PreviewPhotoPair({
    required PreviewPhoto from,
    required int fromIndex,
    required PreviewPhoto to,
    required int toIndex,
  }) = _PreviewPhotoPair;
}
