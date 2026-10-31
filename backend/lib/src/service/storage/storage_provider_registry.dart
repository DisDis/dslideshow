import 'package:dslideshow_backend/config.dart' show AppConfig;
import 'package:dslideshow_backend/src/command/drive_command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'cloud_storage.dart';
import 'storage.dart';
import 'storages_config.dart' as config;

/// Owns lazily created providers and activates only the selected storage.
///
/// The application owner invokes [init] and [release] once. Commands can
/// create inactive cloud providers for account setup without initializing them.
class StorageProviderRegistry {
  static final _log = Logger('StorageProviderRegistry');

  StorageProviderRegistry() : _injector = GetIt.instance, selectedType = GetIt.instance<AppConfig>().storages.selected;

  /// The provider selected by the applied application configuration.
  final config.StorageType selectedType;
  final GetIt _injector;
  final Map<config.StorageType, Storage> _providers = {};

  /// The selected instance, shared with commands addressed to that provider.
  Storage get selected => provider(selectedType);

  /// Returns the existing instance or creates it without calling its init.
  ///
  /// Throws [StateError] if no factory is registered for [type].
  Storage provider(config.StorageType type) => _providers.putIfAbsent(type, () {
    final storage = _injector.get<Storage>(param1: type);
    _log.fine('event=providerCreated provider=${type.name}');
    return storage;
  });

  /// Initializes only [selected], leaving other created providers inactive.
  Future<void> init() async {
    _log.info('event=initializationStarted provider=${selectedType.name}');
    try {
      await selected.init();
      _log.info('event=initializationCompleted provider=${selectedType.name}');
    } catch (error, stack) {
      _log.warning('event=initializationFailed provider=${selectedType.name} type=${error.runtimeType}', error, stack);
      rethrow;
    }
  }

  /// Routes [command] without activating the addressed provider.
  ///
  /// Unsupported providers and unexpected failures return a safe [ErrorResult]
  /// with the original command ID.
  Future<RpcResult> executeDriveCommand(DriveCommand command) async {
    final type = command.provider;
    _log.fine('event=driveCommandStarted provider=${type.name}');
    try {
      final storage = provider(type);
      if (storage is! CloudStorage) {
        _log.warning('event=driveCommandRejected provider=${type.name} reason=unsupported');
        return ErrorResult(id: command.id, error: 'Storage provider does not support cloud commands');
      }
      final result = await storage.executeDriveCommand(command);
      _log.fine('event=driveCommandCompleted provider=${type.name}');
      return result;
    } catch (error, stack) {
      _log.warning('event=driveCommandFailed provider=${type.name} type=${error.runtimeType}', error, stack);
      return ErrorResult(id: command.id, error: 'Drive provider command failed');
    }
  }

  /// Releases every created instance once, including inactive providers.
  ///
  /// All instances are released even if one fails; the first failure is
  /// rethrown after cleanup. The application must not use the registry afterward.
  Future<void> release() async {
    final instances = Map<Storage, config.StorageType>.identity();
    for (final entry in _providers.entries) {
      instances.putIfAbsent(entry.value, () => entry.key);
    }
    _log.info('event=releaseStarted providers=${instances.length}');
    Object? firstError;
    StackTrace? firstStack;
    var released = 0;
    for (final entry in instances.entries) {
      try {
        await entry.key.release();
        released++;
      } catch (error, stack) {
        firstError ??= error;
        firstStack ??= stack;
        _log.warning(
          'event=providerReleaseFailed provider=${entry.value.name} type=${error.runtimeType}',
          error,
          stack,
        );
      }
    }
    final failed = instances.length - released;
    final message = 'event=releaseCompleted providers=${instances.length} released=$released failed=$failed';
    failed == 0 ? _log.info(message) : _log.warning(message);
    if (firstError != null) Error.throwWithStackTrace(firstError, firstStack!);
  }
}
