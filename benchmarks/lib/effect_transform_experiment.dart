// Experimental, quality-changing transform sampling. Production defaults stay
// in lib/main.dart; use identical input configuration for a matched comparison.
import 'package:dslideshow_flutter/effect.dart';

import 'main.dart' as benchmark;
import 'src/experimental/retained_transform_effects.dart';
import 'src/experimental/shader_radial_blur_effect.dart';

Future<void> main() => benchmark.runBenchmark(
  effectFactory: (test, seed) {
    final effect = test.effect;
    if (effect == null) return null;
    final canonical = effect.canonical;
    return canonical.type == EffectType.radialBlur
        ? ShaderRadialBlurEffect(
            options: canonical.options as RadialBlurEffectOptions,
          )
        : createRetainedTransformExperiment(canonical);
  },
  onEffectPrepared: (effect, from, to) {
    if (effect is ShaderRadialBlurEffect) {
      if (from == null || to == null) {
        throw StateError(
          'Experimental Radial Blur requires two prepared static photos',
        );
      }
      effect.bindPhotos(from, to);
    }
  },
  experimentMetadata: const {
    'id': 'retained-high-transform',
    'status': 'experimental_requires_manual_visual_review',
    'implementations': [
      'OptimizedStretchEffect',
      'OptimizedZoomOverEffect',
      'ShaderRadialBlurEffect',
    ],
    'sampling': 'Transform.filterQuality.high/ImageFilter.matrix',
    'radial_sampling':
        '9 rays × 2 full-resolution bilinear texture lookups; '
        'float source-over, no per-layer RGBA8 rounding',
    'production_defaults_changed': false,
  },
);
