import 'mosaic_fade_effect.dart';

/// The same dense schedule with a binary cutoff rather than per-cell fading.
class MosaicTransitionEffect extends MosaicFadeEffect {
  MosaicTransitionEffect({
    super.gridSize = 100,
    super.seed,
    super.backend = MosaicBackend.canvas,
  }) : super(fadeFraction: 0);
}
