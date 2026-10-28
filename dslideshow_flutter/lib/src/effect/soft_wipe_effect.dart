import 'package:dslideshow_common/effects.dart';
export 'package:dslideshow_common/effects.dart' show SoftWipeStyle;

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'media_slider_item_effect.dart';

/// A feathered mask over the live outgoing layer, optionally lit at its edge.
class SoftWipeEffect extends MediaSliderItemEffect {
  final SoftWipeStyle style;
  final double? featherFraction;
  final double lightStrength;

  SoftWipeEffect({
    this.style = SoftWipeStyle.soft,
    this.featherFraction,
    this.lightStrength = 1,
  });

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
  ) => ClipRect(
    child: CustomPaint(
      foregroundPainter: switch (style) {
        SoftWipeStyle.soft => null,
        SoftWipeStyle.lightSweep => _SweepLight(
          controller.value,
          featherFraction ?? .12,
          lightStrength,
        ),
        SoftWipeStyle.neon => _NeonEdge(
          controller.value,
          featherFraction ?? .02,
          lightStrength,
        ),
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: Colors.black, child: nextWidget),
          _WipeMask(
            progress: controller.value,
            featherFraction:
                featherFraction ?? (style == SoftWipeStyle.neon ? .02 : .12),
            child: ColoredBox(color: Colors.black, child: currentWidget),
          ),
        ],
      ),
    ),
  );
}

class _WipeMask extends SingleChildRenderObjectWidget {
  final double progress;
  final double featherFraction;

  const _WipeMask({
    required this.progress,
    required this.featherFraction,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderWipeMask(progress, featherFraction);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderWipeMask renderObject,
  ) => renderObject.update(progress, featherFraction);
}

class _RenderWipeMask extends RenderProxyBox {
  double _progress;
  double _featherFraction;
  ui.Gradient? _shader;
  Size? _shaderSize;

  _RenderWipeMask(this._progress, this._featherFraction);

  void update(double progress, double featherFraction) {
    if (_progress == progress && _featherFraction == featherFraction) return;
    _progress = progress;
    _featherFraction = featherFraction;
    _clearShader();
    markNeedsPaint();
  }

  void _clearShader() {
    layer = null;
    _shader?.dispose();
    _shader = null;
    _shaderSize = null;
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
    if (_shaderSize != size) _clearShader();
    final feather = size.width * _featherFraction;
    final front = -feather + (size.width + 2 * feather) * _progress;
    final shader = _shader ??= ui.Gradient.linear(
      Offset(front - feather, 0),
      Offset(front + feather, 0),
      const [
        Color(0x00ffffff),
        Color(0x0bffffff),
        Color(0x28ffffff),
        Color(0x80ffffff),
        Color(0xd7ffffff),
        Color(0xf4ffffff),
        Color(0xffffffff),
      ],
      const [0, .15, .3, .5, .7, .85, 1],
    );
    _shaderSize = size;
    final mask = (layer ??= ShaderMaskLayer()) as ShaderMaskLayer;
    mask
      ..shader = shader
      ..maskRect = offset & size
      ..blendMode = BlendMode.dstIn;
    context.pushLayer(mask, super.paint, offset);
  }

  @override
  void dispose() {
    _clearShader();
    super.dispose();
  }
}

class _SweepLight extends CustomPainter {
  final double progress;

  final double featherFraction, lightStrength;
  _SweepLight(this.progress, this.featherFraction, this.lightStrength);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || progress <= 0 || progress >= 1) return;
    final feather = size.width * featherFraction;
    final front = -feather + (size.width + 2 * feather) * progress;
    final strength = (math.sin(math.pi * progress) * .7 * lightStrength).clamp(
      0.0,
      1.0,
    );
    final shader = ui.Gradient.linear(
      Offset(front - feather, 0),
      Offset(front + feather, 0),
      [
        const Color(0x00fff1ce),
        const Color(0xffffe8b0).withValues(alpha: strength * .3),
        Colors.white.withValues(alpha: strength),
        const Color(0xffffe8b0).withValues(alpha: strength * .3),
        const Color(0x00fff1ce),
      ],
      const [0, .3, .5, .7, 1],
    );
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
    shader.dispose();
  }

  @override
  bool shouldRepaint(_SweepLight oldDelegate) =>
      progress != oldDelegate.progress ||
      featherFraction != oldDelegate.featherFraction ||
      lightStrength != oldDelegate.lightStrength;
}

class _NeonEdge extends CustomPainter {
  final double progress;
  final double featherFraction, lightStrength;
  _NeonEdge(this.progress, this.featherFraction, this.lightStrength);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || progress <= 0 || progress >= 1) return;
    final feather = size.width * featherFraction;
    final front = -feather + (size.width + 2 * feather) * progress;
    final glow = size.width * .045;
    final strength = (math.sin(math.pi * progress) * lightStrength).clamp(
      0.0,
      1.0,
    );
    final shader = ui.Gradient.linear(
      Offset(front - glow, 0),
      Offset(front + glow, 0),
      [
        const Color(0x0000eaff),
        const Color(0xff00eaff).withValues(alpha: strength * .3),
        const Color(0xff00eaff).withValues(alpha: strength * .8),
        Colors.white.withValues(alpha: strength),
        const Color(0xffff28d7).withValues(alpha: strength * .8),
        const Color(0xffff28d7).withValues(alpha: strength * .3),
        const Color(0x00ff28d7),
      ],
      const [0, .3, .47, .5, .53, .7, 1],
    );
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
    shader.dispose();
  }

  @override
  bool shouldRepaint(_NeonEdge oldDelegate) =>
      progress != oldDelegate.progress ||
      featherFraction != oldDelegate.featherFraction ||
      lightStrength != oldDelegate.lightStrength;
}
