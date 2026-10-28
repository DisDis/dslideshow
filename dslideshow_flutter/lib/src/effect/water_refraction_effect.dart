import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';
import 'procedural_reveal_effect.dart';
import 'effect_geometry.dart';

import 'package:dslideshow_common/effects.dart';

const waterRefractionAsset =
    'packages/dslideshow_flutter/src/effect/shaders/water_refraction.frag';
Future<ui.FragmentProgram>? _pendingProgram;
ui.FragmentProgram? _cachedProgram;

/// Static photo inputs are borrowed from their owners for the transition.
/// No decoder, framebuffer snapshot or reduced-resolution copy is created.
class WaterRefractionEffect extends MediaSliderItemEffect {
  final WaterRefractionEffectOptions options;
  final ProceduralRevealEffect _base;
  WaterRefractionEffect({this.options = const WaterRefractionEffectOptions()})
    : _base = ProceduralRevealEffect(
        ProceduralRevealKind.waterBase,
        seed: 0,
        origin: options.origin,
      );
  ui.FragmentProgram? _program;
  ui.Image? _from, _to;
  Matrix4 _fromCamera = Matrix4.identity();

  void bindPhotos(ui.Image from, ui.Image to, {Matrix4? fromCamera}) {
    _from = from;
    _to = to;
    _fromCamera = fromCamera == null
        ? Matrix4.identity()
        : Matrix4.copy(fromCamera);
  }

  @override
  Future<void> prepare() async {
    await _base.prepare();
    if (_cachedProgram case final program?) {
      _program = program;
      return;
    }
    final pending = _pendingProgram ??= ui.FragmentProgram.fromAsset(
      waterRefractionAsset,
    );
    try {
      _program = _cachedProgram = await pending;
    } catch (_) {
      if (identical(pending, _pendingProgram)) _pendingProgram = null;
      rethrow;
    }
  }

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
  ) {
    final t = controller.value;
    return Stack(
      fit: StackFit.expand,
      children: [
        _base.createTransformWidget(
          context,
          currentWidget,
          nextWidget,
          controller,
          screenW,
          screenH,
        ),
        if (t > 0 && t < 1)
          _WaterFrame(
            program: _program,
            from: _from,
            to: _to,
            camera: _fromCamera,
            progress: t,
            options: options,
          ),
      ],
    );
  }
}

class _WaterFrame extends LeafRenderObjectWidget {
  final ui.FragmentProgram? program;
  final ui.Image? from, to;
  final Matrix4 camera;
  final double progress;
  final WaterRefractionEffectOptions options;
  const _WaterFrame({
    required this.program,
    required this.from,
    required this.to,
    required this.camera,
    required this.progress,
    required this.options,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderWater(this);
  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderWater renderObject,
  ) => renderObject.update(this);
}

class _RenderWater extends RenderBox {
  _WaterFrame _data;
  ui.FragmentShader? _shader;
  _RenderWater(this._data);

  void update(_WaterFrame data) {
    if (_data.program != data.program) {
      _shader?.dispose();
      _shader = null;
    }
    _data = data;
    markNeedsPaint();
  }

  @override
  void performLayout() => size = constraints.biggest;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (size.isEmpty) return;
    final from = _data.from, to = _data.to, program = _data.program;
    if (from == null || to == null || program == null) {
      throw StateError(
        'Prepare WaterRefraction and bind two live photo bitmaps before painting.',
      );
    }
    final shader = _shader ??= program.fragmentShader();
    final origin = effectOrigin(_data.options.origin).alongSize(size);
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, _data.progress)
      ..setFloat(3, from.width.toDouble())
      ..setFloat(4, from.height.toDouble())
      ..setFloat(5, to.width.toDouble())
      ..setFloat(6, to.height.toDouble())
      ..setFloat(7, _data.camera.storage[0])
      ..setFloat(8, _data.camera.storage[12])
      ..setFloat(9, _data.camera.storage[13])
      ..setFloat(10, origin.dx)
      ..setFloat(11, origin.dy)
      ..setFloat(12, _data.options.refractionStrength)
      ..setFloat(13, _data.options.waveFrequency)
      ..setFloat(14, _data.options.bandWidth)
      ..setImageSampler(0, from)
      ..setImageSampler(1, to);
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
    canvas.restore();
  }

  @override
  void dispose() {
    _shader?.dispose();
    super.dispose();
  }
}
