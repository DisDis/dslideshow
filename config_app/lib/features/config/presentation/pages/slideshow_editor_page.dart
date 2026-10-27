import 'package:config_app/features/config/presentation/wigdgets/argb_color_field.dart';
import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlideshowEditorPage extends StatefulWidget {
  final SlideShowConfig config;
  final RegisterUnsavedDraft? registerDraft;
  const SlideshowEditorPage({
    super.key,
    required this.config,
    this.registerDraft,
  });

  @override
  State<SlideshowEditorPage> createState() => _SlideshowEditorPageState();
}

class _SlideshowEditorPageState extends State<SlideshowEditorPage> {
  final _invalid = <String>{};

  Widget _number(
    String key,
    String label,
    int initial,
    ValueChanged<int> change, {
    int min = 1,
    int max = 3600000,
  }) {
    bool valid(String? text) {
      final n = int.tryParse(text ?? '');
      return n != null && n >= min && n <= max;
    }

    return Padding(
      key: ValueKey('field-$key'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        key: ValueKey(key),
        initialValue: initial.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        validator: (text) =>
            valid(text) ? null : context.localizations.special_invalid_number,
        onChanged: (text) => setState(() {
          if (valid(text)) {
            _invalid.remove(key);
            change(int.parse(text));
          } else {
            _invalid.add(key);
          }
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final config = widget.config;
    final numberFormat = NumberFormat(
      '0.00',
      Localizations.localeOf(context).toLanguageTag(),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l.slideshow_settings_title)),
      body: DraftEditorForm(
        registerDraft: widget.registerDraft,
        child: PreviewEditorLayout(
          hasInvalidInput: _invalid.isNotEmpty,
          help: l.preview_environment_help,
          previewBuilder: (_) => SlideshowPreview(config: config),
          editor: Column(
            children: [
              SettingsSection(
                title: l.timing_title,
                children: [
                  _number(
                    'slideshow-display-time',
                    l.display_time_ms,
                    config.displayTimeMs,
                    (v) => config.displayTimeMs = v,
                  ),
                ],
              ),
              SettingsSection(
                title: l.visuals_title,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DropdownButtonFormField<PhotoMotionMode>(
                      key: const ValueKey('photo-motion-mode'),
                      initialValue: config.photoMotion.mode,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: l.photo_motion_title,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: PhotoMotionMode.off,
                          child: Text(l.photo_motion_off),
                        ),
                        DropdownMenuItem(
                          value: PhotoMotionMode.kenBurns,
                          child: Text(l.photo_motion_ken_burns),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => config.photoMotion.mode = value);
                        }
                      },
                    ),
                  ),
                  if (config.photoMotion.mode == PhotoMotionMode.kenBurns)
                    ListTile(
                      title: Text(l.photo_motion_zoom),
                      subtitle: Slider(
                        key: const ValueKey('photo-motion-zoom'),
                        value: config.photoMotion.maxZoom.clamp(1, 1.15),
                        min: 1,
                        max: 1.15,
                        label: numberFormat.format(config.photoMotion.maxZoom),
                        onChanged: (value) =>
                            setState(() => config.photoMotion.maxZoom = value),
                      ),
                      trailing: Text(
                        '×${numberFormat.format(config.photoMotion.maxZoom)}',
                      ),
                    ),
                  SettingsSwitch(
                    label: l.blur_background,
                    value: config.isBlurredBackground,
                    onChanged: (value) => setState(() {
                      config.isBlurredBackground = value;
                      if (!value) _invalid.remove('slideshow-blur-sigma');
                    }),
                  ),
                  if (config.isBlurredBackground) ...[
                    _number(
                      'slideshow-blur-sigma',
                      l.background_blur_sigma,
                      config.backgroundBlurSigma,
                      (value) => config.backgroundBlurSigma = value,
                      min: 0,
                      max: 200,
                    ),
                    ListTile(
                      title: Text(l.background_opacity),
                      subtitle: Slider(
                        key: const ValueKey('slideshow-background-opacity'),
                        value: config.backgroundOpacity.isFinite
                            ? config.backgroundOpacity.clamp(0, 1)
                            : .9,
                        label: numberFormat.format(config.backgroundOpacity),
                        onChanged: (value) =>
                            setState(() => config.backgroundOpacity = value),
                      ),
                    ),
                  ],
                  Padding(
                    key: const ValueKey('slideshow-background-color-field'),
                    padding: const EdgeInsets.all(16),
                    child: ArgbColorField(
                      fieldKey: const ValueKey('slideshow-background-color'),
                      label: l.background_color_argb,
                      value: config.backgroundColor,
                      onValidityChanged: (valid) => setState(() {
                        if (valid) {
                          _invalid.remove('color');
                        } else {
                          _invalid.add('color');
                        }
                      }),
                      onChanged: (color) =>
                          setState(() => config.backgroundColor = color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
