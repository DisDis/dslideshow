import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/environment.dart' as environment;
import 'package:get_it/get_it.dart';

void getInjectorModule() {
  final localPath = environment.externalStorage;
  // Use this static instance
  final injector = GetIt.instance;
  injector
    ..registerSingleton<AppConfig>(new AppConfig.fromFile(localPath.path))
    ..registerSingleton<AppStorage>(new AppStorage(localPath.path));
}
