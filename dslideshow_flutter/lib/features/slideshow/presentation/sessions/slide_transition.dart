import 'package:dslideshow_flutter/src/effect/creative_transition_effect.dart'
    show PhotoVhsDamageEffect;
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/photo_shader_effects.dart';
import 'package:dslideshow_flutter/src/effect/radial_blur_effect.dart';
import 'package:dslideshow_flutter/src/effect/water_refraction_effect.dart';
import 'package:flutter/widgets.dart';

import 'slide_session.dart';

/// Binds borrowed pixels without snapshots or decoding. False requests the
/// renderer's Fade fallback when a photo-only effect lacks its prepared pair.
bool bindSlideTransitionPhotos(
  MediaSliderItemEffect effect,
  SlideSession? current,
  SlideSession? next,
  Size size,
) {
  final from = current?.preparedBitmap;
  final to = next?.preparedBitmap;
  if (effect is PhotoVhsDamageEffect) {
    effect.bindPhotos(from, to);
  }
  if (effect is WaterRefractionEffect && (from == null || to == null)) {
    return false;
  }
  final bindPhotos = switch (effect) {
    WaterRefractionEffect water => water.bindPhotos,
    RadialBlurEffect radial => radial.bindPhotos,
    PhotoGlassEffect glass => glass.bindPhotos,
    PhotoFilmDissolveEffect film => film.bindPhotos,
    _ => null,
  };
  if (bindPhotos != null && from != null && to != null) {
    bindPhotos(from, to, fromCamera: current?.photoCamera(size));
  }
  return true;
}
