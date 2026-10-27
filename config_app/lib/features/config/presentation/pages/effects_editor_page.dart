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

enum _Field { duration, grid, color, angle, count }

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

  void _put(EffectConfig entry) {
    widget.config.effects = _config.put(entry);
    _changed();
  }

  void _options(EffectOptions options) =>
      _put(_entry.copyWith(options: options));
  int? _milliseconds(String text) {
    final ms = int.tryParse(text.trim(), radix: 10);
    return ms != null && ms >= 1 && ms <= 3600000 ? ms : null;
  }

  String _time(EffectConfig entry) =>
      '${entry.options.durationMs == 0 ? '${context.localizations.effects_inherit} · ' : ''}${context.localizations.effects_milliseconds(_config.durationFor(entry.options))}';

  String _summary(EffectConfig entry) {
    if (entry.validate().isNotEmpty) {
      return context.localizations.effects_invalid;
    }
    final options = entry.options;
    final parts = <String>[_time(entry)];
    if (options !=
        defaultEffectOptions(entry.type).withDuration(options.durationMs)) {
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
    String key,
    String label,
    T value,
    List<T> values,
    ValueChanged<T> change,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: DropdownButtonFormField<T>(
      key: ValueKey('effect-${_selected.name}-$key-${value.name}'),
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
  num? _integer(String text, int min, int max) {
    final value = int.tryParse(text);
    return value != null && value >= min && value <= max ? value : null;
  }

  Widget _specificOptions() {
    final l = context.localizations, options = _entry.options;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (options is MosaicEffectOptions) ...[
          _number(
            _Field.grid,
            l.effects_grid,
            '${options.gridSize}',
            (v) => _integer(v, 100, 200),
            (v) => _options(options.copyWith(gridSize: v.toInt())),
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
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.effects_fade_fraction),
            subtitle: Text(l.effects_fade_help),
            trailing: Text('${(options.fadeFraction * 100).round()}%'),
          ),
          Slider(
            key: const ValueKey('effect-fade-fraction'),
            value: options.fadeFraction.clamp(0, 1),
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (v) => _options(options.copyWith(fadeFraction: v)),
          ),
          _enum(
            'direction',
            l.effects_direction,
            options.direction,
            MosaicDirection.values,
            (v) => _options(options.copyWith(direction: v)),
          ),
        ],
        if (options is SlideEffectOptions) ...[
          _enum(
            'mode',
            l.effects_mode,
            options.mode,
            SlideMode.values,
            (v) => _options(options.copyWith(mode: v)),
          ),
          _enum(
            'direction',
            l.effects_direction,
            options.direction,
            EffectDirection.values,
            (v) => _options(options.copyWith(direction: v)),
          ),
        ],
        if (options is RevealMaskEffectOptions) ...[
          _enum(
            'shape',
            l.effects_shape,
            options.shape,
            RevealShape.values,
            (v) => _options(
              options.copyWith(
                shape: v,
                origin: v == RevealShape.iris
                    ? EffectOrigin.center
                    : options.origin == EffectOrigin.center
                    ? EffectOrigin.topLeft
                    : options.origin,
              ),
            ),
          ),
          if (options.shape == RevealShape.wipe)
            _enum(
              'direction',
              l.effects_direction,
              options.direction,
              EffectDirection.values,
              (v) => _options(options.copyWith(direction: v)),
            ),
          if (options.shape == RevealShape.curtain)
            _enum(
              'axis',
              l.effects_axis,
              options.axis,
              EffectAxis.values,
              (v) => _options(options.copyWith(axis: v)),
            ),
          if (options.shape == RevealShape.diagonal ||
              options.shape == RevealShape.iris)
            _enum(
              'origin',
              l.effects_origin,
              options.origin,
              options.shape == RevealShape.diagonal
                  ? EffectOrigin.values
                        .where((v) => v != EffectOrigin.center)
                        .toList()
                  : EffectOrigin.values,
              (v) => _options(options.copyWith(origin: v)),
            ),
        ],
        if (options is FadeThroughColorEffectOptions) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ArgbColorField(
              fieldKey: ValueKey('effect-${_selected.name}-color'),
              label: l.effects_color,
              value: options.color,
              controller: (_controllers[_selected] ??= {}).putIfAbsent(
                _Field.color,
                () => TextEditingController(
                  text: options.color.toRadixString(16).padLeft(8, '0'),
                ),
              ),
              onValidityChanged: (valid) {
                if (valid) {
                  _invalid[_selected]?.remove(_Field.color);
                } else {
                  (_invalid[_selected] ??= {}).add(_Field.color);
                }
                _changed();
              },
              onChanged: (color) => _options(options.copyWith(color: color)),
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              for (final color in [0xFF000000, 0xFFFFFFFF])
                ActionChip(
                  label: Text(
                    color == 0xFF000000 ? l.effects_black : l.effects_white,
                  ),
                  onPressed: () {
                    _controllers[_selected]?[_Field.color]?.text = color
                        .toRadixString(16);
                    _invalid[_selected]?.remove(_Field.color);
                    _options(options.copyWith(color: color));
                  },
                ),
            ],
          ),
        ],
        if (options is SoftWipeEffectOptions)
          _enum(
            'style',
            l.effects_style,
            options.style,
            SoftWipeStyle.values,
            (v) => _options(options.copyWith(style: v)),
          ),
        if (options is FlipEffectOptions)
          _enum(
            'axis',
            l.effects_axis,
            options.axis,
            EffectAxis.values,
            (v) => _options(options.copyWith(axis: v)),
          ),
        if (options is RotateEffectOptions) ...[
          _enum(
            'edge',
            l.effects_edge,
            options.edge,
            RotationEdge.values,
            (v) => _options(options.copyWith(edge: v)),
          ),
          _number(_Field.angle, l.effects_angle, '${options.angleDegrees}', (
            text,
          ) {
            final n = double.tryParse(text.replaceAll(',', '.'));
            return n != null && n.isFinite && n >= 0 && n <= 90 ? n : null;
          }, (v) => _options(options.copyWith(angleDegrees: v.toDouble()))),
        ],
        if (options is BlindsEffectOptions)
          _count(
            options.stripCount,
            (v) => _options(options.copyWith(stripCount: v)),
          ),
        if (options is SliceEffectOptions)
          _count(
            options.stripCount,
            (v) => _options(options.copyWith(stripCount: v)),
          ),
        if (options is GlassEffectOptions)
          _count(
            options.paneCount,
            (v) => _options(options.copyWith(paneCount: v)),
          ),
        if (options is PanelWipeEffectOptions)
          _count(
            options.panelCount,
            (v) => _options(options.copyWith(panelCount: v)),
          ),
        if (options is LouverEffectOptions)
          _count(
            options.slatCount,
            (v) => _options(options.copyWith(slatCount: v)),
          ),
      ],
    );
  }

  Widget _count(int value, ValueChanged<int> change) => _number(
    _Field.count,
    context.localizations.effects_count,
    '$value',
    (v) => _integer(v, 1, 32),
    (v) => change(v.toInt()),
  );
  void _reset() {
    _invalid.remove(_selected);
    _customDurations.remove(_selected);
    final fields = _controllers.remove(_selected);
    // Text fields detach during this rebuild; dispose their controllers after it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final c in fields?.values ?? <TextEditingController>[]) {
        c.dispose();
      }
    });
    _put(
      EffectConfig(
        type: _selected,
        enabled: _entry.enabled,
        options: defaultEffectOptions(_selected),
      ),
    );
  }

  Widget _form() {
    final l = context.localizations, entry = _entry;
    if (entry.validate().isNotEmpty) {
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
            onChanged: (v) => _put(entry.copyWith(enabled: v)),
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
      selectedEffect: _entry.validate().isEmpty
          ? Effect.fromConfig(_entry)
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
                      subtitle: Text(_summary(entry)),
                      leading: Switch(
                        key: ValueKey('effect-enabled-${effect.type.name}'),
                        value: entry.enabled,
                        onChanged: (v) => _put(entry.copyWith(enabled: v)),
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
      widget.config.effects = _config.put(switch (action) {
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
                        widget.config.effects = EffectsConfig.defaults();
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
