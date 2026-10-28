import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

const shaderRadialBlurAsset = 'shaders/radial_blur_experiment.frag';
Future<ui.FragmentProgram>? _pendingProgram;

ui.FragmentShader _createShader(ui.FragmentProgram program) =>
    program.fragmentShader();

/// Photo-only visual experiment, not a production RadialBlur replacement.
///
/// One shader retains all nine original rays at full prepared-photo resolution.
/// Sampling is bilinear and source-over is evaluated in floating point rather
/// than through nine separately rounded RGBA8 compositor surfaces. The caller
/// owns both images and must keep them alive until all effect views detach.
class ShaderRadialBlurEffect extends MediaSliderItemEffect {
  final RadialBlurEffectOptions options;
  final ui.FragmentShader Function(ui.FragmentProgram) _shaderFactory;
  ui.FragmentProgram? _program;
  ui.Image? _from, _to;
  Matrix4 _fromCamera = Matrix4.identity();

  ShaderRadialBlurEffect({
    this.options = const RadialBlurEffectOptions(),
    @visibleForTesting
    ui.FragmentShader Function(ui.FragmentProgram)? shaderFactory,
  }) : _shaderFactory = shaderFactory ?? _createShader;

  /// Borrows existing prepared pixels; no decode, snapshot or image clone.
  /// [fromCamera] matches PhotoMotion's positive uniform scale and translation
  /// about the viewport centre; rotation, skew and perspective are unsupported.
  /// Endpoint widgets remain the caller's live views, including their camera.
  void bindPhotos(ui.Image from, ui.Image to, {Matrix4? fromCamera}) {
    final camera = fromCamera == null
        ? Matrix4.identity()
        : Matrix4.copy(fromCamera);
    final matrix = camera.storage;
    if (!matrix[0].isFinite ||
        matrix[0] <= 0 ||
        matrix[0] != matrix[5] ||
        !matrix[12].isFinite ||
        !matrix[13].isFinite) {
      throw ArgumentError.value(
        fromCamera,
        'fromCamera',
        'Expected positive uniform scale and translation',
      );
    }
    for (var index = 0; index < matrix.length; index++) {
      if (index == 0 || index == 5 || index == 12 || index == 13) continue;
      final expected = index == 10 || index == 15 ? 1.0 : 0.0;
      if (matrix[index] != expected) {
        throw ArgumentError.value(
          fromCamera,
          'fromCamera',
          'Rotation, skew and perspective are unsupported',
        );
      }
    }
    _from = from;
    _to = to;
    _fromCamera = camera;
  }

  @override
  Future<void> prepare() async {
    final pending = _pendingProgram ??= ui.FragmentProgram.fromAsset(
      shaderRadialBlurAsset,
    );
    try {
      _program = await pending;
    } catch (_) {
      if (identical(_pendingProgram, pending)) _pendingProgram = null;
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
    final t = controller.value.clamp(0.0, 1.0);
    if (t == 0 || t == 1) {
      return ClipRect(
        child: ColoredBox(
          color: Colors.black,
          child: t == 0 ? currentWidget : nextWidget,
        ),
      );
    }
    final program = _program, from = _from, to = _to;
    if (program == null || from == null || to == null) {
      throw StateError(
        'Prepare ShaderRadialBlurEffect and bind two static prepared photos '
        'before rendering an intermediate phase.',
      );
    }
    return ClipRect(
      child: _RadialFrame(
        program: program,
        from: from,
        to: to,
        progress: t,
        options: options,
        fromCamera: _fromCamera,
        shaderFactory: _shaderFactory,
      ),
    );
  }
}

class _RadialFrame extends LeafRenderObjectWidget {
  final ui.FragmentProgram program;
  final ui.Image from, to;
  final double progress;
  final RadialBlurEffectOptions options;
  final Matrix4 fromCamera;
  final ui.FragmentShader Function(ui.FragmentProgram) shaderFactory;

  const _RadialFrame({
    required this.program,
    required this.from,
    required this.to,
    required this.progress,
    required this.options,
    required this.fromCamera,
    required this.shaderFactory,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderRadial(this);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderRadial renderObject,
  ) => renderObject.update(this);
}

class _RenderRadial extends RenderBox {
  _RadialFrame _data;
  ui.FragmentShader? _shader;
  _RenderRadial(this._data);

  void update(_RadialFrame data) {
    if (_data.program != data.program ||
        _data.shaderFactory != data.shaderFactory) {
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
    final t = _data.progress;
    final e = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final o = _data.options;
    final unit = math.min(size.width, size.height);
    // These are the production CreativeTransitionEffect RadialBlur formulas.
    final scale = o.origin == EffectOrigin.center
        ? 1 +
              .22 *
                  (o.angleDegrees / (0.2 * 180 / math.pi)) *
                  e *
                  math.max(size.width, size.height) /
                  math.max(1, unit)
        : 1 +
              4 *
                  math.sin(o.angleDegrees * math.pi / 360 * e).abs() *
                  math.sqrt(
                    size.width * size.width + size.height * size.height,
                  ) /
                  math.max(1, unit);
    final origin = switch (o.origin) {
      EffectOrigin.center => Alignment.center,
      EffectOrigin.topLeft => Alignment.topLeft,
      EffectOrigin.topRight => Alignment.topRight,
      EffectOrigin.bottomLeft => Alignment.bottomLeft,
      EffectOrigin.bottomRight => Alignment.bottomRight,
    }.alongSize(size);
    final from = _data.from, to = _data.to;
    final shader = _shader ??= _data.shaderFactory(_data.program);
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, Curves.easeInOutCubic.transform(t))
      ..setFloat(3, scale)
      ..setFloat(4, o.angleDegrees * math.pi / 180 * e)
      ..setFloat(5, origin.dx)
      ..setFloat(6, origin.dy)
      ..setFloat(7, from.width.toDouble())
      ..setFloat(8, from.height.toDouble())
      ..setFloat(9, to.width.toDouble())
      ..setFloat(10, to.height.toDouble())
      ..setFloat(11, _data.fromCamera.storage[0])
      ..setFloat(12, _data.fromCamera.storage[12])
      ..setFloat(13, _data.fromCamera.storage[13])
      ..setImageSampler(0, from, filterQuality: ui.FilterQuality.low)
      ..setImageSampler(1, to, filterQuality: ui.FilterQuality.low);
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
