import 'package:config_app/features/config/presentation/bloc/config_bloc.dart';
import 'package:config_app/features/config/presentation/bloc/config_bloc_models.dart';
import 'package:config_app/features/config/presentation/pages/mqtt_editor_page.dart';
import 'package:config_app/features/config/presentation/pages/slideshow_editor_page.dart';
import 'package:config_app/features/config/presentation/pages/storage_settings_page.dart';
import 'package:config_app/features/config/presentation/pages/webserver_editor.dart';
import 'package:config_app/features/config/presentation/pages/welcome_editor_page.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:logging/logging.dart';


class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfigBloc(
        initialState: const ConfigState.initial(),
        client: sl(),
      )..add(const ConfigEvent.load()),
      child: const _ConfigView(),
    );
  }
}

class _ConfigView extends StatefulWidget {
  const _ConfigView();

  @override
  State<_ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<_ConfigView> {
  // Локальная изменяемая копия конфига для редактирования до сохранения
  AppConfig? _editingConfig;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigBloc, ConfigState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (config) {
            // При первой загрузке или после сохранения обновляем локальную копию
            // Внимание: если вы хотите сохранять стейт при перерисовках,
            // лучше делать это аккуратнее, но для примера сойдет.
            if (_editingConfig == null) {
              _editingConfig = config;
            }
          },
          saved: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Config saved successfully')),
            );
          },
          error: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error: $msg'), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          drawer: const ConfigAppNavigationBar(),
          appBar: AppBar(
            title: const Text('Settings'),
            actions: [
              IconButton(
                icon: const Icon(Icons.restore),
                onPressed: () {
                  context.read<ConfigBloc>().add(ConfigEvent.load());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Config is reloading...')),
                  );
                },
              ),
              if (_editingConfig != null)
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    context
                        .read<ConfigBloc>()
                        .add(ConfigEvent.save(_editingConfig!));
                  },
                )
            ],
          ),
          body: state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            saving: () => const Center(child: CircularProgressIndicator()),
            loaded: (_) => _buildBody(context),
            // Если мы уже загрузили, но редактируем - показываем body
            orElse: () =>
                _editingConfig != null ? _buildBody(context) : const SizedBox(),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_editingConfig == null) return const SizedBox();

    // Используем ListView для списка разделов
    return ListView(
      children: [
        // --- SlideShow Section ---
        SettingsSection(
          title: 'Slideshow',
          icon: Icons.slideshow,
          children: [
            SettingsTileNavigation(
              title: 'General & Effects',
              subtitle:
                  'Delay: ${_editingConfig!.slideshow.displayTimeMs}ms, Effects...',
              icon: Icons.photo_library,
              onTap: () => _navigateToSlideshowEditor(context),
            ),
            SettingsTileNavigation(
              title: 'Welcome Screen',
              subtitle: _editingConfig!.welcome.text,
              icon: Icons.waving_hand,
              onTap: () => _navigateToWelcomeEditor(context),
            ),
          ],
        ),
        // Внутри ListView в ConfigView
        SettingsSection(
          title: 'Storage',
          icon: Icons.sd_storage,
          children: [
            SettingsTileNavigation(
              title: 'Storage Configuration',
              // Показываем текущий выбор в подзаголовке
              subtitle:
                  _editingConfig!.storages.selected == StorageType.DiskStorage
                      ? 'Using Local Disk'
                      : 'Using Google Photos',
              icon: Icons.settings_system_daydream,
              onTap: () => _navigateToStorageSettings(context),
            ),
          ],
        ),
        // --- MQTT Section ---
        SettingsSection(
          title: 'Connectivity',
          icon: Icons.wifi,
          children: [
             SettingsTileNavigation(
              title: 'Web server',
              subtitle:
                  '${_editingConfig!.webServer.alwaysEnabled ? "Enabled" : "Disabled"}',
              icon: Icons.dns,
              onTap: () => _navigateToWebServerEditor(context),
            ),
            SettingsTileNavigation(
              title: 'MQTT',
              subtitle:
                  '${_editingConfig!.mqtt.server}:${_editingConfig!.mqtt.serverPort}',
              icon: Icons.cloud_sync,
              onTap: () => _navigateToMqttEditor(context),
            ),
          ],
        ),

        // --- Hardware Section (Пример быстрого редактирования на месте) ---
        SettingsSection(
          title: 'Hardware',
          icon: Icons.developer_board,
          children: [
            SettingsTextField(
              label: 'GPIO Smoothing (ms)',
              isNumber: true,
              initialValue: _editingConfig!.hardware.smoothingGPIOMs.toString(),
              onChanged: (val) {
                // ТУТ МЫ ОБНОВЛЯЕМ _editingConfig
                // Так как нет copyWith, приходится делать полную реконструкцию
                // или менять поле, если бы оно было mutable (в вашем коде поля mutable, кроме полей в AppConfig, которые final)
                // В вашем коде AppConfig поля final, но внутри HardwareConfig поля mutable (не final).
                // Это упрощает дело!

                _editingConfig!.hardware.smoothingGPIOMs =
                    int.tryParse(val) ?? 100;
              },
            ),
            // ... другие поля hardware
          ],
        ),
        SettingsSection(
          title: 'Logging Levels',
          icon: Icons.bug_report,
          children: [
            SettingsDropdown<Level>(
              label: 'Main Logic',
              value: _editingConfig!.log.levelMain,
              items: Level.LEVELS, // Список уровней: INFO, FINE, SEVERE...
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelMain = val);
                }
              },
            ),
            SettingsDropdown<Level>(
              label: 'Web Server',
              value: _editingConfig!.log.levelWeb,
              items: Level.LEVELS,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelWeb = val);
                }
              },
            ),
            SettingsDropdown<Level>(
              label: 'OTA Update',
              value: _editingConfig!.log.levelOTA,
              items: Level.LEVELS,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelOTA = val);
                }
              },
            ),
            SettingsDropdown<Level>(
              label: 'Hardware Frame',
              value: _editingConfig!.log.levelHwFrame,
              items: Level.LEVELS,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelHwFrame = val);
                }
              },
            ),
          ],
        )
      ],
    );
  }

  void _navigateToSlideshowEditor(BuildContext context) async {
    // Передаем ссылку на mutable объект конфига
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SlideshowEditorPage(config: _editingConfig!.slideshow),
    ));
    // После возврата обновляем UI, чтобы показать новые значения в subtitle
    setState(() {});
  }

  void _navigateToMqttEditor(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => MqttEditorPage(config: _editingConfig!.mqtt),
    ));
    setState(() {});
  }

  void _navigateToWebServerEditor(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => WebServerEditorPage(config: _editingConfig!.webServer),
    ));
    setState(() {});
  }

  

  void _navigateToWelcomeEditor(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => WelcomeEditorPage(config: _editingConfig!.welcome),
    ));
    setState(() {});
  }

  void _navigateToStorageSettings(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StorageSettingsPage(config: _editingConfig!.storages),
      ),
    );
    setState(() {}); // Обновляем UI после возврата
  }
}
