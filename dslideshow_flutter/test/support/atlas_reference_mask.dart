// Frozen pre-optimization renderer for regression pixels.
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:dslideshow_flutter/src/effect/mosaic_schedule.dart';

const mosaicShaderAsset =
    'packages/dslideshow_flutter/src/effect/shaders/mosaic_mask.frag';
Future<ui.FragmentProgram>? _program;
Future<ui.FragmentProgram> loadMosaicProgram() =>
    _program ??= ui.FragmentProgram.fromAsset(mosaicShaderAsset);

/// A compositing mask, including Texture/RepaintBoundary descendants.
/// Canvas fallback batches all cells into one atlas draw on a grid-sized image.
class AtlasReferenceMask extends SingleChildRenderObjectWidget {
  final MosaicSchedule schedule;
  final double progress;
  final ui.FragmentProgram? program;

  const AtlasReferenceMask({
    super.key,
    required super.child,
    required this.schedule,
    required this.progress,
    this.program,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderAtlasReferenceMask(schedule, progress, program);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    (renderObject as _RenderAtlasReferenceMask).update(
      schedule,
      progress,
      program,
    );
  }
}

class _RenderAtlasReferenceMask extends RenderProxyBox {
  MosaicSchedule _schedule;
  double _progress;
  ui.FragmentProgram? _program;
  ui.FragmentShader? _fragment;
  ui.Image? _thresholds;
  ui.Image? _white;
  ui.Image? _mask;
  ui.Shader? _shader;
  Size? _shaderSize;
  bool _dirty = true;
  late Float32List _transforms;
  late Float32List _rects;
  late Int32List _colors;

  _RenderAtlasReferenceMask(this._schedule, this._progress, this._program) {
    _geometry();
  }

  void _geometry() {
    final count = _schedule.startTimes.length;
    _transforms = Float32List(count * 4);
    _rects = Float32List(count * 4);
    _colors = Int32List(count);
    for (var i = 0; i < count; i++) {
      _transforms[i * 4] = 1;
      _transforms[i * 4 + 2] = (i % _schedule.gridSize).toDouble();
      _transforms[i * 4 + 3] = (i ~/ _schedule.gridSize).toDouble();
      _rects[i * 4 + 2] = 1;
      _rects[i * 4 + 3] = 1;
    }
  }

  void update(
    MosaicSchedule schedule,
    double progress,
    ui.FragmentProgram? program,
  ) {
    if (!identical(schedule, _schedule) || program != _program) {
      _schedule = schedule;
      _program = program;
      if (identical(_shader, _fragment)) _shader = null;
      _fragment?.dispose();
      _fragment = null;
      _thresholds?.dispose();
      _thresholds = null;
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

  ui.Image _whitePixel() {
    final recorder = ui.PictureRecorder();
    Canvas(recorder).drawColor(Colors.white, BlendMode.src);
    final picture = recorder.endRecording();
    try {
      return picture.toImageSync(1, 1);
    } finally {
      picture.dispose();
    }
  }

  ui.Shader _canvasMask() {
    _white ??= _whitePixel();
    for (var i = 0; i < _colors.length; i++) {
      _colors[i] = (_schedule.alphaAt(i, _progress) << 24) | 0xffffff;
    }
    final recorder = ui.PictureRecorder();
    Canvas(recorder).drawRawAtlas(
      _white!,
      _transforms,
      _rects,
      _colors,
      BlendMode.modulate,
      null,
      Paint()..filterQuality = FilterQuality.none,
    );
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

  ui.Shader _gpuMask() {
    // Upload the small schedule in one atlas draw of opaque RGB cells.
    // This is done once; subsequent frames change only uniforms.
    if (_thresholds == null) {
      final recorder = ui.PictureRecorder();
      final bytes = _schedule.encodeThresholds();
      for (var i = 0; i < _schedule.startTimes.length; i++) {
        _colors[i] =
            0xff000000 |
            (bytes[i * 4] << 16) |
            (bytes[i * 4 + 1] << 8) |
            bytes[i * 4 + 2];
      }
      _white ??= _whitePixel();
      Canvas(recorder).drawRawAtlas(
        _white!,
        _transforms,
        _rects,
        _colors,
        BlendMode.modulate,
        null,
        Paint()..filterQuality = FilterQuality.none,
      );
      final picture = recorder.endRecording();
      try {
        _thresholds = picture.toImageSync(
          _schedule.gridSize,
          _schedule.gridSize,
        );
      } finally {
        picture.dispose();
      }
    }
    final shader = _fragment ??= _program!.fragmentShader();
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, _schedule.gridSize.toDouble())
      ..setFloat(3, _progress)
      ..setFloat(4, _schedule.fadeFraction)
      ..setImageSampler(0, _thresholds!);
    return shader;
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
      _shader = _program == null ? _canvasMask() : _gpuMask();
      _shaderSize = size;
      _dirty = false;
      if (old != null && !identical(old, _fragment)) old.dispose();
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
    if (!identical(_shader, _fragment)) _shader?.dispose();
    _fragment?.dispose();
    _mask?.dispose();
    _white?.dispose();
    _thresholds?.dispose();
    super.dispose();
  }
}
