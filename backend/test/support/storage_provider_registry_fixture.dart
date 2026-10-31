import 'package:dslideshow_backend/config.dart' show AppConfig;
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_provider_registry.dart';
import 'package:dslideshow_backend/src/service/storage/storages_config.dart' as config;
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

StorageProviderRegistry createStorageProviderRegistry({
  required config.StorageType selectedType,
  required Map<config.StorageType, Storage Function()> factories,
}) {
  final locator = GetIt.instance;
  final previousDebugOutput = GetIt.noDebugOutput;
  locator.pushNewScope(
    init: (scope) {
      scope.registerSingleton<AppConfig>(
        AppConfig.fromJson({
          'storages': {'selected': selectedType.name, 'storages': <String, dynamic>{}},
        }),
      );
      scope.registerFactoryParam<Storage, config.StorageType, void>((type, _) {
        final create = factories[type];
        if (create == null) throw StateError('Storage provider is unavailable');
        return create();
      });
    },
  );
  // Expected factory failures are checked through the registry's safe logger.
  GetIt.noDebugOutput = true;
  addTearDown(() async {
    try {
      await locator.popScope();
    } finally {
      GetIt.noDebugOutput = previousDebugOutput;
    }
  });
  return StorageProviderRegistry();
}
