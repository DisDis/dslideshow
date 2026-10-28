import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'media_slider_item_effect.dart';
import 'effect_geometry.dart';

import 'package:dslideshow_common/effects.dart';

enum ProceduralRevealKind { noiseDissolve, rippleReveal, waterBase }

const proceduralRevealAsset =
    'packages/dslideshow_flutter/src/effect/shaders/procedural_reveal.frag';
Future<ui.FragmentProgram>? _pendingProgram;
ui.FragmentProgram? _cachedProgram;

Future<ui.FragmentProgram> _loadProgram() async {
  if (_cachedProgram case final program?) return program;
  final pending = _pendingProgram ??= ui.FragmentProgram.fromAsset(
    proceduralRevealAsset,
  );
  try {
    return _cachedProgram = await pending;
  } catch (_) {
    if (identical(pending, _pendingProgram)) _pendingProgram = null;
    rethrow;
  }
}

/// A compositing mask over the live media layer. GPU parameters are fixed for
/// the transition; each render object owns and disposes its shader instance.
class ProceduralRevealEffect extends MediaSliderItemEffect {
  final ProceduralRevealKind kind;
  final int seed;
  final EffectOrigin origin;
  final double noiseScale, softness, waveAmplitude, waveFrequency;
  ui.FragmentProgram? _program;
  ProceduralRevealEffect(
    this.kind, {
    int? seed,
    this.origin = EffectOrigin.center,
    this.noiseScale = 28,
    double? softness,
    this.waveAmplitude = .045,
    this.waveFrequency = 82,
  }) : seed = (seed ?? math.Random().nextInt(4096)) % 4096,
       softness =
           softness ??
           (kind == ProceduralRevealKind.noiseDissolve
               ? .08
               : kind == ProceduralRevealKind.waterBase
               ? .04
               : .025);
  @override
  Future<void> prepare() async => _program = await _loadProgram();
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;
  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) => Stack(
    fit: StackFit.expand,
    children: [
      ColoredBox(color: Colors.black, child: nextWidget),
      _RevealMask(
        program: _program,
        effect: this,
        progress: controller.value,
        child: ColoredBox(color: Colors.black, child: currentWidget),
      ),
    ],
  );
}

class _RevealMask extends SingleChildRenderObjectWidget {
  final ui.FragmentProgram? program;
  final ProceduralRevealEffect effect;
  final double progress;
  const _RevealMask({
    required this.program,
    required this.effect,
    required this.progress,
    required super.child,
  });
  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderRevealMask(this);
  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderRevealMask renderObject,
  ) => renderObject.update(this);
}

class _RenderRevealMask extends RenderProxyBox {
  _RevealMask _data;
  ui.FragmentShader? _shader;
  _RenderRevealMask(this._data);
  void update(_RevealMask data) {
    if (_data.program != data.program) {
      layer = null;
      _shader?.dispose();
      _shader = null;
    }
    _data = data;
    markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;
  @override
  void paint(PaintingContext context, Offset offset) {
    final progress = _data.progress;
    if (child == null || size.isEmpty || progress >= 1) {
      layer = null;
      return;
    }
    if (progress <= 0) {
      layer = null;
      context.paintChild(child!, offset);
      return;
    }
    final program = _data.program;
    if (program == null) {
      throw StateError('Call effect.prepare() before painting the reveal.');
    }
    final effect = _data.effect;
    final origin = effectOrigin(effect.origin).alongSize(size);
    final shader = _shader ??= program.fragmentShader();
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, progress)
      ..setFloat(3, effect.seed.toDouble())
      ..setFloat(4, effect.kind.index.toDouble())
      ..setFloat(5, origin.dx)
      ..setFloat(6, origin.dy)
      ..setFloat(7, effect.noiseScale)
      ..setFloat(8, effect.softness)
      ..setFloat(9, effect.waveAmplitude)
      ..setFloat(10, effect.waveFrequency);
    final mask = (layer ??= ShaderMaskLayer()) as ShaderMaskLayer;
    mask
      ..shader = shader
      ..maskRect = offset & size
      ..blendMode = BlendMode.dstIn;
    context.pushLayer(mask, super.paint, offset);
  }

  @override
  void dispose() {
    layer = null;
    _shader?.dispose();
    super.dispose();
  }
}
