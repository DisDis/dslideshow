import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'media_slider_item_effect.dart';

enum SoftWipeStyle { soft, lightSweep }

/// A feathered mask over the live outgoing layer, optionally lit at its edge.
class SoftWipeEffect extends MediaSliderItemEffect {
  final SoftWipeStyle style;

  SoftWipeEffect({this.style = SoftWipeStyle.soft});

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
      foregroundPainter: style == SoftWipeStyle.lightSweep
          ? _SweepLight(controller.value)
          : null,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: Colors.black, child: nextWidget),
          _WipeMask(
            progress: controller.value,
            child: ColoredBox(color: Colors.black, child: currentWidget),
          ),
        ],
      ),
    ),
  );
}

class _WipeMask extends SingleChildRenderObjectWidget {
  final double progress;

  const _WipeMask({required this.progress, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderWipeMask(progress);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderWipeMask renderObject,
  ) => renderObject.progress = progress;
}

class _RenderWipeMask extends RenderProxyBox {
  double _progress;
  ui.Gradient? _shader;
  Size? _shaderSize;

  _RenderWipeMask(this._progress);

  set progress(double value) {
    if (_progress == value) return;
    _progress = value;
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
    final feather = size.width * .12;
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

  _SweepLight(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || progress <= 0 || progress >= 1) return;
    final feather = size.width * .12;
    final front = -feather + (size.width + 2 * feather) * progress;
    final strength = math.sin(math.pi * progress) * .7;
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
      progress != oldDelegate.progress;
}
