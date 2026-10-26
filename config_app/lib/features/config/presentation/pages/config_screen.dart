import 'dart:async';

import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/domain/config_draft.dart';
import 'package:config_app/features/config/presentation/bloc/config_bloc.dart';
import 'package:config_app/features/config/presentation/bloc/config_bloc_models.dart';
import 'package:config_app/features/config/presentation/pages/mqtt_editor_page.dart';
import 'package:config_app/features/config/presentation/pages/slideshow_editor_page.dart';
import 'package:config_app/features/config/presentation/pages/storage_settings_page.dart';
import 'package:config_app/features/config/presentation/pages/webserver_editor.dart';
import 'package:config_app/features/config/presentation/pages/welcome_editor_page.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:logging/logging.dart';
import 'package:go_router/go_router.dart';
import 'package:config_app/src/browser_exit_guard/browser_exit_guard.dart';

import 'special_screens_page.dart';

enum ConfigDiscardAction { leave, reload, reset }

class ConfigScreen extends StatefulWidget {
  final PhotoframeRepository? repository;
  const ConfigScreen({super.key, this.repository});

  @override
  State<ConfigScreen> createState() => ConfigScreenState();
}

class ConfigScreenState extends State<ConfigScreen> {
  late final ConfigBloc _bloc;
  final _draft = ConfigDraft();
  final _localDrafts = <ValueGetter<bool>>{};
  bool get _hasUnsavedChanges =>
      _draft.hasChanges || _localDrafts.any((hasChanges) => hasChanges());
  late final BrowserExitGuard _browserExitGuard;
  AppConfig? get _editingConfig => _draft.value;
  Future<bool>? _exitConfirmation;
  DialogRoute<bool>? _dialog;
  bool _busy = true;
  bool _reloadPending = false;
  bool _hasSaved = false;
  int _revision = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _bloc = ConfigBloc(
      initialState: const ConfigState.initial(),
      client: widget.repository ?? sl(),
    )..add(const ConfigEvent.load());
    _browserExitGuard = BrowserExitGuard(() => _busy || _hasUnsavedChanges);
  }

  VoidCallback _registerLocalDraft(ValueGetter<bool> hasChanges) {
    _localDrafts.add(hasChanges);
    // An editor can finish unmounting after its replacement has registered.
    // Remove only this editor's check, without rebuilding during unmount.
    return () => _localDrafts.remove(hasChanges);
  }

  @override
  void dispose() {
    _browserExitGuard.dispose();
    unawaited(_bloc.close());
    final dialog = _dialog;
    final navigator = dialog?.navigator;
    if (dialog != null && navigator != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigator.mounted && dialog.isActive) {
          navigator.removeRoute(dialog, false);
        }
      });
    }
    super.dispose();
  }

  void _message(String text, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            text,
            style: error
                ? TextStyle(color: Theme.of(context).colorScheme.onError)
                : null,
          ),
          backgroundColor: error ? Theme.of(context).colorScheme.error : null,
        ),
      );
  }

  Future<bool> _confirmDiscard(ConfigDiscardAction action) async {
    final dialog = DialogRoute<bool>(
      context: context,
      builder: (dialogContext) {
        final l = dialogContext.localizations;
        return AlertDialog(
          title: Text(switch (action) {
            ConfigDiscardAction.reload => l.config_reload_title,
            ConfigDiscardAction.leave => l.config_unsaved_changes,
            ConfigDiscardAction.reset => l.config_reset_button,
          }),
          content: Text(switch (action) {
            ConfigDiscardAction.reload => l.config_reload_warning,
            ConfigDiscardAction.leave => l.config_leave_warning,
            ConfigDiscardAction.reset => l.config_reset_warning,
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l.config_keep_editing),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l.config_discard_changes),
            ),
          ],
        );
      },
    );
    _dialog = dialog;
    try {
      return await Navigator.of(context).push(dialog) ?? false;
    } finally {
      if (identical(_dialog, dialog)) _dialog = null;
    }
  }

  Future<bool> confirmExit() => _exitConfirmation ??= _confirmExit()
      .whenComplete(() => _exitConfirmation = null);

  Future<bool> _confirmExit() async {
    if (!mounted) return false;
    if (_reloadPending) return false;
    if (_busy) {
      _message(context.localizations.config_operation_in_progress);
      return false;
    }
    if (!_hasUnsavedChanges) return true;
    final discard = await _confirmDiscard(ConfigDiscardAction.leave);
    if (!mounted) return false;
    if (discard) {
      setState(() {
        _draft.discard();
        _revision++;
      });
    }
    return discard;
  }

  void _save() {
    if (_busy || !_draft.hasChanges || _localDrafts.any((check) => check())) {
      return;
    }
    try {
      final snapshot = cloneConfig(_editingConfig!);
      FocusScope.of(context).unfocus();
      setState(() {
        _busy = true;
        _error = null;
      });
      _bloc.add(ConfigEvent.save(snapshot));
    } catch (error) {
      setState(() => _error = error.toString());
      _message(
        context.localizations.error_with_message(error.toString()),
        error: true,
      );
    }
  }

  Future<void> _reload() async {
    if (_busy || _reloadPending || _exitConfirmation != null) return;
    _reloadPending = true;
    try {
      if (_hasUnsavedChanges &&
          !await _confirmDiscard(ConfigDiscardAction.reload)) {
        return;
      }
      if (!mounted || _busy) return;
      FocusScope.of(context).unfocus();
      setState(() {
        _busy = true;
        _error = null;
      });
      _bloc.add(const ConfigEvent.load());
    } finally {
      _reloadPending = false;
    }
  }

  void _refreshDraft() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return BlocConsumer<ConfigBloc, ConfigState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeWhen(
          loading: () => setState(() {
            _busy = true;
            _error = null;
          }),
          saving: () => setState(() {
            _busy = true;
            _error = null;
          }),
          loaded: (config) => setState(() {
            _draft.replaceSaved(config);
            _localDrafts.clear();
            _revision++;
            _busy = false;
            _error = null;
          }),
          saved: () {
            setState(() => _hasSaved = true);
            _message(l.config_saved_successfully);
          },
          error: (message) {
            setState(() {
              _busy = false;
              _error = message;
            });
            _message(l.error_with_message(message), error: true);
          },
          orElse: () {},
        );
      },
      builder: (context, state) => ConfigAppScaffold(
        onLogoutRequested: confirmExit,
        appBar: AppBar(
          title: Text(l.settings_title),
          actions: [
            IconButton(
              key: const ValueKey('config-reload'),
              tooltip: l.config_reload_button,
              icon: const Icon(Icons.refresh),
              onPressed: _busy ? null : _reload,
            ),
          ],
        ),
        bottomNavigationBar: _editingConfig == null
            ? null
            : _buildSaveBar(context),
        body: _editingConfig == null
            ? _busy
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline, size: 48),
                            Text(l.config_load_failed),
                            if (_error != null)
                              Text(l.error_with_message(_error!)),
                            FilledButton(
                              key: const ValueKey('config-retry'),
                              onPressed: _reload,
                              child: Text(l.try_again_button),
                            ),
                          ],
                        ),
                      ),
                    )
            : Column(
                children: [
                  if (_busy) const LinearProgressIndicator(),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        l.error_with_message(_error!),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: _busy,
                      child: ExcludeFocus(
                        excluding: _busy,
                        child: KeyedSubtree(
                          key: ValueKey(_revision),
                          child: DraftEditorForm(
                            key: const ValueKey('config-editor-fields'),
                            confirmInvalidOnBack: false,
                            registerDraft: _registerLocalDraft,
                            onChanged: _refreshDraft,
                            child: SettingsContent(child: _buildBody(context)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _reset() async {
    if (_busy || _reloadPending || _exitConfirmation != null) return;
    _reloadPending = true;
    try {
      if (!await _confirmDiscard(ConfigDiscardAction.reset) || !mounted) return;
      FocusScope.of(context).unfocus();
      setState(() {
        _draft.discard();
        _localDrafts.clear();
        _revision++;
        _error = null;
      });
    } finally {
      _reloadPending = false;
    }
  }

  Widget _buildSaveBar(BuildContext context) {
    final l = context.localizations;
    final theme = Theme.of(context);
    final dirty = _hasUnsavedChanges;
    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    dirty ? Icons.edit_outlined : Icons.check_circle_outline,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      dirty ? l.config_unsaved_changes : l.config_saved_state,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(l.config_restart_hint, style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilledButton.icon(
                    key: const ValueKey('config-save'),
                    icon: const Icon(Icons.save_outlined),
                    label: Text(l.config_save_button),
                    onPressed:
                        !_busy &&
                            _draft.hasChanges &&
                            !_localDrafts.any((check) => check())
                        ? _save
                        : null,
                  ),
                  TextButton(
                    key: const ValueKey('config-reset'),
                    onPressed: !_busy && dirty ? _reset : null,
                    child: Text(l.config_reset_button),
                  ),
                  if (_hasSaved)
                    TextButton.icon(
                      onPressed: _busy ? null : () => context.go('/power'),
                      icon: const Icon(Icons.power_settings_new),
                      label: Text(l.system_control_menu_item),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_editingConfig == null) return const SizedBox();

    // Используем ListView для списка разделов
    return ListView(
      children: [
        // --- SlideShow Section ---
        SettingsSection(
          title: context.localizations.slideshow_section_title,
          icon: Icons.slideshow,
          children: [
            SettingsTileNavigation(
              title: context.localizations.general_and_effects_title,
              subtitle: context.localizations.slideshow_summary(
                _editingConfig!.slideshow.displayTimeMs / 1000,
              ),
              icon: Icons.photo_library,
              onTap: () => _navigateToSlideshowEditor(context),
            ),
            SettingsTileNavigation(
              title: context.localizations.welcome_screen_title,
              subtitle: _editingConfig!.welcome.text,
              icon: Icons.waving_hand,
              onTap: () => _navigateToWelcomeEditor(context),
            ),
            SettingsTileNavigation(
              title: context.localizations.special_screens_title,
              subtitle: context.localizations.special_enabled_summary(
                _editingConfig!.slideshow.specialScreens
                    .where((s) => s.enabled)
                    .length,
                _editingConfig!.slideshow.specialScreens.length,
              ),
              icon: Icons.dashboard_customize,
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SpecialScreensPage(
                      config: _editingConfig!.slideshow,
                      registerDraft: _registerLocalDraft,
                    ),
                  ),
                );
                if (mounted) setState(() {});
              },
            ),
          ],
        ),
        // Внутри ListView в ConfigView
        SettingsSection(
          title: context.localizations.storage_title,
          icon: Icons.sd_storage,
          children: [
            SettingsTileNavigation(
              title: context.localizations.storage_configuration_title,
              // Показываем текущий выбор в подзаголовке
              subtitle:
                  _editingConfig!.storages.selected == StorageType.DiskStorage
                  ? context.localizations.using_local_disk
                  : context.localizations.using_google_photos,
              icon: Icons.settings_system_daydream,
              onTap: () => _navigateToStorageSettings(context),
            ),
          ],
        ),
        // --- MQTT Section ---
        SettingsSection(
          title: context.localizations.connectivity_title,
          icon: Icons.wifi,
          children: [
            SettingsTileNavigation(
              title: context.localizations.web_server_settings_title,
              subtitle: _editingConfig!.webServer.alwaysEnabled
                  ? context.localizations.enabled_label
                  : context.localizations.disabled_label,
              icon: Icons.dns,
              onTap: () => _navigateToWebServerEditor(context),
            ),
            SettingsTileNavigation(
              title: context.localizations.mqtt_title,
              subtitle:
                  '${_editingConfig!.mqtt.server}:${_editingConfig!.mqtt.serverPort}',
              icon: Icons.cloud_sync,
              onTap: () => _navigateToMqttEditor(context),
            ),
          ],
        ),

        // --- Hardware Section (Пример быстрого редактирования на месте) ---
        SettingsSection(
          title: context.localizations.hardware_title,
          icon: Icons.developer_board,
          children: [
            SettingsTextField(
              label: context.localizations.gpio_smoothing_label,
              isNumber: true,
              validator: (text) {
                final value = int.tryParse(text ?? '');
                return value != null && value >= 0
                    ? null
                    : context.localizations.invalid_nonnegative_integer;
              },
              initialValue: _editingConfig!.hardware.smoothingGPIOMs.toString(),
              onChanged: (val) {
                setState(() {
                  final value = int.tryParse(val);
                  if (value != null && value >= 0) {
                    _editingConfig!.hardware.smoothingGPIOMs = value;
                  }
                });
              },
            ),
            // ... другие поля hardware
          ],
        ),
        SettingsSection(
          title: context.localizations.logging_levels_title,
          expandable: true,
          icon: Icons.bug_report,
          children: [
            SettingsDropdown<Level>(
              label: context.localizations.main_logic_label,
              value: _editingConfig!.log.levelMain,
              items: Level.LEVELS, // Список уровней: INFO, FINE, SEVERE...
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelMain = val);
                }
              },
            ),
            SettingsDropdown<Level>(
              label: context.localizations.web_server_settings_title,
              value: _editingConfig!.log.levelWeb,
              items: Level.LEVELS,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelWeb = val);
                }
              },
            ),
            SettingsDropdown<Level>(
              label: context.localizations.ota_update_label,
              value: _editingConfig!.log.levelOTA,
              items: Level.LEVELS,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelOTA = val);
                }
              },
            ),
            SettingsDropdown<Level>(
              label: context.localizations.hardware_frame_label,
              value: _editingConfig!.log.levelHwFrame,
              items: Level.LEVELS,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _editingConfig!.log.levelHwFrame = val);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _edit(Widget page) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
    _refreshDraft();
  }

  void _navigateToSlideshowEditor(BuildContext context) => _edit(
    SlideshowEditorPage(
      config: _editingConfig!.slideshow,
      registerDraft: _registerLocalDraft,
    ),
  );
  void _navigateToMqttEditor(BuildContext context) => _edit(
    MqttEditorPage(
      config: _editingConfig!.mqtt,
      registerDraft: _registerLocalDraft,
    ),
  );
  void _navigateToWebServerEditor(BuildContext context) => _edit(
    WebServerEditorPage(
      config: _editingConfig!.webServer,
      registerDraft: _registerLocalDraft,
    ),
  );
  void _navigateToWelcomeEditor(BuildContext context) => _edit(
    WelcomeEditorPage(
      config: _editingConfig!.welcome,
      registerDraft: _registerLocalDraft,
    ),
  );
  void _navigateToStorageSettings(BuildContext context) => _edit(
    StorageSettingsPage(
      config: _editingConfig!.storages,
      registerDraft: _registerLocalDraft,
    ),
  );
}
