import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';

class SlideshowEditorPage extends StatefulWidget {
  final SlideShowConfig config;

  const SlideshowEditorPage({Key? key, required this.config}) : super(key: key);

  @override
  State<SlideshowEditorPage> createState() => _SlideshowEditorPageState();
}

class _SlideshowEditorPageState extends State<SlideshowEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slideshow Settings')),
      body: Column(
        children: [
          // --- PREVIEW AREA ---
          Container(
              height: 200, child: SlideshowPreview(config: widget.config)),

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
                      title: const Text('Background Opacity'),
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
                          widget.config.backgroundOpacity.toStringAsFixed(2)),
                    )
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
