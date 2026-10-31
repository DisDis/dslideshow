import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/config/data/repository/yandex_drive_repository.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'yandex_drive_settings.dart';

class StorageSettingsCubit extends Cubit<StorageType> {
  StorageSettingsCubit(this.config) : super(config.selected);
  final StoragesConfig config;

  void select(StorageType value) {
    config.selected = value;
    config.getOrCreateEmpty(value);
    emit(value);
  }
}

class StorageSettingsPage extends StatelessWidget {
  final StoragesConfig config;
  final RegisterUnsavedDraft? registerDraft;
  final YandexDriveRepository? yandexRepository;
  const StorageSettingsPage({super.key, required this.config, this.registerDraft, this.yandexRepository});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => StorageSettingsCubit(config),
    child: BlocBuilder<StorageSettingsCubit, StorageType>(
      builder: (context, currentType) => _build(context, currentType),
    ),
  );

  Widget _build(BuildContext context, StorageType currentType) {
    final l = context.localizations;
    return Scaffold(
      appBar: AppBar(title: Text(l.storage_settings_title)),
      body: SettingsContent(
        maxWidth: 760,
        child: DraftEditorForm(
          registerDraft: registerDraft,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(l.config_editor_draft_hint, style: Theme.of(context).textTheme.bodySmall),
              ),
              SettingsSection(
                title: l.active_storage_label,
                icon: Icons.layers_outlined,
                children: [
                  SettingsDropdown<StorageType>(
                    label: l.provider_label,
                    value: currentType,
                    items: StorageType.values,
                    itemLabelBuilder: (type) => switch (type) {
                      StorageType.DiskStorage => l.local_disk_label,
                      StorageType.GPhotoStorage => l.google_photos_label,
                      StorageType.YandexDriveStorage => l.yandex_drive_label,
                    },
                    onChanged: (value) {
                      if (value == null) return;
                      context.read<StorageSettingsCubit>().select(value);
                    },
                  ),
                ],
              ),
              _buildSpecificStorageForm(context, currentType),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecificStorageForm(BuildContext context, StorageType currentType) {
    final storageConfig = config.getOrCreateEmpty(currentType);
    return switch (storageConfig) {
      YandexDriveStorageConfig() =>
        yandexRepository == null
            ? Padding(padding: const EdgeInsets.all(20), child: Text(context.localizations.yandex_load_failed))
            : YandexDriveSettings(
                config: storageConfig,
                repository: yandexRepository!,
                onChanged: (value) => config.storages[StorageType.YandexDriveStorage] = value,
              ),
      GPhotoStorageConfig() => _GPhotoForm(config: storageConfig),
      DiskStorageConfig() => SettingsSection(
        title: context.localizations.local_disk_label,
        icon: Icons.folder_outlined,
        children: [
          ListTile(
            title: Text(context.localizations.no_configuration_needed_for_local_disk),
            leading: const Icon(Icons.info_outline),
          ),
        ],
      ),
      _ => Padding(
        padding: const EdgeInsets.all(20),
        child: Text(context.localizations.unknown_storage_type_configuration),
      ),
    };
  }
}

class _GPhotoForm extends StatelessWidget {
  final GPhotoStorageConfig config;
  const _GPhotoForm({required this.config});

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    Widget number(String label, int value, ValueChanged<int> apply, {String? unit}) => SettingsTextField(
      label: label,
      initialValue: value.toString(),
      suffixText: unit,
      isNumber: true,
      validator: (text) {
        final parsed = int.tryParse(text ?? '');
        return parsed != null && parsed > 0 ? null : l.invalid_positive_integer;
      },
      onChanged: (text) {
        final parsed = int.tryParse(text);
        if (parsed != null && parsed > 0) apply(parsed);
      },
    );
    return Column(
      children: [
        SettingsSection(
          title: l.authentication_title,
          icon: Icons.security_outlined,
          children: [
            SettingsTextField(
              label: l.auth_refresh_token_label,
              initialValue: config.refreshToken,
              obscureText: true,
              onChanged: (value) => config.refreshToken = value,
            ),
            SettingsTextField(
              label: l.client_id_label,
              initialValue: config.clientId.identifier,
              onChanged: (value) => config.clientId.identifier = value,
            ),
            SettingsTextField(
              label: l.client_secret_label,
              initialValue: config.clientId.secret,
              obscureText: true,
              onChanged: (value) => config.clientId.secret = value,
            ),
          ],
        ),
        SettingsSection(
          title: l.sync_settings_title,
          icon: Icons.sync,
          children: [
            number(
              l.sync_period_label,
              config.syncPeriod.inMinutes,
              (value) => config.syncPeriod = Duration(minutes: value),
              unit: l.minutes_unit,
            ),
            number(l.image_width_label, config.imageWidth, (value) => config.imageWidth = value, unit: l.pixels_unit),
            number(
              l.image_height_label,
              config.imageHeight,
              (value) => config.imageHeight = value,
              unit: l.pixels_unit,
            ),
          ],
        ),
        SettingsSection(
          title: l.albums_title,
          icon: Icons.photo_album_outlined,
          children: [
            SettingsTextField(
              label: l.album_names_label,
              initialValue: config.albumNames.join(', '),
              onChanged: (value) => config.albumNames = value
                  .split(',')
                  .map((item) => item.trim())
                  .where((item) => item.isNotEmpty)
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
