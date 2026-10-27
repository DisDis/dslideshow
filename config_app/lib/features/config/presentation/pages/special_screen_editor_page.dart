import 'dart:convert';

import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/config/presentation/wigdgets/visual_number_input.dart';
import 'package:config_app/features/config/presentation/wigdgets/special_screen_preview.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'special_screens_page.dart';

enum _SpecialEditorField {
  interval,
  slideCount,
  duration,
  timeSize,
  dateSize,
  columns,
  refresh,
  frequency,
  timeFormat,
  dateFormat,
  timeFont,
  dateFont,
  requestTimeout,
  cameraMode,
  fit,
  textColor,
  backgroundColor,
}

class SpecialScreenEditorPage extends StatefulWidget {
  final SpecialScreenConfig config;
  final RegisterUnsavedDraft? registerDraft;
  const SpecialScreenEditorPage({
    super.key,
    required this.config,
    this.registerDraft,
  });
  @override
  State<SpecialScreenEditorPage> createState() =>
      _SpecialScreenEditorPageState();
}

class _SpecialScreenEditorPageState extends State<SpecialScreenEditorPage> {
  static final _argbColorPattern = RegExp(r'^[0-9a-fA-F]{8}$');
  final _form = GlobalKey<FormState>();
  late final SpecialScreenConfig _draft;
  late final String _initialJson;
  VoidCallback? _unregisterDraft;
  bool _invalid = false;

  bool _hasInvalidInput() =>
      _form.currentState?.fields.any(
        (field) => field.hasInteractedByUser && !field.isValid,
      ) ??
      false;

  void _updateValidation() {
    final invalid = _hasInvalidInput();
    if (_invalid != invalid) setState(() => _invalid = invalid);
  }

  @override
  void initState() {
    super.initState();
    _draft = widget.config.clone();
    _initialJson = jsonEncode(_draft.toJson());
    _unregisterDraft = widget.registerDraft?.call(_hasChanges);
  }

  bool _hasChanges() =>
      jsonEncode(_draft.toJson()) != _initialJson || _hasInvalidInput();

  void _releaseDraft() {
    _unregisterDraft?.call();
    _unregisterDraft = null;
  }

  @override
  void dispose() {
    _releaseDraft();
    super.dispose();
  }

  void _change(VoidCallback change) {
    setState(change);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _updateValidation();
    });
  }

  Widget _number(
    _SpecialEditorField field,
    String label,
    num value,
    void Function(double) onChanged, {
    double min = .001,
    double max = 86400,
    bool integer = false,
  }) => Padding(
    key: ValueKey(field),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: TextFormField(
      key: ValueKey(field),
      initialValue: value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: !integer),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (text) {
        final n = parseVisualNumber(text, integer: integer);
        return n == null ||
                !n.isFinite ||
                n < min ||
                n > max ||
                (integer && n != n.roundToDouble())
            ? context.localizations.special_invalid_number
            : null;
      },
      onChanged: (text) {
        final n = parseVisualNumber(text, integer: integer);
        if (n != null &&
            n.isFinite &&
            n >= min &&
            n <= max &&
            (!integer || n == n.roundToDouble())) {
          _change(() => onChanged(n));
        }
      },
    ),
  );
  Widget _switch(String label, bool value, void Function(bool) change) =>
      SwitchListTile(
        title: Text(label),
        value: value,
        onChanged: (v) => _change(() => change(v)),
      );
  Widget _dropdown<T>(
    _SpecialEditorField field,
    String label,
    T value,
    Map<T, String> choices,
    void Function(T) change,
  ) => Padding(
    key: ValueKey(field),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: DropdownButtonFormField<T>(
      key: ValueKey(field),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: choices.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: (v) {
        if (v != null) _change(() => change(v));
      },
    ),
  );
  Widget _color(
    _SpecialEditorField field,
    String label,
    int value,
    void Function(int) change,
  ) => Padding(
    key: ValueKey(field),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: TextFormField(
      key: ValueKey(field),
      initialValue: value.toRadixString(16).padLeft(8, '0'),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: Icon(Icons.circle, color: Color(value)),
      ),
      validator: (text) => _argbColorPattern.hasMatch(text ?? '')
          ? null
          : context.localizations.special_invalid_color,
      onChanged: (text) {
        if (_argbColorPattern.hasMatch(text)) {
          _change(() => change(int.parse(text, radix: 16)));
        }
      },
    ),
  );
  void _done() {
    if (!_form.currentState!.validate()) return;
    if (_draft.options case CamerasScreenOptions(cameras: final cameras)
        when cameras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.localizations.special_camera_required)),
      );
      return;
    }
    _releaseDraft();
    Navigator.of(context).pop(_draft);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final options = _draft.options;
    return Scaffold(
      appBar: AppBar(
        title: Text(specialScreenTypeLabel(context, _draft.type)),
        actions: [
          TextButton(
            onPressed: () {
              _releaseDraft();
              Navigator.pop(context);
            },
            child: Text(l.special_cancel),
          ),
          TextButton(onPressed: _done, child: Text(l.special_done)),
        ],
      ),
      body: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: _updateValidation,
        child: PreviewEditorLayout(
          hasInvalidInput: _invalid,
          help: options is ClockScreenOptions
              ? l.preview_clock_help
              : l.special_browser_camera_help,
          previewBuilder: (_) => SpecialScreenPreview(config: _draft),
          editor: Column(
            children: [
              if (kIsWeb && options is CamerasScreenOptions)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l.special_browser_camera_help),
                ),
              SettingsSection(
                title: l.special_common,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      initialValue: _draft.name,
                      decoration: InputDecoration(
                        labelText: l.special_name,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (v) => _change(() => _draft.name = v),
                    ),
                  ),
                  _switch(
                    l.special_enabled,
                    _draft.enabled,
                    (v) => _draft.enabled = v,
                  ),
                  _dropdown(
                    _SpecialEditorField.frequency,
                    l.special_frequency,
                    _draft.schedule.type,
                    {
                      SpecialScreenScheduleType.everyMediaSlides:
                          l.special_after_slides,
                      SpecialScreenScheduleType.interval: l.special_interval,
                    },
                    (v) => _draft.schedule.type = v,
                  ),
                  if (_draft.schedule.type ==
                      SpecialScreenScheduleType.interval)
                    _number(
                      _SpecialEditorField.interval,
                      l.special_interval_minutes,
                      _draft.schedule.intervalMs / 60000,
                      (v) => _draft.schedule.intervalMs = (v * 60000).round(),
                      min: 1 / 60,
                      max: 1440,
                    )
                  else
                    _number(
                      _SpecialEditorField.slideCount,
                      l.special_slide_count,
                      _draft.schedule.count,
                      (v) => _draft.schedule.count = v.toInt(),
                      min: 1,
                      max: 1000000,
                      integer: true,
                    ),
                  _number(
                    _SpecialEditorField.duration,
                    l.special_duration_seconds,
                    _draft.displayTimeMs / 1000,
                    (v) => _draft.displayTimeMs = (v * 1000).round(),
                    min: .1,
                  ),
                ],
              ),
              if (options is ClockScreenOptions) _clock(options),
              if (options is CamerasScreenOptions) _cameras(options),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clock(ClockScreenOptions options) {
    final l = context.localizations;
    return SettingsSection(
      title: l.special_clock_settings,
      children: [
        _dropdown(
          _SpecialEditorField.timeFormat,
          l.special_time_format,
          options.timeFormat,
          {
            ClockTimeFormat.h24: l.special_24h,
            ClockTimeFormat.h12: l.special_12h,
          },
          (v) => options.timeFormat = v,
        ),
        _switch(
          l.special_show_seconds,
          options.showSeconds,
          (v) => options.showSeconds = v,
        ),
        _switch(
          l.special_show_date,
          options.showDate,
          (v) => options.showDate = v,
        ),
        _switch(
          l.special_show_weekday,
          options.showWeekday,
          (v) => options.showWeekday = v,
        ),
        if (options.showDate)
          _dropdown(
            _SpecialEditorField.dateFormat,
            l.special_date_format,
            options.dateFormat,
            {
              ClockDateFormat.dayMonthYear: '25.10.2026',
              ClockDateFormat.yearMonthDay: '2026-10-25',
              ClockDateFormat.dayMonthYearSlashes: '25/10/2026',
            },
            (v) => options.dateFormat = v,
          ),
        _dropdown(
          _SpecialEditorField.timeFont,
          l.special_time_font,
          options.timeFont,
          _clockFonts(),
          (v) => options.timeFont = v,
        ),
        _number(
          _SpecialEditorField.timeSize,
          l.special_time_size,
          options.timeFontSizePercent,
          (v) => options.timeFontSizePercent = v,
          min: 1,
          max: 100,
        ),
        if (options.showDate || options.showWeekday)
          _dropdown(
            _SpecialEditorField.dateFont,
            l.special_date_font,
            options.dateFont,
            _clockFonts(),
            (v) => options.dateFont = v,
          ),
        if (options.showDate || options.showWeekday)
          _number(
            _SpecialEditorField.dateSize,
            l.special_date_size,
            options.dateFontSizePercent,
            (v) => options.dateFontSizePercent = v,
            min: 1,
            max: 100,
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l.special_font_help),
        ),
        _color(
          _SpecialEditorField.textColor,
          l.special_text_color,
          options.textColor,
          (v) => options.textColor = v,
        ),
        _color(
          _SpecialEditorField.backgroundColor,
          l.special_background_color,
          options.backgroundColor,
          (v) => options.backgroundColor = v,
        ),
      ],
    );
  }

  Map<ClockFont, String> _clockFonts() {
    final l = context.localizations;
    return {
      ClockFont.system: l.special_font_system,
      ClockFont.roboto: l.special_font_roboto,
      ClockFont.orbitron: l.special_font_orbitron,
      ClockFont.righteous: l.special_font_righteous,
      ClockFont.fredoka: l.special_font_fredoka,
    };
  }

  Widget _cameras(CamerasScreenOptions options) {
    final l = context.localizations;
    return SettingsSection(
      title: l.special_camera_settings,
      children: [
        _dropdown(
          _SpecialEditorField.cameraMode,
          l.special_camera_mode,
          options.mode,
          {
            CameraDisplayMode.grid: l.special_grid,
            CameraDisplayMode.sequence: l.special_sequence,
          },
          (v) => options.mode = v,
        ),
        if (options.mode == CameraDisplayMode.sequence)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l.special_sequence_help),
          ),
        if (options.mode == CameraDisplayMode.grid)
          _number(
            _SpecialEditorField.columns,
            l.special_columns,
            options.columns,
            (v) => options.columns = v.toInt(),
            min: 0,
            max: 16,
            integer: true,
          ),
        _dropdown(_SpecialEditorField.fit, l.special_fit, options.fit, {
          CameraImageFit.contain: l.special_contain,
          CameraImageFit.cover: l.special_cover,
        }, (v) => options.fit = v),
        _switch(
          l.special_show_names,
          options.showNames,
          (v) => options.showNames = v,
        ),
        _number(
          _SpecialEditorField.refresh,
          l.special_refresh,
          options.refreshIntervalMs / 1000,
          (v) => options.refreshIntervalMs = (v * 1000).round(),
          min: 0,
        ),
        _number(
          _SpecialEditorField.requestTimeout,
          l.special_request_timeout,
          options.requestTimeoutMs / 1000,
          (v) => options.requestTimeoutMs = (v * 1000).round(),
          min: .1,
          max: 120,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l.special_request_timeout_help),
        ),
        for (var i = 0; i < options.cameras.length; i++) _camera(options, i),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton.icon(
            onPressed: () => _change(
              () => options.cameras.add(CameraConfig(id: const Uuid().v4())),
            ),
            icon: const Icon(Icons.add),
            label: Text(l.special_add_camera),
          ),
        ),
      ],
    );
  }

  Widget _camera(CamerasScreenOptions options, int index) {
    final l = context.localizations;
    final camera = options.cameras[index];
    final urlField = GlobalObjectKey<FormFieldState<String>>(camera);
    return Card(
      key: ValueKey(camera.id),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('${index + 1}. ${camera.name}')),
                IconButton(
                  tooltip: l.special_move_up,
                  onPressed: index == 0
                      ? null
                      : () => _change(() {
                          options.cameras.insert(
                            index - 1,
                            options.cameras.removeAt(index),
                          );
                        }),
                  icon: const Icon(Icons.arrow_upward),
                ),
                IconButton(
                  tooltip: l.special_move_down,
                  onPressed: index == options.cameras.length - 1
                      ? null
                      : () => _change(() {
                          options.cameras.insert(
                            index + 1,
                            options.cameras.removeAt(index),
                          );
                        }),
                  icon: const Icon(Icons.arrow_downward),
                ),
                IconButton(
                  tooltip: l.special_delete,
                  onPressed: () =>
                      _change(() => options.cameras.removeAt(index)),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            TextFormField(
              initialValue: camera.name,
              decoration: InputDecoration(labelText: l.special_name),
              onChanged: (v) => _change(() => camera.name = v),
            ),
            TextFormField(
              key: urlField,
              initialValue: camera.url,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(labelText: l.special_camera_url),
              validator: (text) =>
                  CameraConfig(id: '', url: text?.trim() ?? '').hasValidUrl
                  ? null
                  : l.special_invalid_url,
              onChanged: (v) {
                final url = v.trim();
                if (CameraConfig(id: '', url: url).hasValidUrl) {
                  _change(() => camera.url = url);
                }
              },
            ),
            ExpansionTile(
              title: Text(l.special_auth),
              children: [
                TextFormField(
                  initialValue: camera.username,
                  decoration: InputDecoration(labelText: l.username),
                  onChanged: (v) => _change(() => camera.username = v),
                ),
                TextFormField(
                  initialValue: camera.password,
                  obscureText: true,
                  decoration: InputDecoration(labelText: l.password),
                  onChanged: (v) => _change(() => camera.password = v),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () => _checkCamera(camera, urlField),
              icon: const Icon(Icons.image_outlined),
              label: Text(l.special_check_camera),
            ),
          ],
        ),
      ),
    );
  }

  void _checkCamera(
    CameraConfig camera,
    GlobalKey<FormFieldState<String>> urlField,
  ) {
    // The typed model retains the last valid URL while its raw field may be
    // incomplete. Never check an older URL instead of what the user sees.
    if (_form.currentState?.validate() != true ||
        urlField.currentState?.validate() != true ||
        !camera.hasValidUrl) {
      return;
    }
    final config = SpecialScreenConfig(
      id: 'camera-check',
      type: SpecialScreenType.cameras,
      options: CamerasScreenOptions(
        cameras: [CameraConfig.fromJson(camera.toJson())],
        refreshIntervalMs: 0,
        requestTimeoutMs:
            (_draft.options as CamerasScreenOptions).requestTimeoutMs,
      ),
    );
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(camera.name),
        content: SizedBox(
          width: 480,
          child: SpecialScreenPreview(config: config),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.localizations.special_done),
          ),
        ],
      ),
    );
  }
}
