import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'media_slider_item_effect.dart';

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

/// A compositing mask: live Texture and GIF descendants remain live, and no
/// snapshot, media resampling or per-cell widget tree is needed.
class ProceduralRevealEffect extends MediaSliderItemEffect {
  final ProceduralRevealKind kind;
  final int seed;
  ui.FragmentProgram? _program;

  ProceduralRevealEffect(this.kind, {int? seed})
    : seed = (seed ?? math.Random().nextInt(4096)) % 4096;

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
        kind: kind,
        seed: seed,
        progress: controller.value,
        child: ColoredBox(color: Colors.black, child: currentWidget),
      ),
    ],
  );
}

class _RevealMask extends SingleChildRenderObjectWidget {
  final ui.FragmentProgram? program;
  final ProceduralRevealKind kind;
  final int seed;
  final double progress;
  const _RevealMask({
    required this.program,
    required this.kind,
    required this.seed,
    required this.progress,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderRevealMask(program, kind, seed, progress);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderRevealMask renderObject,
  ) => renderObject.update(program, kind, seed, progress);
}

class _RenderRevealMask extends RenderProxyBox {
  ui.FragmentProgram? _program;
  ui.FragmentShader? _shader;
  ProceduralRevealKind _kind;
  int _seed;
  double _progress;
  _RenderRevealMask(this._program, this._kind, this._seed, this._progress);

  void update(
    ui.FragmentProgram? program,
    ProceduralRevealKind kind,
    int seed,
    double progress,
  ) {
    if (_program != program) {
      layer = null;
      _shader?.dispose();
      _shader = null;
      _program = program;
    }
    _kind = kind;
    _seed = seed;
    _progress = progress;
    markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null || size.isEmpty || _progress >= 1) {
      layer = null;
      return;
    }
    if (_progress <= 0) {
      layer = null;
      context.paintChild(child!, offset);
      return;
    }
    final program = _program;
    if (program == null) {
      throw StateError('Call effect.prepare() before painting the reveal.');
    }
    final shader = _shader ??= program.fragmentShader();
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, _progress)
      ..setFloat(3, _seed.toDouble())
      ..setFloat(4, _kind.index.toDouble());
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
