import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:config_app/features/config/presentation/wigdgets/argb_color_field.dart';
import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/features/config/presentation/wigdgets/effect_label.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

enum _DurationMode { global, custom }

enum _BulkAction { enableAll, disableAll, inheritAll }

enum _Filter { all, enabled, modified }

enum _Field {
  angle,
  axis,
  bandWidth,
  blendCurve,
  blurFraction,
  blurTarget,
  borderColor,
  borderWidth,
  cellsAcross,
  circularDirection,
  clipAmount,
  color,
  colorShiftFraction,
  corner,
  count,
  decoration,
  direction,
  driftFraction,
  duration,
  edge,
  edgeStyle,
  edgeWidth,
  emberColor,
  enableOpacity,
  fadeFraction,
  fadeOutShare,
  featherFraction,
  foldWidth,
  frameEnabled,
  gain,
  glintStrength,
  glowColor,
  glowStrength,
  grid,
  holdFraction,
  innerRadiusRatio,
  lightStrength,
  lineAxis,
  maxScale,
  maxSigma,
  mode,
  motionCurve,
  noiseScale,
  noiseStrength,
  operation,
  order,
  origin,
  outgoingScale,
  paperColor,
  pattern,
  perspectiveStrength,
  pointCount,
  radius,
  randomness,
  refractionStrength,
  rotationDegrees,
  rotationSense,
  roughness,
  scale,
  sectorCount,
  shadowIntensity,
  shadowStrength,
  shape,
  side,
  softness,
  splitPosition,
  springStrength,
  staggerFraction,
  startAngleDegrees,
  startScale,
  strength,
  style,
  tiltDegrees,
  trackingStrength,
  trailColor,
  trailCount,
  trailStrength,
  warmColor,
  waveAmplitude,
  waveCount,
  waveFrequency,
  waveIntensity,
  zoomOutScale,
}

class EffectsEditorPage extends StatefulWidget {
  const EffectsEditorPage({
    super.key,
    required this.config,
    this.registerDraft,
    this.previewImages,
  });
  final SlideShowConfig config;
  final RegisterUnsavedDraft? registerDraft;
  final List<ImageProvider>? previewImages;
  @override
  State<EffectsEditorPage> createState() => _EffectsEditorPageState();
}

class _EffectsEditorPageState extends State<EffectsEditorPage> {
  final _revision = ValueNotifier(0);
  final _search = TextEditingController();
  late final TextEditingController _global;
  final _controllers = <EffectType, Map<_Field, TextEditingController>>{};
  final _invalid = <EffectType, Set<_Field>>{};
  final _customDurations = <EffectType, int>{};
  final _selectedPresets = <EffectType, EffectPresetId>{};
  bool _invalidGlobal = false;
  EffectType _selected = EffectType.fade;
  _Filter _filter = _Filter.all;
  EffectGroup? _group;
  EffectsConfig get _config => widget.config.effects;
  EffectConfig get _entry => _config.get(_selected);
  bool get _hasInvalid =>
      _invalidGlobal ||
      _invalid.values.any((v) => v.isNotEmpty) ||
      _config.validate().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _global = TextEditingController(text: _config.defaultDurationMs.toString());
  }

  @override
  void dispose() {
    _revision.dispose();
    _search.dispose();
    _global.dispose();
    for (final fields in _controllers.values) {
      for (final controller in fields.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _changed() {
    if (!mounted) return;
    setState(() {});
    _revision.value++;
  }

  void _put(EffectType type, EffectConfig entry) {
    widget.config.effects = _config.put(type, entry);
    _changed();
  }

  void _options(EffectOptions options) =>
      _put(_selected, _entry.copyWith(options: options));
  int? _milliseconds(String text) {
    final ms = int.tryParse(text.trim(), radix: 10);
    return ms != null && ms >= 1 && ms <= 3600000 ? ms : null;
  }

  String _time(EffectConfig entry) =>
      '${entry.options.durationMs == 0 ? '${context.localizations.effects_inherit} · ' : ''}${context.localizations.effects_milliseconds(_config.durationFor(entry.options))}';

  String _summary(EffectType type, EffectConfig entry) {
    if (entry.validate(type).isNotEmpty) {
      return context.localizations.effects_invalid;
    }
    final options = entry.options;
    final parts = <String>[_time(entry)];
    if (options !=
        defaultEffectOptions(type).withDuration(options.durationMs)) {
      final countLabel = context.localizations.effects_count;
      final details = switch (options) {
        MosaicEffectOptions(
          :final gridSize,
          :final fadeFraction,
          :final direction,
        ) =>
          '$gridSize × $gridSize · ${(fadeFraction * 100).round()}% · ${_enumLabel(direction)}',
        SlideEffectOptions(:final mode, :final direction) =>
          '${_enumLabel(mode)} · ${_enumLabel(direction)}',
        RevealMaskEffectOptions(:final shape) => _enumLabel(shape),
        SoftWipeEffectOptions(:final style) => _enumLabel(style),
        FlipEffectOptions(:final axis) => _enumLabel(axis),
        RotateEffectOptions(:final edge, :final angleDegrees) =>
          '${_enumLabel(edge)} · $angleDegrees°',
        FadeThroughColorEffectOptions(:final color) =>
          '#${color.toRadixString(16).padLeft(8, '0')}',
        BlindsEffectOptions(:final stripCount) ||
        SliceEffectOptions(:final stripCount) => '$countLabel: $stripCount',
        GlassEffectOptions(:final paneCount) => '$countLabel: $paneCount',
        PanelWipeEffectOptions(:final panelCount) => '$countLabel: $panelCount',
        LouverEffectOptions(:final slatCount) => '$countLabel: $slatCount',
        _ => null,
      };
      if (details != null) parts.add(details);
    }
    final matches = effectPresetsFor(type)
        .where((preset) => preset.options == options.withDuration(0));
    if (matches.isNotEmpty &&
        options !=
            defaultEffectOptions(type).withDuration(options.durationMs)) {
      parts.add(_presetLabel(matches.first.id));
    }
    return parts.join('\n');
  }

  Widget _number(
    _Field field,
    String label,
    String initial,
    num? Function(String) parse,
    ValueChanged<num> apply, {
    TextInputType keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
  }) {
    final type = _selected;
    final controller = (_controllers[type] ??= {}).putIfAbsent(
      field,
      () => TextEditingController(text: initial),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        key: ValueKey('effect-${type.name}-${field.name}'),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: (text) => parse(text ?? '') == null
            ? context.localizations.special_invalid_number
            : null,
        onChanged: (text) {
          final value = parse(text);
          if (value == null) {
            (_invalid[type] ??= {}).add(field);
            _changed();
          } else {
            _invalid[type]?.remove(field);
            apply(value);
          }
        },
      ),
    );
  }

  String _enumLabel(Enum value) {
    final l = context.localizations;
    return <Enum, String>{
      FadeStyle.plain: l.effect_choice_FadeStyle_plain,
      FadeStyle.linearLight: l.effect_choice_FadeStyle_linearLight,
      FadeStyle.blur: l.effect_choice_FadeStyle_blur,
      FadeStyle.throughColor: l.effect_choice_FadeStyle_throughColor,
      BlendCurve.linear: l.effect_choice_BlendCurve_linear,
      BlendCurve.easeIn: l.effect_choice_BlendCurve_easeIn,
      BlendCurve.easeOut: l.effect_choice_BlendCurve_easeOut,
      BlendCurve.easeInOut: l.effect_choice_BlendCurve_easeInOut,
      BlurTarget.outgoing: l.effect_choice_BlurTarget_outgoing,
      BlurTarget.incoming: l.effect_choice_BlurTarget_incoming,
      BlurTarget.both: l.effect_choice_BlurTarget_both,
      DepthMode.recedeStill: l.effect_choice_DepthMode_recedeStill,
      DepthMode.recedeSlide: l.effect_choice_DepthMode_recedeSlide,
      DepthMode.approach: l.effect_choice_DepthMode_approach,
      ZoomMode.over: l.effect_choice_ZoomMode_over,
      ZoomMode.cross: l.effect_choice_ZoomMode_cross,
      WipeEdgeStyle.hard: l.effect_choice_WipeEdgeStyle_hard,
      WipeEdgeStyle.soft: l.effect_choice_WipeEdgeStyle_soft,
      WipeEdgeStyle.lightSweep: l.effect_choice_WipeEdgeStyle_lightSweep,
      WipeEdgeStyle.neon: l.effect_choice_WipeEdgeStyle_neon,
      RevealOperation.revealIncoming:
          l.effect_choice_RevealOperation_revealIncoming,
      RevealOperation.hideOutgoing:
          l.effect_choice_RevealOperation_hideOutgoing,
      SliceMode.slide: l.effect_choice_SliceMode_slide,
      SliceMode.reveal: l.effect_choice_SliceMode_reveal,
      StripPattern.alternating: l.effect_choice_StripPattern_alternating,
      StripPattern.sameDirection: l.effect_choice_StripPattern_sameDirection,
      SequenceOrder.forward: l.effect_choice_SequenceOrder_forward,
      SequenceOrder.backward: l.effect_choice_SequenceOrder_backward,
      RotationSense.forward: l.effect_choice_RotationSense_forward,
      RotationSense.backward: l.effect_choice_RotationSense_backward,
      CircularDirection.clockwise: l.effect_choice_CircularDirection_clockwise,
      CircularDirection.counterclockwise:
          l.effect_choice_CircularDirection_counterclockwise,
      LumaOrder.brightFirst: l.effect_choice_LumaOrder_brightFirst,
      LumaOrder.darkFirst: l.effect_choice_LumaOrder_darkFirst,
      CellShape.hexagon: l.effect_choice_CellShape_hexagon,
      CellShape.circle: l.effect_choice_CellShape_circle,
      CellShape.diamond: l.effect_choice_CellShape_diamond,
      CellShape.square: l.effect_choice_CellShape_square,
      MirrorSide.leading: l.effect_choice_MirrorSide_leading,
      MirrorSide.trailing: l.effect_choice_MirrorSide_trailing,
      SlideDecoration.none: l.effect_choice_SlideDecoration_none,
      SlideDecoration.filmPerforation:
          l.effect_choice_SlideDecoration_filmPerforation,
      RevealShape.rectangle: l.effect_choice_RevealShape_rectangle,
      RevealShape.star: l.effect_choice_RevealShape_star,
      RevealShape.clock: l.effect_choice_RevealShape_clock,
      EffectDirection.left: l.effects_left,
      EffectDirection.right: l.effects_right,
      EffectDirection.up: l.effects_up,
      EffectDirection.down: l.effects_down,
      MosaicDirection.random: l.effects_random,
      MosaicDirection.topLeft: l.effects_topLeft,
      MosaicDirection.topRight: l.effects_topRight,
      MosaicDirection.bottomLeft: l.effects_bottomLeft,
      MosaicDirection.bottomRight: l.effects_bottomRight,
      EffectAxis.horizontal: l.effects_horizontal,
      EffectAxis.vertical: l.effects_vertical,
      EffectOrigin.center: l.effects_center,
      EffectOrigin.topLeft: l.effects_topLeft,
      EffectOrigin.topRight: l.effects_topRight,
      EffectOrigin.bottomLeft: l.effects_bottomLeft,
      EffectOrigin.bottomRight: l.effects_bottomRight,
      SlideMode.push: l.effects_push,
      SlideMode.cover: l.effects_cover,
      SlideMode.reveal: l.effects_reveal,
      RevealShape.wipe: l.effects_wipe,
      RevealShape.curtain: l.effects_curtain,
      RevealShape.diagonal: l.effects_diagonal,
      RevealShape.iris: l.effects_iris,
      SoftWipeStyle.soft: l.effects_soft,
      SoftWipeStyle.lightSweep: l.effects_lightSweep,
      SoftWipeStyle.neon: l.effects_neon,
      RotationEdge.top: l.effects_top,
      RotationEdge.bottom: l.effects_bottom,
      EffectGroup.fades: l.effects_fades,
      EffectGroup.movement: l.effects_movement,
      EffectGroup.masks: l.effects_masks,
      EffectGroup.geometric: l.effects_geometric,
      EffectGroup.cinematic: l.effects_cinematic,
      EffectGroup.creative: l.effects_creative,
    }[value]!;
  }

  Widget _enum<T extends Enum>(
    _Field field,
    String label,
    T value,
    List<T> values,
    ValueChanged<T> change,
  ) => Padding(
    key: ValueKey(field),
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: DropdownButtonFormField<T>(
      key: ValueKey('effect-${_selected.name}-${field.name}-${value.name}'),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final item in values)
          DropdownMenuItem(value: item, child: Text(_enumLabel(item))),
      ],
      onChanged: (value) {
        if (value != null) change(value);
      },
    ),
  );
  void _applyPreset(EffectPreset preset) {
    _selectedPresets[_selected] = preset.id;
    final fields = _controllers[_selected];
    final removed = <TextEditingController>[];
    if (fields != null) {
      for (final field in fields.keys.toList()) {
        if (field != _Field.duration) removed.add(fields.remove(field)!);
      }
    }
    _invalid[_selected]?.removeWhere((field) => field != _Field.duration);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final controller in removed) {
        controller.dispose();
      }
    });
    _options(preset.options.withDuration(_entry.options.durationMs));
  }

  String _presetLabel(EffectPresetId id) {
    final l = context.localizations;
    return switch (id) {
      EffectPresetId.burnAlpha => l.effect_preset_burnAlpha,
      EffectPresetId.foldMotion => l.effect_preset_foldMotion,
      EffectPresetId.glow => l.effect_preset_glow,
      EffectPresetId.kaleidoscope => l.effect_preset_kaleidoscope,
      EffectPresetId.tvPower => l.effect_preset_tvPower,
      EffectPresetId.springMotion => l.effect_preset_springMotion,
      EffectPresetId.shapeDissolve => l.effect_preset_shapeDissolve,
      EffectPresetId.vhsDamage => l.effect_preset_vhsDamage,
      EffectPresetId.radialBlur => l.effect_preset_radialBlur,
      EffectPresetId.phosphor => l.effect_preset_phosphor,
      EffectPresetId.filmDissolve => l.effect_preset_filmDissolve,
      EffectPresetId.frame => l.effect_preset_frame,
      EffectPresetId.louver => l.effect_preset_louver,
      EffectPresetId.mirror => l.effect_preset_mirror,
      EffectPresetId.clockWipe => l.effect_preset_clockWipe,
      EffectPresetId.split => l.effect_preset_split,
      EffectPresetId.panelWipe => l.effect_preset_panelWipe,
      EffectPresetId.stretch => l.effect_preset_stretch,
      EffectPresetId.starWipe => l.effect_preset_starWipe,
      EffectPresetId.lightLeak => l.effect_preset_lightLeak,
      EffectPresetId.filmRoll => l.effect_preset_filmRoll,
      EffectPresetId.crossZoom => l.effect_preset_crossZoom,
      EffectPresetId.whip => l.effect_preset_whip,
      EffectPresetId.glass => l.effect_preset_glass,
      EffectPresetId.softWipe => l.effect_preset_softWipe,
      EffectPresetId.slice => l.effect_preset_slice,
      EffectPresetId.lumaFade => l.effect_preset_lumaFade,
      EffectPresetId.pagePeel => l.effect_preset_pagePeel,
      EffectPresetId.noiseDissolve => l.effect_preset_noiseDissolve,
      EffectPresetId.rippleReveal => l.effect_preset_rippleReveal,
      EffectPresetId.waterRefraction => l.effect_preset_waterRefraction,
      EffectPresetId.cube => l.effect_preset_cube,
      EffectPresetId.accordion => l.effect_preset_accordion,
      EffectPresetId.backgroundToForeground =>
        l.effect_preset_backgroundToForeground,
      EffectPresetId.foregroundToBackground =>
        l.effect_preset_foregroundToBackground,
      EffectPresetId.depth => l.effect_preset_depth,
      EffectPresetId.parallax => l.effect_preset_parallax,
      EffectPresetId.stack => l.effect_preset_stack,
      EffectPresetId.tablet => l.effect_preset_tablet,
      EffectPresetId.zoomOut => l.effect_preset_zoomOut,
      EffectPresetId.fade => l.effect_preset_fade,
      EffectPresetId.mosaic => l.effect_preset_mosaic,
      EffectPresetId.liquidMorph => l.effect_preset_liquidMorph,
      EffectPresetId.blinds => l.effect_preset_blinds,
      EffectPresetId.blurFade => l.effect_preset_blurFade,
      EffectPresetId.zoomOver => l.effect_preset_zoomOver,
      EffectPresetId.slide => l.effect_preset_slide,
      EffectPresetId.revealMask => l.effect_preset_revealMask,
      EffectPresetId.fadeThroughColor => l.effect_preset_fadeThroughColor,
      EffectPresetId.flip => l.effect_preset_flip,
      EffectPresetId.rotate => l.effect_preset_rotate,
      EffectPresetId.softWipeLightSweep => l.effect_preset_softWipeLightSweep,
      EffectPresetId.softWipeNeon => l.effect_preset_softWipeNeon,
      EffectPresetId.fadeThroughWhite => l.effect_preset_fadeThroughWhite,
      EffectPresetId.flipVertical => l.effect_preset_flipVertical,
      EffectPresetId.rotateBottom => l.effect_preset_rotateBottom,
      EffectPresetId.mosaicBinary => l.effect_preset_mosaicBinary,
      EffectPresetId.mosaicTopLeft => l.effect_preset_mosaicTopLeft,
      EffectPresetId.mosaicTopRight => l.effect_preset_mosaicTopRight,
      EffectPresetId.mosaicBottomLeft => l.effect_preset_mosaicBottomLeft,
      EffectPresetId.mosaicBottomRight => l.effect_preset_mosaicBottomRight,
      EffectPresetId.slidePushRight => l.effect_preset_slidePushRight,
      EffectPresetId.slidePushUp => l.effect_preset_slidePushUp,
      EffectPresetId.slidePushDown => l.effect_preset_slidePushDown,
      EffectPresetId.slideCoverLeft => l.effect_preset_slideCoverLeft,
      EffectPresetId.slideCoverRight => l.effect_preset_slideCoverRight,
      EffectPresetId.slideCoverUp => l.effect_preset_slideCoverUp,
      EffectPresetId.slideCoverDown => l.effect_preset_slideCoverDown,
      EffectPresetId.slideRevealLeft => l.effect_preset_slideRevealLeft,
      EffectPresetId.slideRevealRight => l.effect_preset_slideRevealRight,
      EffectPresetId.slideRevealUp => l.effect_preset_slideRevealUp,
      EffectPresetId.slideRevealDown => l.effect_preset_slideRevealDown,
      EffectPresetId.wipeRight => l.effect_preset_wipeRight,
      EffectPresetId.wipeUp => l.effect_preset_wipeUp,
      EffectPresetId.wipeDown => l.effect_preset_wipeDown,
      EffectPresetId.curtainHorizontal => l.effect_preset_curtainHorizontal,
      EffectPresetId.curtainVertical => l.effect_preset_curtainVertical,
      EffectPresetId.diagonalTopRight => l.effect_preset_diagonalTopRight,
      EffectPresetId.diagonalBottomLeft => l.effect_preset_diagonalBottomLeft,
      EffectPresetId.diagonalBottomRight => l.effect_preset_diagonalBottomRight,
      EffectPresetId.diagonalTopLeft => l.effect_preset_diagonalTopLeft,
      EffectPresetId.irisCenter => l.effect_preset_irisCenter,
    };
  }

  Widget _presets() {
    final presets = effectPresetsFor(_selected).toList();
    final matches = presets.where(
      (preset) => preset.options == _entry.options.withDuration(0),
    );
    final preferred = matches.where(
      (preset) => preset.id == _selectedPresets[_selected],
    );
    final selected = preferred.isNotEmpty
        ? preferred.first.id
        : matches.isEmpty
        ? null
        : matches.first.id;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<EffectPresetId>(
        key: ValueKey(
          'effect-presets-${_selected.name}-${_entry.options.hashCode}-$selected',
        ),
        initialValue: selected,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: context.localizations.effects_preset,
        ),
        hint: Text(context.localizations.effects_custom_preset),
        items: [
          for (final preset in presets)
            DropdownMenuItem(
              value: preset.id,
              child: Text(_presetLabel(preset.id)),
            ),
        ],
        onChanged: (id) {
          if (id != null) {
            _applyPreset(presets.firstWhere((preset) => preset.id == id));
          }
        },
      ),
    );
  }

  Widget _specificOptions() {
    final l = context.localizations, options = _entry.options;
    return _settingsLayout([
      if (options is MosaicEffectOptions) ...[
        _bounded(
          _Field.grid,
          l.effect_parameter_gridSize,
          options.gridSize,
          100,
          200,
          (v) => _options(options.copyWith(gridSize: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.fadeFraction,
          l.effect_parameter_fadeFraction,
          options.fadeFraction,
          0,
          1,
          (v) => _options(options.copyWith(fadeFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          MosaicDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        if (options.direction != MosaicDirection.random)
          _bounded(
            _Field.randomness,
            l.effect_parameter_randomness,
            options.randomness,
            0,
            1,
            (v) => _options(options.copyWith(randomness: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
        Wrap(
          spacing: 8,
          children: [
            for (final size in [100, 150, 200])
              ActionChip(
                label: Text('$size × $size'),
                onPressed: () {
                  _controllers[_selected]?[_Field.grid]?.text = '$size';
                  _invalid[_selected]?.remove(_Field.grid);
                  _options(options.copyWith(gridSize: size));
                },
              ),
          ],
        ),
      ],
      if (options is SlideEffectOptions) ...[
        _enum(
          _Field.mode,
          l.effect_parameter_mode,
          options.mode,
          SlideMode.values,
          (v) => _options(options.copyWith(mode: v)),
        ),
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _enum(
          _Field.motionCurve,
          l.effect_parameter_motionCurve,
          options.motionCurve,
          BlendCurve.values,
          (v) => _options(options.copyWith(motionCurve: v)),
        ),
        _bounded(
          _Field.blurFraction,
          l.effect_parameter_blurFraction,
          options.blurFraction,
          0,
          0.08,
          (v) => _options(options.copyWith(blurFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _enum(
          _Field.decoration,
          l.effect_parameter_decoration,
          options.decoration,
          SlideDecoration.values,
          (v) => _options(options.copyWith(decoration: v)),
        ),
        if (options.decoration == SlideDecoration.filmPerforation)
          _bounded(
            _Field.edgeWidth,
            l.effect_parameter_edgeWidth,
            options.edgeWidth,
            0.02,
            0.1,
            (v) => _options(options.copyWith(edgeWidth: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
        if (options.mode != SlideMode.push)
          _bounded(
            _Field.tiltDegrees,
            l.effect_parameter_tiltDegrees,
            options.tiltDegrees,
            -12,
            12,
            (v) => _options(options.copyWith(tiltDegrees: v.toDouble())),
            integer: false,
            percent: false,
            step: 1,
          ),
        if (options.mode != SlideMode.push)
          _bounded(
            _Field.shadowStrength,
            l.effect_parameter_shadowStrength,
            options.shadowStrength,
            0,
            0.6,
            (v) => _options(options.copyWith(shadowStrength: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
      ],
      if (options is RevealMaskEffectOptions) ...[
        _enum(
          _Field.shape,
          l.effect_parameter_shape,
          options.shape,
          RevealShape.values,
          (v) => _options(
            options.copyWith(
              shape: v,
              origin:
                  v == RevealShape.diagonal &&
                      options.origin == EffectOrigin.center
                  ? EffectOrigin.topLeft
                  : options.origin,
            ),
          ),
        ),
        if (options.shape == RevealShape.wipe)
          _enum(
            _Field.direction,
            l.effect_parameter_direction,
            options.direction,
            EffectDirection.values,
            (v) => _options(options.copyWith(direction: v)),
          ),
        if (options.shape == RevealShape.curtain)
          _enum(
            _Field.axis,
            l.effect_parameter_axis,
            options.axis,
            EffectAxis.values,
            (v) => _options(options.copyWith(axis: v)),
          ),
        if (options.shape != RevealShape.wipe &&
            options.shape != RevealShape.curtain)
          _enum(
            _Field.origin,
            l.effect_parameter_origin,
            options.origin,
            options.shape == RevealShape.diagonal
                ? EffectOrigin.values
                      .where((v) => v != EffectOrigin.center)
                      .toList()
                : EffectOrigin.values,
            (v) => _options(options.copyWith(origin: v)),
          ),
        _enum(
          _Field.operation,
          l.effect_parameter_operation,
          options.operation,
          RevealOperation.values,
          (v) => _options(options.copyWith(operation: v)),
        ),
        if (options.shape == RevealShape.wipe)
          _enum(
            _Field.edgeStyle,
            l.effect_parameter_edgeStyle,
            options.edgeStyle,
            WipeEdgeStyle.values,
            (v) => _options(options.copyWith(edgeStyle: v)),
          ),
        if (options.shape == RevealShape.wipe &&
            options.edgeStyle != WipeEdgeStyle.hard)
          Column(
            key: const ValueKey(_Field.featherFraction),
            children: [
              SwitchListTile(
                title: Text(l.effects_automatic),
                value: options.featherFraction == null,
                onChanged: (v) => _options(
                  options.copyWith(
                    featherFraction: v
                        ? null
                        : (options.edgeStyle == WipeEdgeStyle.neon ? .02 : .12),
                  ),
                ),
              ),
              if (options.featherFraction != null)
                _bounded(
                  _Field.featherFraction,
                  l.effect_parameter_featherFraction,
                  options.featherFraction!,
                  0.005,
                  0.3,
                  (v) =>
                      _options(options.copyWith(featherFraction: v.toDouble())),
                  percent: true,
                ),
            ],
          ),
        if (options.shape == RevealShape.wipe &&
            (options.edgeStyle == WipeEdgeStyle.lightSweep ||
                options.edgeStyle == WipeEdgeStyle.neon))
          _bounded(
            _Field.lightStrength,
            l.effect_parameter_lightStrength,
            options.lightStrength,
            0,
            1.5,
            (v) => _options(options.copyWith(lightStrength: v.toDouble())),
            integer: false,
            percent: false,
            step: 1,
          ),
        if (options.shape == RevealShape.rectangle)
          SwitchListTile(
            key: const ValueKey(_Field.frameEnabled),
            title: Text(l.effect_parameter_frameEnabled),
            value: options.frameEnabled,
            onChanged: (v) => _options(options.copyWith(frameEnabled: v)),
          ),
        if (options.shape == RevealShape.rectangle && options.frameEnabled)
          _bounded(
            _Field.borderWidth,
            l.effect_parameter_borderWidth,
            options.borderWidth,
            0,
            0.02,
            (v) => _options(options.copyWith(borderWidth: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
        if (options.shape == RevealShape.rectangle && options.frameEnabled)
          _color(
            _Field.borderColor,
            l.effect_parameter_borderColor,
            options.borderColor,
            (v) => _options(options.copyWith(borderColor: v)),
          ),
        if (options.shape == RevealShape.rectangle && options.frameEnabled)
          _bounded(
            _Field.shadowStrength,
            l.effect_parameter_shadowStrength,
            options.shadowStrength,
            0,
            1,
            (v) => _options(options.copyWith(shadowStrength: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
        if (options.shape == RevealShape.star)
          _bounded(
            _Field.pointCount,
            l.effect_parameter_pointCount,
            options.pointCount,
            3,
            12,
            (v) => _options(options.copyWith(pointCount: v.toInt())),
            integer: true,
            percent: false,
            step: 1,
          ),
        if (options.shape == RevealShape.star)
          _bounded(
            _Field.innerRadiusRatio,
            l.effect_parameter_innerRadiusRatio,
            options.innerRadiusRatio,
            0.2,
            0.8,
            (v) => _options(options.copyWith(innerRadiusRatio: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
        if (options.shape == RevealShape.star)
          _bounded(
            _Field.rotationDegrees,
            l.effect_parameter_rotationDegrees,
            options.rotationDegrees,
            0,
            359.999,
            (v) => _options(options.copyWith(rotationDegrees: v.toDouble())),
            integer: false,
            percent: false,
            step: 1,
          ),
        if (options.shape == RevealShape.clock)
          _bounded(
            _Field.startAngleDegrees,
            l.effect_parameter_startAngleDegrees,
            options.startAngleDegrees,
            0,
            359.999,
            (v) => _options(options.copyWith(startAngleDegrees: v.toDouble())),
            integer: false,
            percent: false,
            step: 1,
          ),
        if (options.shape == RevealShape.clock)
          _enum(
            _Field.circularDirection,
            l.effect_parameter_circularDirection,
            options.circularDirection,
            CircularDirection.values,
            (v) => _options(options.copyWith(circularDirection: v)),
          ),
      ],
      if (options is FadeThroughColorEffectOptions) ...[
        _color(
          _Field.color,
          l.effect_parameter_color,
          options.color,
          (v) => _options(options.copyWith(color: v)),
        ),
      ],
      if (options is SoftWipeEffectOptions) ...[
        _enum(
          _Field.style,
          l.effect_parameter_style,
          options.style,
          SoftWipeStyle.values,
          (v) => _options(options.copyWith(style: v)),
        ),
      ],
      if (options is FlipEffectOptions) ...[
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _enum(
          _Field.rotationSense,
          l.effect_parameter_rotationSense,
          options.rotationSense,
          RotationSense.values,
          (v) => _options(options.copyWith(rotationSense: v)),
        ),
        _bounded(
          _Field.perspectiveStrength,
          l.effect_parameter_perspectiveStrength,
          options.perspectiveStrength,
          0,
          1.25,
          (v) => _options(options.copyWith(perspectiveStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is RotateEffectOptions) ...[
        _enum(
          _Field.edge,
          l.effect_parameter_edge,
          options.edge,
          RotationEdge.values,
          (v) => _options(options.copyWith(edge: v)),
        ),
        _bounded(
          _Field.angle,
          l.effect_parameter_angleDegrees,
          options.angleDegrees,
          0,
          90,
          (v) => _options(options.copyWith(angleDegrees: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
      ],
      if (options is BlindsEffectOptions) ...[
        _bounded(
          _Field.count,
          l.effect_parameter_stripCount,
          options.stripCount,
          1,
          32,
          (v) => _options(options.copyWith(stripCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _enum(
          _Field.order,
          l.effect_parameter_order,
          options.order,
          SequenceOrder.values,
          (v) => _options(options.copyWith(order: v)),
        ),
        _bounded(
          _Field.staggerFraction,
          l.effect_parameter_staggerFraction,
          options.staggerFraction,
          0,
          0.8,
          (v) => _options(options.copyWith(staggerFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
      ],
      if (options is SliceEffectOptions) ...[
        _bounded(
          _Field.count,
          l.effect_parameter_stripCount,
          options.stripCount,
          1,
          32,
          (v) => _options(options.copyWith(stripCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.mode,
          l.effect_parameter_mode,
          options.mode,
          SliceMode.values,
          (v) => _options(options.copyWith(mode: v)),
        ),
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _bounded(
          _Field.staggerFraction,
          l.effect_parameter_staggerFraction,
          options.staggerFraction,
          0,
          0.8,
          (v) => _options(options.copyWith(staggerFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _enum(
          _Field.pattern,
          l.effect_parameter_pattern,
          options.pattern,
          StripPattern.values,
          (v) => _options(options.copyWith(pattern: v)),
        ),
      ],
      if (options is GlassEffectOptions) ...[
        _bounded(
          _Field.count,
          l.effect_parameter_paneCount,
          options.paneCount,
          1,
          32,
          (v) => _options(options.copyWith(paneCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _bounded(
          _Field.refractionStrength,
          l.effect_parameter_refractionStrength,
          options.refractionStrength,
          0,
          2,
          (v) => _options(options.copyWith(refractionStrength: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.glintStrength,
          l.effect_parameter_glintStrength,
          options.glintStrength,
          0,
          2,
          (v) => _options(options.copyWith(glintStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is PanelWipeEffectOptions) ...[
        _bounded(
          _Field.count,
          l.effect_parameter_panelCount,
          options.panelCount,
          1,
          32,
          (v) => _options(options.copyWith(panelCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
      ],
      if (options is LouverEffectOptions) ...[
        _bounded(
          _Field.count,
          l.effect_parameter_slatCount,
          options.slatCount,
          1,
          32,
          (v) => _options(options.copyWith(slatCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _bounded(
          _Field.staggerFraction,
          l.effect_parameter_staggerFraction,
          options.staggerFraction,
          0,
          0.8,
          (v) => _options(options.copyWith(staggerFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.shadowIntensity,
          l.effect_parameter_shadowIntensity,
          options.shadowIntensity,
          0,
          1,
          (v) => _options(options.copyWith(shadowIntensity: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _enum(
          _Field.rotationSense,
          l.effect_parameter_rotationSense,
          options.rotationSense,
          RotationSense.values,
          (v) => _options(options.copyWith(rotationSense: v)),
        ),
      ],
      if (options is FadeEffectOptions) ...[
        _enum(
          _Field.style,
          l.effect_parameter_style,
          options.style,
          FadeStyle.values,
          (v) => _options(options.copyWith(style: v)),
        ),
        _enum(
          _Field.blendCurve,
          l.effect_parameter_blendCurve,
          options.blendCurve,
          BlendCurve.values,
          (v) => _options(options.copyWith(blendCurve: v)),
        ),
        if (options.style == FadeStyle.blur)
          _bounded(
            _Field.maxSigma,
            l.effect_parameter_maxSigma,
            options.maxSigma,
            0,
            30,
            (v) => _options(options.copyWith(maxSigma: v.toDouble())),
            integer: false,
            percent: false,
            step: 1,
          ),
        if (options.style == FadeStyle.blur)
          _enum(
            _Field.blurTarget,
            l.effect_parameter_blurTarget,
            options.blurTarget,
            BlurTarget.values,
            (v) => _options(options.copyWith(blurTarget: v)),
          ),
        if (options.style == FadeStyle.throughColor)
          _color(
            _Field.color,
            l.effect_parameter_color,
            options.color,
            (v) => _options(options.copyWith(color: v)),
          ),
        if (options.style == FadeStyle.throughColor)
          _bounded(
            _Field.holdFraction,
            l.effect_parameter_holdFraction,
            options.holdFraction,
            0,
            0.4,
            (v) => _options(options.copyWith(holdFraction: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
        if (options.style == FadeStyle.throughColor)
          _bounded(
            _Field.fadeOutShare,
            l.effect_parameter_fadeOutShare,
            options.fadeOutShare,
            0.2,
            0.8,
            (v) => _options(options.copyWith(fadeOutShare: v.toDouble())),
            integer: false,
            percent: true,
            step: 1,
          ),
      ],
      if (options is LumaFadeEffectOptions) ...[
        _enum(
          _Field.order,
          l.effect_parameter_order,
          options.order,
          LumaOrder.values,
          (v) => _options(options.copyWith(order: v)),
        ),
        _bounded(
          _Field.softness,
          l.effect_parameter_softness,
          options.softness,
          0.02,
          0.5,
          (v) => _options(options.copyWith(softness: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is NoiseDissolveEffectOptions) ...[
        _bounded(
          _Field.noiseScale,
          l.effect_parameter_noiseScale,
          options.noiseScale,
          8,
          80,
          (v) => _options(options.copyWith(noiseScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.softness,
          l.effect_parameter_softness,
          options.softness,
          0.01,
          0.2,
          (v) => _options(options.copyWith(softness: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is RippleRevealEffectOptions) ...[
        _enum(
          _Field.origin,
          l.effects_wave_origin,
          options.origin,
          EffectOrigin.values,
          (v) => _options(options.copyWith(origin: v)),
        ),
        _bounded(
          _Field.waveAmplitude,
          l.effect_parameter_waveAmplitude,
          options.waveAmplitude,
          0,
          0.08,
          (v) => _options(options.copyWith(waveAmplitude: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.waveFrequency,
          l.effect_parameter_waveFrequency,
          options.waveFrequency,
          20,
          140,
          (v) => _options(options.copyWith(waveFrequency: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.softness,
          l.effect_parameter_softness,
          options.softness,
          0.005,
          0.08,
          (v) => _options(options.copyWith(softness: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is WaterRefractionEffectOptions) ...[
        _enum(
          _Field.origin,
          l.effects_wave_origin,
          options.origin,
          EffectOrigin.values,
          (v) => _options(options.copyWith(origin: v)),
        ),
        _bounded(
          _Field.refractionStrength,
          l.effect_parameter_refractionStrength,
          options.refractionStrength,
          0,
          0.025,
          (v) => _options(options.copyWith(refractionStrength: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.waveFrequency,
          l.effect_parameter_waveFrequency,
          options.waveFrequency,
          40,
          140,
          (v) => _options(options.copyWith(waveFrequency: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.bandWidth,
          l.effect_parameter_bandWidth,
          options.bandWidth,
          0.5,
          1.5,
          (v) => _options(options.copyWith(bandWidth: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is LiquidMorphEffectOptions) ...[
        _bounded(
          _Field.waveCount,
          l.effect_parameter_waveCount,
          options.waveCount,
          3,
          32,
          (v) => _options(options.copyWith(waveCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.waveIntensity,
          l.effect_parameter_waveIntensity,
          options.waveIntensity,
          0,
          60,
          (v) => _options(options.copyWith(waveIntensity: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.outgoingScale,
          l.effect_parameter_outgoingScale,
          options.outgoingScale,
          1,
          1.3,
          (v) => _options(options.copyWith(outgoingScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.origin,
          l.effect_parameter_origin,
          options.origin,
          EffectOrigin.values,
          (v) => _options(options.copyWith(origin: v)),
        ),
      ],
      if (options is CubeEffectOptions) ...[
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _bounded(
          _Field.shadowIntensity,
          l.effect_parameter_shadowIntensity,
          options.shadowIntensity,
          0,
          1,
          (v) => _options(options.copyWith(shadowIntensity: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.perspectiveStrength,
          l.effect_parameter_perspectiveStrength,
          options.perspectiveStrength,
          0,
          1.25,
          (v) => _options(options.copyWith(perspectiveStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is AccordionEffectOptions) ...[
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _bounded(
          _Field.shadowIntensity,
          l.effect_parameter_shadowIntensity,
          options.shadowIntensity,
          0,
          1,
          (v) => _options(options.copyWith(shadowIntensity: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
      ],
      if (options is DepthEffectOptions) ...[
        _enum(
          _Field.mode,
          l.effect_parameter_mode,
          options.mode,
          DepthMode.values,
          (v) => _options(options.copyWith(mode: v)),
        ),
        _bounded(
          _Field.scale,
          l.effect_parameter_scale,
          options.scale,
          0.2,
          1,
          (v) => _options(options.copyWith(scale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.shadowIntensity,
          l.effect_parameter_shadowIntensity,
          options.shadowIntensity,
          0,
          1,
          (v) => _options(options.copyWith(shadowIntensity: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
      ],
      if (options is ParallaxEffectOptions) ...[
        _bounded(
          _Field.clipAmount,
          l.effect_parameter_clipAmount,
          options.clipAmount,
          0,
          400,
          (v) => _options(options.copyWith(clipAmount: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
      ],
      if (options is TabletEffectOptions) ...[
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _bounded(
          _Field.tiltDegrees,
          l.effect_parameter_tiltDegrees,
          options.tiltDegrees,
          0,
          70,
          (v) => _options(options.copyWith(tiltDegrees: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.perspectiveStrength,
          l.effect_parameter_perspectiveStrength,
          options.perspectiveStrength,
          0,
          1.25,
          (v) => _options(options.copyWith(perspectiveStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is ZoomOutEffectOptions) ...[
        _bounded(
          _Field.zoomOutScale,
          l.effect_parameter_zoomOutScale,
          options.zoomOutScale,
          0.5,
          1,
          (v) => _options(options.copyWith(zoomOutScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        SwitchListTile(
          key: const ValueKey(_Field.enableOpacity),
          title: Text(l.effect_parameter_enableOpacity),
          value: options.enableOpacity,
          onChanged: (v) => _options(options.copyWith(enableOpacity: v)),
        ),
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
      ],
      if (options is ZoomOverEffectOptions) ...[
        _enum(
          _Field.mode,
          l.effect_parameter_mode,
          options.mode,
          ZoomMode.values,
          (v) => _options(options.copyWith(mode: v)),
        ),
        _bounded(
          _Field.startScale,
          l.effect_parameter_startScale,
          options.startScale,
          1,
          2,
          (v) => _options(options.copyWith(startScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.outgoingScale,
          l.effect_parameter_outgoingScale,
          options.outgoingScale,
          0.7,
          2,
          (v) => _options(options.copyWith(outgoingScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.blurFraction,
          l.effect_parameter_blurFraction,
          options.blurFraction,
          0,
          0.03,
          (v) => _options(options.copyWith(blurFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _enum(
          _Field.origin,
          l.effect_parameter_origin,
          options.origin,
          EffectOrigin.values,
          (v) => _options(options.copyWith(origin: v)),
        ),
      ],
      if (options is PagePeelEffectOptions) ...[
        _enum(
          _Field.corner,
          l.effect_parameter_corner,
          options.corner,
          EffectOrigin.values.where((v) => v != EffectOrigin.center).toList(),
          (v) => _options(options.copyWith(corner: v)),
        ),
        _bounded(
          _Field.foldWidth,
          l.effect_parameter_foldWidth,
          options.foldWidth,
          0.04,
          0.25,
          (v) => _options(options.copyWith(foldWidth: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _color(
          _Field.paperColor,
          l.effect_parameter_paperColor,
          options.paperColor,
          (v) => _options(options.copyWith(paperColor: v)),
        ),
        _bounded(
          _Field.shadowStrength,
          l.effect_parameter_shadowStrength,
          options.shadowStrength,
          0,
          1,
          (v) => _options(options.copyWith(shadowStrength: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
      ],
      if (options is SplitEffectOptions) ...[
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _bounded(
          _Field.splitPosition,
          l.effect_parameter_splitPosition,
          options.splitPosition,
          0.2,
          0.8,
          (v) => _options(options.copyWith(splitPosition: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
      ],
      if (options is StretchEffectOptions) ...[
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _bounded(
          _Field.maxScale,
          l.effect_parameter_maxScale,
          options.maxScale,
          1,
          4,
          (v) => _options(options.copyWith(maxScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is MirrorEffectOptions) ...[
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _enum(
          _Field.side,
          l.effect_parameter_side,
          options.side,
          MirrorSide.values,
          (v) => _options(options.copyWith(side: v)),
        ),
        _bounded(
          _Field.strength,
          l.effect_parameter_strength,
          options.strength,
          0,
          1,
          (v) => _options(options.copyWith(strength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is LightLeakEffectOptions) ...[
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _bounded(
          _Field.strength,
          l.effect_parameter_strength,
          options.strength,
          0,
          1.5,
          (v) => _options(options.copyWith(strength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.radius,
          l.effect_parameter_radius,
          options.radius,
          0.3,
          1.2,
          (v) => _options(options.copyWith(radius: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _color(
          _Field.warmColor,
          l.effect_parameter_warmColor,
          options.warmColor,
          (v) => _options(options.copyWith(warmColor: v)),
        ),
      ],
      if (options is BurnAlphaEffectOptions) ...[
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _bounded(
          _Field.roughness,
          l.effect_parameter_roughness,
          options.roughness,
          0,
          0.12,
          (v) => _options(options.copyWith(roughness: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.edgeWidth,
          l.effect_parameter_edgeWidth,
          options.edgeWidth,
          0.01,
          0.12,
          (v) => _options(options.copyWith(edgeWidth: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _color(
          _Field.emberColor,
          l.effect_parameter_emberColor,
          options.emberColor,
          (v) => _options(options.copyWith(emberColor: v)),
        ),
      ],
      if (options is FoldMotionEffectOptions) ...[
        _enum(
          _Field.axis,
          l.effect_parameter_axis,
          options.axis,
          EffectAxis.values,
          (v) => _options(options.copyWith(axis: v)),
        ),
        _bounded(
          _Field.shadowIntensity,
          l.effect_parameter_shadowIntensity,
          options.shadowIntensity,
          0,
          1,
          (v) => _options(options.copyWith(shadowIntensity: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.perspectiveStrength,
          l.effect_parameter_perspectiveStrength,
          options.perspectiveStrength,
          0,
          1.25,
          (v) => _options(options.copyWith(perspectiveStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is GlowEffectOptions) ...[
        _bounded(
          _Field.strength,
          l.effect_parameter_strength,
          options.strength,
          0,
          1,
          (v) => _options(options.copyWith(strength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.radius,
          l.effect_parameter_radius,
          options.radius,
          0,
          0.08,
          (v) => _options(options.copyWith(radius: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.gain,
          l.effect_parameter_gain,
          options.gain,
          1,
          3,
          (v) => _options(options.copyWith(gain: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is KaleidoscopeEffectOptions) ...[
        _bounded(
          _Field.sectorCount,
          l.effect_parameter_sectorCount,
          options.sectorCount,
          2,
          12,
          (v) => _options(options.copyWith(sectorCount: v.toInt())),
          integer: true,
          percent: false,
          step: 2,
        ),
        _bounded(
          _Field.rotationDegrees,
          l.effect_parameter_rotationDegrees,
          options.rotationDegrees,
          0,
          180,
          (v) => _options(options.copyWith(rotationDegrees: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.origin,
          l.effect_parameter_origin,
          options.origin,
          EffectOrigin.values,
          (v) => _options(options.copyWith(origin: v)),
        ),
      ],
      if (options is TvPowerEffectOptions) ...[
        _enum(
          _Field.lineAxis,
          l.effect_parameter_lineAxis,
          options.lineAxis,
          EffectAxis.values,
          (v) => _options(options.copyWith(lineAxis: v)),
        ),
        _bounded(
          _Field.glowStrength,
          l.effect_parameter_glowStrength,
          options.glowStrength,
          0,
          1.5,
          (v) => _options(options.copyWith(glowStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _color(
          _Field.glowColor,
          l.effect_parameter_glowColor,
          options.glowColor,
          (v) => _options(options.copyWith(glowColor: v)),
        ),
      ],
      if (options is SpringMotionEffectOptions) ...[
        _enum(
          _Field.direction,
          l.effect_parameter_direction,
          options.direction,
          EffectDirection.values,
          (v) => _options(options.copyWith(direction: v)),
        ),
        _bounded(
          _Field.springStrength,
          l.effect_parameter_springStrength,
          options.springStrength,
          0,
          1.5,
          (v) => _options(options.copyWith(springStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.startScale,
          l.effect_parameter_startScale,
          options.startScale,
          0.6,
          1,
          (v) => _options(options.copyWith(startScale: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is ShapeDissolveEffectOptions) ...[
        _enum(
          _Field.shape,
          l.effect_parameter_shape,
          options.shape,
          CellShape.values,
          (v) => _options(options.copyWith(shape: v)),
        ),
        _bounded(
          _Field.cellsAcross,
          l.effect_parameter_cellsAcross,
          options.cellsAcross,
          6,
          32,
          (v) => _options(options.copyWith(cellsAcross: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.staggerFraction,
          l.effect_parameter_staggerFraction,
          options.staggerFraction,
          0,
          0.6,
          (v) => _options(options.copyWith(staggerFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
      ],
      if (options is VhsDamageEffectOptions) ...[
        _bounded(
          _Field.colorShiftFraction,
          l.effect_parameter_colorShiftFraction,
          options.colorShiftFraction,
          0,
          0.06,
          (v) => _options(options.copyWith(colorShiftFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.trackingStrength,
          l.effect_parameter_trackingStrength,
          options.trackingStrength,
          0,
          2,
          (v) => _options(options.copyWith(trackingStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.noiseStrength,
          l.effect_parameter_noiseStrength,
          options.noiseStrength,
          0,
          2,
          (v) => _options(options.copyWith(noiseStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
      ],
      if (options is RadialBlurEffectOptions) ...[
        _bounded(
          _Field.angle,
          l.effect_parameter_angleDegrees,
          options.angleDegrees,
          0,
          20,
          (v) => _options(options.copyWith(angleDegrees: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _enum(
          _Field.origin,
          l.effect_parameter_origin,
          options.origin,
          EffectOrigin.values,
          (v) => _options(options.copyWith(origin: v)),
        ),
      ],
      if (options is PhosphorEffectOptions) ...[
        _bounded(
          _Field.trailCount,
          l.effect_parameter_trailCount,
          options.trailCount,
          1,
          6,
          (v) => _options(options.copyWith(trailCount: v.toInt())),
          integer: true,
          percent: false,
          step: 1,
        ),
        _bounded(
          _Field.driftFraction,
          l.effect_parameter_driftFraction,
          options.driftFraction,
          0,
          0.5,
          (v) => _options(options.copyWith(driftFraction: v.toDouble())),
          integer: false,
          percent: true,
          step: 1,
        ),
        _bounded(
          _Field.trailStrength,
          l.effect_parameter_trailStrength,
          options.trailStrength,
          0,
          1.5,
          (v) => _options(options.copyWith(trailStrength: v.toDouble())),
          integer: false,
          percent: false,
          step: 1,
        ),
        _color(
          _Field.trailColor,
          l.effect_parameter_trailColor,
          options.trailColor,
          (v) => _options(options.copyWith(trailColor: v)),
        ),
      ],
    ]);
  }

  Widget _settingsLayout(List<Widget> controls) {
    const advancedFields = {
      _Field.motionCurve,
      _Field.edgeWidth,
      _Field.shadowStrength,
      _Field.borderWidth,
      _Field.borderColor,
      _Field.featherFraction,
      _Field.lightStrength,
    };
    bool advanced(Widget widget) =>
        widget.key is ValueKey<_Field> &&
        advancedFields.contains((widget.key! as ValueKey<_Field>).value);
    final extra = controls.length > 5
        ? controls.where(advanced).toList()
        : <Widget>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final control in controls)
          if (!extra.contains(control)) control,
        if (extra.isNotEmpty)
          ExpansionTile(
            key: PageStorageKey('effect-advanced-${_selected.name}'),
            title: Text(context.localizations.effects_advanced),
            initiallyExpanded:
                _invalid[_selected]?.any(advancedFields.contains) ?? false,
            maintainState: true,
            children: extra,
          ),
      ],
    );
  }

  Widget _bounded(
    _Field field,
    String label,
    num value,
    num minimum,
    num maximum,
    ValueChanged<num> change, {
    bool integer = false,
    bool percent = false,
    int step = 1,
  }) {
    final factor = percent ? 100 : 1;
    String display(num v) => integer
        ? v.toInt().toString()
        : double.parse((v * factor).toStringAsFixed(5)).toString();
    num? parse(String text) {
      final v = integer
          ? int.tryParse(text.trim())
          : double.tryParse(text.trim().replaceAll(',', '.'));
      if (v == null || !v.isFinite) return null;
      final actual = v / factor;
      if (actual < minimum ||
          actual > maximum ||
          (integer && actual.toInt() % step != 0)) {
        return null;
      }
      return actual;
    }

    return Column(
      key: ValueKey(field),
      children: [
        _number(
          field,
          '$label${percent ? ' (%)' : ''} [${display(minimum)}–${display(maximum)}]',
          display(value),
          parse,
          change,
        ),
        Slider(
          key: ValueKey('effect-${_selected.name}-${field.name}-slider'),
          value: value.toDouble().clamp(minimum.toDouble(), maximum.toDouble()),
          min: minimum.toDouble(),
          max: maximum.toDouble(),
          divisions: integer ? ((maximum - minimum) / step).round() : 100,
          onChanged: (v) {
            final actual = integer
                ? (minimum + ((v - minimum) / step).round() * step)
                : v;
            _controllers[_selected]?[field]?.text = display(actual);
            _invalid[_selected]?.remove(field);
            change(actual);
          },
        ),
      ],
    );
  }

  Widget _color(
    _Field field,
    String label,
    int value,
    ValueChanged<int> change,
  ) => Padding(
    key: ValueKey(field),
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: ArgbColorField(
      fieldKey: ValueKey('effect-${_selected.name}-${field.name}'),
      label: label,
      value: value,
      controller: (_controllers[_selected] ??= {}).putIfAbsent(
        field,
        () => TextEditingController(
          text: value.toRadixString(16).padLeft(8, '0'),
        ),
      ),
      onValidityChanged: (valid) {
        if (valid) {
          _invalid[_selected]?.remove(field);
        } else {
          (_invalid[_selected] ??= {}).add(field);
        }
        _changed();
      },
      onChanged: change,
    ),
  );
  void _reset() {
    _invalid.remove(_selected);
    _customDurations.remove(_selected);
    _selectedPresets.remove(_selected);
    final fields = _controllers.remove(_selected);
    // Text fields detach during this rebuild; dispose their controllers after it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final c in fields?.values ?? <TextEditingController>[]) {
        c.dispose();
      }
    });
    _put(
      _selected,
      EffectConfig(
        enabled: _entry.enabled,
        options: defaultEffectOptions(_selected),
      ),
    );
  }

  Widget _form() {
    final l = context.localizations, entry = _entry;
    if (entry.validate(_selected).isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(l.effects_invalid),
            TextButton.icon(
              key: const ValueKey('effect-reset'),
              onPressed: _reset,
              icon: const Icon(Icons.restore),
              label: Text(l.effects_reset),
            ),
          ],
        ),
      );
    }
    final inherit = entry.options.durationMs == 0;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(effectLabel(context, Effect(_selected))),
            subtitle: Text(l.effects_enable),
            value: entry.enabled,
            onChanged: (v) => _put(_selected, entry.copyWith(enabled: v)),
          ),
          SegmentedButton<_DurationMode>(
            key: const ValueKey('effect-duration-mode'),
            segments: [
              ButtonSegment(
                value: _DurationMode.global,
                label: Text(l.effects_inherit),
              ),
              ButtonSegment(
                value: _DurationMode.custom,
                label: Text(l.effects_custom),
              ),
            ],
            selected: {inherit ? _DurationMode.global : _DurationMode.custom},
            onSelectionChanged: (selection) {
              if (selection.single == _DurationMode.global) {
                _customDurations[_selected] = entry.options.durationMs;
                _invalid[_selected]?.remove(_Field.duration);
                _options(entry.options.withDuration(0));
              } else {
                final ms =
                    _customDurations[_selected] ??
                    _config.safeDefaultDurationMs;
                _controllers[_selected]?[_Field.duration]?.text = ms.toString();
                _options(entry.options.withDuration(ms));
              }
            },
          ),
          if (inherit)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                key: ValueKey(
                  'effect-inherited-${_selected.name}-${_config.safeDefaultDurationMs}',
                ),
                initialValue: _config.safeDefaultDurationMs.toString(),
                enabled: false,
                decoration: InputDecoration(
                  labelText: '${l.effects_inherit} · ${l.effects_duration}',
                ),
              ),
            )
          else
            _number(
              _Field.duration,
              l.effects_duration,
              entry.options.durationMs.toString(),
              _milliseconds,
              (v) => _options(entry.options.withDuration(v.toInt())),
              keyboardType: TextInputType.number,
            ),
          _presets(),
          _specificOptions(),
          TextButton.icon(
            key: const ValueKey('effect-reset'),
            onPressed: _reset,
            icon: const Icon(Icons.restore),
            label: Text(l.effects_reset),
          ),
        ],
      ),
    );
  }

  Widget _details() => PreviewEditorLayout(
    key: ValueKey(_selected),
    hasInvalidInput: _hasInvalid,
    previewBuilder: (_) => SlideshowPreview(
      config: widget.config,
      selectedEffect: _entry.validate(_selected).isEmpty
          ? Effect.fromConfig(_selected, _entry)
          : Effect(_selected),
      images: widget.previewImages,
    ),
    help: context.localizations.preview_environment_help,
    editor: _form(),
  );
  Widget _catalog(bool wide) {
    final l = context.localizations;
    final query = _search.text.trim().toLowerCase();
    final effects = Effect.values.where((effect) {
      final entry = _config.get(effect.type);
      return (_group == null || _group == effect.group) &&
          (_filter != _Filter.enabled || entry.enabled) &&
          (_filter != _Filter.modified ||
              entry.options != defaultEffectOptions(effect.type)) &&
          (query.isEmpty ||
              effectLabel(context, effect).toLowerCase().contains(query) ||
              effect.name.toLowerCase().contains(query));
    }).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            key: const ValueKey('effects-search'),
            controller: _search,
            decoration: InputDecoration(
              labelText: l.effects_search,
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (_) => _changed(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<_Filter>(
            key: const ValueKey('effects-filter'),
            initialValue: _filter,
            isExpanded: true,
            items: [
              DropdownMenuItem(value: _Filter.all, child: Text(l.effects_all)),
              DropdownMenuItem(
                value: _Filter.enabled,
                child: Text(l.effects_enabled),
              ),
              DropdownMenuItem(
                value: _Filter.modified,
                child: Text(l.effects_modified),
              ),
            ],
            onChanged: (v) {
              if (v != null) {
                _filter = v;
                _changed();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: DropdownButtonFormField<EffectGroup>(
            key: const ValueKey('effects-group'),
            initialValue: _group,
            isExpanded: true,
            decoration: InputDecoration(labelText: l.effects_group),
            items: [
              DropdownMenuItem(value: null, child: Text(l.effects_all)),
              for (final group in EffectGroup.values)
                DropdownMenuItem(value: group, child: Text(_enumLabel(group))),
            ],
            onChanged: (v) {
              _group = v;
              _changed();
            },
          ),
        ),
        Expanded(
          child: effects.isEmpty
              ? Center(child: Text(l.effects_no_results))
              : ListView.builder(
                  itemCount: effects.length,
                  itemBuilder: (context, index) {
                    final effect = effects[index],
                        entry = _config.get(effect.type);
                    return ListTile(
                      key: ValueKey('effect-row-${effect.type.name}'),
                      selected: wide && effect.type == _selected,
                      title: Text(effectLabel(context, effect)),
                      subtitle: Text(_summary(effect.type, entry)),
                      leading: Switch(
                        key: ValueKey('effect-enabled-${effect.type.name}'),
                        value: entry.enabled,
                        onChanged: (v) =>
                            _put(effect.type, entry.copyWith(enabled: v)),
                      ),
                      onTap: () async {
                        _selected = effect.type;
                        _changed();
                        if (!wide) {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(effectLabel(context, effect)),
                                ),
                                body: ValueListenableBuilder(
                                  valueListenable: _revision,
                                  builder: (context, _, child) =>
                                      DraftEditorForm(
                                        confirmInvalidOnBack: false,
                                        hasInvalidInput: () => _hasInvalid,
                                        onChanged: _changed,
                                        child: _details(),
                                      ),
                                ),
                              ),
                            ),
                          );
                          _changed();
                        }
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _bulk(_BulkAction action) {
    for (final effect in Effect.values) {
      final entry = _config.get(effect.type);
      if (action == _BulkAction.inheritAll && entry.options.durationMs > 0) {
        _customDurations[effect.type] = entry.options.durationMs;
      }
      widget.config.effects = _config.put(effect.type, switch (action) {
        _BulkAction.enableAll => entry.copyWith(enabled: true),
        _BulkAction.disableAll => entry.copyWith(enabled: false),
        _BulkAction.inheritAll => entry.copyWith(
          options: entry.options.withDuration(0),
        ),
      });
      if (action == _BulkAction.inheritAll) {
        _invalid[effect.type]?.remove(_Field.duration);
      }
    }
    _changed();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.effects_title),
        actions: [
          PopupMenuButton<_BulkAction>(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: _BulkAction.enableAll,
                child: Text(l.effects_enable_all),
              ),
              PopupMenuItem(
                value: _BulkAction.disableAll,
                child: Text(l.effects_disable_all),
              ),
              PopupMenuItem(
                value: _BulkAction.inheritAll,
                child: Text(l.effects_inherit_all),
              ),
            ],
            onSelected: _bulk,
          ),
        ],
      ),
      body: DraftEditorForm(
        registerDraft: widget.registerDraft,
        hasInvalidInput: () => _hasInvalid,
        onChanged: _changed,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                key: const ValueKey('effects-global-duration'),
                controller: _global,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l.effects_global_duration,
                ),
                validator: (v) => _milliseconds(v ?? '') == null
                    ? l.special_invalid_number
                    : null,
                onChanged: (text) {
                  final ms = _milliseconds(text);
                  _invalidGlobal = ms == null;
                  if (ms != null) {
                    widget.config.effects = _config.copyWith(
                      defaultDurationMs: ms,
                    );
                  }
                  _changed();
                },
              ),
            ),
            Text(
              '${l.effects_enabled}: ${_config.playable.length} / ${Effect.values.length}',
            ),
            if (_config.playable.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(l.effects_empty),
              ),
            if (_config.validate().isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(l.effects_invalid),
                    TextButton(
                      onPressed: () {
                        final oldControllers = _controllers.values
                            .expand((fields) => fields.values)
                            .toList();
                        _controllers.clear();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          for (final c in oldControllers) {
                            c.dispose();
                          }
                        });
                        widget.config.effects = EffectsConfig();
                        _global.text = _config.defaultDurationMs.toString();
                        _invalidGlobal = false;
                        _invalid.clear();
                        _customDurations.clear();
                        _changed();
                      },
                      child: Text(l.effects_restore),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => constraints.maxWidth >= 1000
                    ? Row(
                        children: [
                          SizedBox(width: 300, child: _catalog(true)),
                          const VerticalDivider(width: 1),
                          Expanded(child: _details()),
                        ],
                      )
                    : _catalog(false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
