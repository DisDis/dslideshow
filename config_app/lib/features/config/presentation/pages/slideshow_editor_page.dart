import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_flutter/effect.dart';

class SlideshowEditorPage extends StatefulWidget {
  final SlideShowConfig config;

  const SlideshowEditorPage({super.key, required this.config});

  @override
  State<SlideshowEditorPage> createState() => _SlideshowEditorPageState();
}

class _SlideshowEditorPageState extends State<SlideshowEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.slideshow_settings_title),
      ),
      body: Column(
        children: [
          // --- PREVIEW AREA ---
          SizedBox(height: 360, child: SlideshowPreview(config: widget.config)),

          // --- SETTINGS LIST ---
          Expanded(
            child: ListView(
              children: [
                SettingsSection(
                  title: 'Timing',
                  children: [
                    SettingsTextField(
                      label: 'Display Time (ms)',
                      isNumber: true,
                      initialValue: widget.config.displayTimeMs.toString(),
                      onChanged: (v) {
                        widget.config.displayTimeMs = int.tryParse(v) ?? 5000;
                        setState(() {}); // Обновляем Preview
                      },
                    ),
                    SettingsTextField(
                      label: 'Transition Time (ms)',
                      isNumber: true,
                      initialValue: widget.config.transitionTimeMs.toString(),
                      onChanged: (v) {
                        widget.config.transitionTimeMs =
                            int.tryParse(v) ?? 1000;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Visuals',
                  children: [
                    SettingsSection(
                      title: 'Effects',
                      children: [
                        SettingsMultiSelect<String>(
                          label: 'Allowed Transitions',
                          // Список всех возможных вариантов
                          allItems: Effect.values.map((e) => e.name).toList(),
                          // Текущий выбранный список (преобразуем Iterable в List)
                          selectedItems: widget.config.allowedEffects.toList(),
                          onChanged: (List<String> newValues) {
                            setState(() {
                              // Обновляем конфиг
                              widget.config.allowedEffects = newValues;
                            });
                          },
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(context.localizations.photo_motion_title),
                      trailing: DropdownButton<PhotoMotionMode>(
                        key: const ValueKey('photo-motion-mode'),
                        value: widget.config.photoMotion.mode,
                        items: [
                          DropdownMenuItem(
                            value: PhotoMotionMode.off,
                            child: Text(context.localizations.photo_motion_off),
                          ),
                          DropdownMenuItem(
                            value: PhotoMotionMode.kenBurns,
                            child: Text(
                              context.localizations.photo_motion_ken_burns,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(
                              () => widget.config.photoMotion.mode = value,
                            );
                          }
                        },
                      ),
                    ),
                    if (widget.config.photoMotion.mode ==
                        PhotoMotionMode.kenBurns)
                      ListTile(
                        title: Text(context.localizations.photo_motion_zoom),
                        subtitle: Slider(
                          key: const ValueKey('photo-motion-zoom'),
                          value: widget.config.photoMotion.maxZoom,
                          min: 1,
                          max: 1.15,
                          onChanged: (value) => setState(
                            () => widget.config.photoMotion.maxZoom = value,
                          ),
                        ),
                        trailing: Text(
                          '×${widget.config.photoMotion.maxZoom.toStringAsFixed(2)}',
                        ),
                      ),
                    Text(context.localizations.water_photo_only),
                    SettingsSwitch(
                      label: 'Blur Background',
                      value: widget.config.isBlurredBackground,
                      onChanged: (v) {
                        widget.config.isBlurredBackground = v;
                        setState(() {});
                      },
                    ),
                    // Пример слайдера для Opacity
                    ListTile(
                      title: Text(context.localizations.background_opacity),
                      subtitle: Slider(
                        value: widget.config.backgroundOpacity,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (val) {
                          setState(() {
                            widget.config.backgroundOpacity = val;
                          });
                        },
                      ),
                      trailing: Text(
                        widget.config.backgroundOpacity.toStringAsFixed(2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
