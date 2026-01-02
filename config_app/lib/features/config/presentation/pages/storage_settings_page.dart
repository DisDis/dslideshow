import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_backend/config.dart'; // Ваши конфиги
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/storages_config.dart';



class StorageSettingsPage extends StatefulWidget {
  final StoragesConfig config;

  const StorageSettingsPage({Key? key, required this.config}) : super(key: key);

  @override
  State<StorageSettingsPage> createState() => _StorageSettingsPageState();
}

class _StorageSettingsPageState extends State<StorageSettingsPage> {
  late StorageType _currentType;

  @override
  void initState() {
    super.initState();
    _currentType = widget.config.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage Settings')),
      body: ListView(
        children: [
          // 1. Выбор типа хранилища
          SettingsSection(
            title: 'Active Storage',
            icon: Icons.layers,
            children: [
              SettingsDropdown<StorageType>(
                label: 'Provider',
                value: _currentType,
                items: StorageType.values,
                itemLabelBuilder: (type) {
                  switch (type) {
                    case StorageType.DiskStorage: return 'Local Disk';
                    case StorageType.GPhotoStorage: return 'Google Photos';
                  }
                },
                onChanged: (StorageType? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _currentType = newValue;
                      // Обновляем главный конфиг
                      widget.config.selected = newValue;
                      // Гарантируем, что конфиг для этого типа существует
                      widget.config.getOrCreateEmpty(newValue);
                    });
                  }
                },
              ),
            ],
          ),

          // 2. Динамическая форма настроек
          // Мы передаем конкретный под-конфиг в соответствующий виджет
          _buildSpecificStorageForm(),
        ],
      ),
    );
  }

  Widget _buildSpecificStorageForm() {
    // Получаем (или создаем) конфиг для текущего выбранного типа
    final specificConfig = widget.config.getOrCreateEmpty(_currentType);

    switch (_currentType) {
      case StorageType.GPhotoStorage:
        if (specificConfig is GPhotoStorageConfig) {
          return _GPhotoForm(config: specificConfig);
        }
        break;
      case StorageType.DiskStorage:
        if (specificConfig is DiskStorageConfig) {
          return _DiskStorageForm(config: specificConfig);
        }
        break;
    }

    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Unknown storage type configuration'),
    );
  }
}

// --- Форма для Google Photos ---
class _GPhotoForm extends StatefulWidget {
  final GPhotoStorageConfig config;
  const _GPhotoForm({required this.config});

  @override
  State<_GPhotoForm> createState() => _GPhotoFormState();
}

class _GPhotoFormState extends State<_GPhotoForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSection(
          title: 'Authentication',
          icon: Icons.security,
          children: [
            SettingsTextField(
              label: 'Refresh Token',
              initialValue: widget.config.refreshToken,
              onChanged: (val) => widget.config.refreshToken = val,
            ),
            SettingsTextField(
              label: 'Client ID',
              initialValue: widget.config.clientId.identifier,
              onChanged: (val) => widget.config.clientId.identifier = val,
            ),
            SettingsTextField(
              label: 'Client Secret',
              initialValue: widget.config.clientId.secret,
              onChanged: (val) => widget.config.clientId.secret = val,
            ),
          ],
        ),
        SettingsSection(
          title: 'Sync Settings',
          icon: Icons.sync,
          children: [
            SettingsTextField(
              label: 'Sync Period (Minutes)',
              isNumber: true,
              // Конвертируем Duration в минуты для удобства пользователя
              initialValue: (widget.config.syncPeriod.inSeconds / 60).round().toString(),
              onChanged: (val) {
                final minutes = int.tryParse(val) ?? 60;
                widget.config.syncPeriod = Duration(minutes: minutes);
              },
            ),
             SettingsTextField(
              label: 'Image Width (px)',
              isNumber: true,
              initialValue: widget.config.imageWidth.toString(),
              onChanged: (val) => widget.config.imageWidth = int.tryParse(val) ?? 2560,
            ),
            SettingsTextField(
              label: 'Image Height (px)',
              isNumber: true,
              initialValue: widget.config.imageHeight.toString(),
              onChanged: (val) => widget.config.imageHeight = int.tryParse(val) ?? 1600,
            ),
          ],
        ),
        SettingsSection(
          title: 'Albums',
          icon: Icons.photo_album,
          children: [
            // Редактируем список альбомов как строку через запятую для простоты,
            // либо можно использовать SettingsMultiSelect, если есть список доступных.
            SettingsTextField(
              label: 'Album Names (comma separated)',
              initialValue: widget.config.albumNames.join(', '),
              onChanged: (val) {
                // Разбиваем строку обратно в список
                widget.config.albumNames = val
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
              },
            ),
          ],
        ),
      ],
    );
  }
}

// --- Форма для Local Disk ---
class _DiskStorageForm extends StatelessWidget {
  final DiskStorageConfig config;
  const _DiskStorageForm({required this.config});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Local Disk Settings',
      icon: Icons.folder,
      children: const [
        // В вашем DiskStorageConfig пока нет полей, но они появятся здесь
        ListTile(
          title: Text('No configuration needed for local disk yet.'),
          leading: Icon(Icons.info_outline, color: Colors.grey),
        )
      ],
    );
  }
}