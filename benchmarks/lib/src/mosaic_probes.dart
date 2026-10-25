import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum MosaicProbe {
  vertices,
  points;

  String effectName(Effect effect) => 'MosaicProbe-$name-${effect.name}';
}

class MosaicProbeEffect extends MediaSliderItemEffect {
  final MosaicProbe mode;
  final MosaicSchedule schedule;
  MosaicProbeEffect(
    this.mode, {
    required int grid,
    required bool binary,
    required int seed,
  }) : schedule = MosaicSchedule(
         gridSize: grid,
         fadeFraction: binary ? 0 : .3,
         seed: seed,
       );
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool current,
    double delta,
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
      nextWidget,
      MosaicProbeMask(
        schedule: schedule,
        progress: controller.value,
        mode: mode,
        child: currentWidget,
      ),
    ],
  );
}

/// A compositing mask, including Texture/RepaintBoundary descendants.
/// Unsimplified grid-sized masks for comparing point and triangle draws.
class MosaicProbeMask extends SingleChildRenderObjectWidget {
  final MosaicSchedule schedule;
  final double progress;
  final MosaicProbe mode;

  const MosaicProbeMask({
    super.key,
    required super.child,
    required this.schedule,
    required this.progress,
    required this.mode,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderMosaicProbeMask(schedule, progress, mode);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    (renderObject as _RenderMosaicProbeMask).update(schedule, progress, mode);
  }
}

class _RenderMosaicProbeMask extends RenderProxyBox {
  MosaicSchedule _schedule;
  double _progress;
  MosaicProbe _mode;

  ui.Image? _mask;
  ui.Shader? _shader;
  Size? _shaderSize;
  bool _dirty = true;
  late Int32List _colors, _vertexColors;
  late Float32List _positions, _points;
  final Int32List _counts = Int32List(256), _offsets = Int32List(256);

  _RenderMosaicProbeMask(this._schedule, this._progress, this._mode) {
    _geometry();
  }

  void _geometry() {
    final count = _schedule.startTimes.length;
    _colors = Int32List(count);
    _vertexColors = Int32List(count * 3);
    _positions = Float32List(count * 6);
    _points = Float32List(count * 2);
    for (var i = 0; i < count; i++) {
      final x = (i % _schedule.gridSize).toDouble();
      final y = (i ~/ _schedule.gridSize).toDouble();
      // One pixel centre per triangle on the grid-sized mask. No antialiasing.
      _positions.setRange(i * 6, i * 6 + 6, [x, y, x + 1, y, x + .5, y + 1]);
    }
  }

  void update(MosaicSchedule schedule, double progress, MosaicProbe mode) {
    if (!identical(schedule, _schedule) || mode != _mode) {
      _schedule = schedule;
      _mode = mode;
      _geometry();
      _dirty = true;
    }
    if (_progress != progress) {
      _progress = progress;
      _dirty = true;
    }
    if (_dirty) markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  ui.Shader _canvasMask() {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..isAntiAlias = false;
    for (var i = 0; i < _colors.length; i++) {
      _colors[i] = (_schedule.alphaAt(i, _progress) << 24) | 0xffffff;
    }
    switch (_mode) {
      case MosaicProbe.vertices:
        for (var i = 0; i < _colors.length; i++) {
          _vertexColors[i * 3] = _colors[i];
          _vertexColors[i * 3 + 1] = _colors[i];
          _vertexColors[i * 3 + 2] = _colors[i];
        }
        final vertices = ui.Vertices.raw(
          VertexMode.triangles,
          _positions,
          colors: _vertexColors,
        );
        try {
          canvas.drawVertices(
            vertices,
            BlendMode.modulate,
            paint..color = Colors.white,
          );
        } finally {
          vertices.dispose();
        }
      case MosaicProbe.points:
        _counts.fillRange(0, 256, 0);
        for (final color in _colors) {
          _counts[(color >> 24) & 255]++;
        }
        var offset = 0;
        for (var alpha = 0; alpha < 256; alpha++) {
          _offsets[alpha] = offset;
          offset += _counts[alpha] * 2;
        }
        for (var i = 0; i < _colors.length; i++) {
          final alpha = (_colors[i] >> 24) & 255;
          final position = _offsets[alpha];
          _points[position] = i % _schedule.gridSize + .5;
          _points[position + 1] = (i ~/ _schedule.gridSize) + .5;
          _offsets[alpha] += 2;
        }
        paint.strokeWidth = 1;
        for (var alpha = 1; alpha < 256; alpha++) {
          if (_counts[alpha] == 0) continue;
          paint.color = Color((alpha << 24) | 0xffffff);
          final end = _offsets[alpha];
          canvas.drawRawPoints(
            ui.PointMode.points,
            Float32List.sublistView(_points, end - _counts[alpha] * 2, end),
            paint,
          );
        }
    }
    final picture = recorder.endRecording();
    final old = _mask;
    try {
      _mask = picture.toImageSync(_schedule.gridSize, _schedule.gridSize);
    } finally {
      picture.dispose();
    }
    final result = ui.ImageShader(
      _mask!,
      TileMode.clamp,
      TileMode.clamp,
      (Matrix4.diagonal3Values(
        size.width / _schedule.gridSize,
        size.height / _schedule.gridSize,
        1,
      )..translateByDouble(-0.0001, -0.0001, 0, 1)).storage,
      filterQuality: FilterQuality.none,
    );
    old?.dispose();
    return result;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null || _progress >= 1 || size.isEmpty) {
      layer = null;
      return;
    }
    if (_progress <= 0) {
      layer = null;
      context.paintChild(child!, offset);
      return;
    }
    if (_dirty || _shaderSize != size) {
      final old = _shader;
      _shader = _canvasMask();
      _shaderSize = size;
      _dirty = false;
      old?.dispose();
    }
    final maskLayer = (layer ??= ShaderMaskLayer()) as ShaderMaskLayer;
    maskLayer
      ..shader = _shader
      ..maskRect = offset & size
      ..blendMode = BlendMode.dstIn;
    context.pushLayer(maskLayer, super.paint, offset);
  }

  @override
  void dispose() {
    layer = null;
    _shader?.dispose();
    _mask?.dispose();
    super.dispose();
  }
}
