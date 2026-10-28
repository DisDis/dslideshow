import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dslideshow_common/effects.dart';

import 'configured_fade_effect.dart';
import 'effect_geometry.dart';
import 'glass_effect.dart';
import 'media_slider_item_effect.dart';

import 'package:flutter/material.dart';

const photoGlassAsset =
    'packages/dslideshow_flutter/src/effect/shaders/photo_glass.frag';
const photoFilmDissolveAsset =
    'packages/dslideshow_flutter/src/effect/shaders/photo_film_dissolve.frag';
final _programs = <String, ui.FragmentProgram>{};
final _pendingPrograms = <String, Future<ui.FragmentProgram>>{};

ui.FragmentShader _createShader(ui.FragmentProgram program) =>
    program.fragmentShader();

/// Full-resolution photo Glass with live-widget composition for other media.
/// The caller owns both bitmap
/// handles until every effect view detaches. No snapshot or decode is created.
/// The shader retains every pane, its displacement, overscan and glint. It uses
/// Mitchell reconstruction, matching FilterQuality.high's cubic coefficients,
/// with floating-point composition instead of intermediate RGBA8 surfaces.
class PhotoGlassEffect extends _PreparedPhotoShaderEffect {
  final GlassEffectOptions options;

  PhotoGlassEffect({
    this.options = const GlassEffectOptions(),
    @visibleForTesting super.shaderFactory,
  }) : assert(options.paneCount > 0);

  @override
  String get _asset => photoGlassAsset;

  @override
  late final MediaSliderItemEffect _liveEffect = _glassLiveEffect(options);

  @override
  void _writeUniforms(ui.FragmentShader shader, Size size, double progress) {
    final e = math.sin(math.pi * progress);
    shader
      ..setFloat(9, (Curves.easeInOut.transform(progress) * 255).round() / 255)
      ..setFloat(10, e)
      ..setFloat(11, options.paneCount.toDouble())
      ..setFloat(12, options.refractionStrength)
      ..setFloat(13, options.glintStrength)
      ..setFloat(14, options.axis == EffectAxis.horizontal ? 1 : 0);
  }
}

/// Photo Film Dissolve with a live-widget fallback. Uses the configured blend curve
/// and piecewise sRGB transfer functions in one pass over two prepared photos.
/// Intermediate RGBA8 quantization in the original filter layers is omitted.
class PhotoFilmDissolveEffect extends _PreparedPhotoShaderEffect {
  final FadeEffectOptions options;

  PhotoFilmDissolveEffect({
    this.options = const FadeEffectOptions(style: FadeStyle.linearLight),
    @visibleForTesting super.shaderFactory,
  }) : assert(options.style == FadeStyle.linearLight);

  @override
  String get _asset => photoFilmDissolveAsset;

  @override
  late final MediaSliderItemEffect _liveEffect = ConfiguredFadeEffect(options);

  @override
  void _writeUniforms(ui.FragmentShader shader, Size size, double progress) {
    final curve = switch (options.blendCurve) {
      BlendCurve.linear => Curves.linear,
      BlendCurve.easeIn => Curves.easeIn,
      BlendCurve.easeOut => Curves.easeOutCubic,
      BlendCurve.easeInOut => Curves.easeInOutCubic,
    };
    shader.setFloat(9, curve.transform(progress));
  }
}

MediaSliderItemEffect _glassLiveEffect(GlassEffectOptions options) {
  final glass = GlassEffect(
    paneCount: options.paneCount,
    refractionStrength: options.refractionStrength,
    glintStrength: options.glintStrength,
  );
  // Matches the existing catalog's vertical base and horizontal DirectedEffect
  // mapping. The photo shader handles its own axes and never uses this wrapper.
  return options.axis == EffectAxis.vertical
      ? glass
      : DirectedEffect(glass, EffectDirection.up);
}

abstract class _PreparedPhotoShaderEffect extends MediaSliderItemEffect {
  final ui.FragmentShader Function(ui.FragmentProgram) _shaderFactory;
  ui.FragmentProgram? _program;

  _PreparedPhotoShaderEffect({
    ui.FragmentShader Function(ui.FragmentProgram)? shaderFactory,
  }) : _shaderFactory = shaderFactory ?? _createShader;

  String get _asset;
  MediaSliderItemEffect get _liveEffect;
  void _writeUniforms(ui.FragmentShader shader, Size size, double progress);

  @override
  Future<void> prepare() async {
    await _liveEffect.prepare();
    final asset = _asset;
    final prepared = _programs[asset];
    if (prepared != null) {
      _program = prepared;
      return;
    }
    final pending = _pendingPrograms.putIfAbsent(
      asset,
      () => ui.FragmentProgram.fromAsset(asset),
    );
    try {
      _program = _programs[asset] = await pending;
    } finally {
      if (identical(_pendingPrograms[asset], pending)) {
        _pendingPrograms.remove(asset);
      }
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final from = current.photo?.bitmap, to = next.photo?.bitmap;
    // GIF/video/special screens keep their live widgets and shared sessions.
    // Only callers with two stable prepared photos opt into texture sampling.
    if (from == null || to == null || !next.photo!.camera.isIdentity) {
      return _liveEffect.createTransformWidget(
        context,
        current,
        next,
        controller,
        screenW,
        screenH,
      );
    }
    final t = controller.value.clamp(0.0, 1.0);
    if (t == 0 || t == 1) {
      return ClipRect(
        child: ColoredBox(
          color: Colors.black,
          child: t == 0 ? current.view : next.view,
        ),
      );
    }
    final program = _program;
    if (program == null) {
      throw StateError('Prepare $runtimeType before rendering photo inputs.');
    }
    return ClipRect(
      child: _PhotoShaderFrame(
        program: program,
        from: from,
        to: to,
        fromCamera: current.photo!.camera,
        progress: t,
        writeUniforms: _writeUniforms,
        shaderFactory: _shaderFactory,
      ),
    );
  }
}

class _PhotoShaderFrame extends LeafRenderObjectWidget {
  final ui.FragmentProgram program;
  final ui.Image from, to;
  final PhotoCamera fromCamera;
  final double progress;
  final void Function(ui.FragmentShader, Size, double) writeUniforms;
  final ui.FragmentShader Function(ui.FragmentProgram) shaderFactory;

  const _PhotoShaderFrame({
    required this.program,
    required this.from,
    required this.to,
    required this.fromCamera,
    required this.progress,
    required this.writeUniforms,
    required this.shaderFactory,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderPhotoShader(this);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderPhotoShader renderObject,
  ) => renderObject.update(this);
}

class _RenderPhotoShader extends RenderBox {
  _PhotoShaderFrame _data;
  ui.FragmentShader? _shader;
  _RenderPhotoShader(this._data);

  void update(_PhotoShaderFrame data) {
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
    final from = _data.from, to = _data.to;
    final shader = _shader ??= _data.shaderFactory(_data.program);
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, from.width.toDouble())
      ..setFloat(3, from.height.toDouble())
      ..setFloat(4, to.width.toDouble())
      ..setFloat(5, to.height.toDouble())
      ..setFloat(6, _data.fromCamera.scale)
      ..setFloat(7, _data.fromCamera.dx)
      ..setFloat(8, _data.fromCamera.dy)
      ..setImageSampler(0, from, filterQuality: ui.FilterQuality.low)
      ..setImageSampler(1, to, filterQuality: ui.FilterQuality.low);
    _data.writeUniforms(shader, size, _data.progress);
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
