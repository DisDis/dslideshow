import 'package:dslideshow_backend/config.dart';
import 'package:get_it/get_it.dart';

void getInjectorModule() {
  // Use this static instance
  final injector = GetIt.instance;
  injector
    ..registerSingleton<AppConfig>(new AppConfig.fromFile())
    ..registerSingleton<AppStorage>(new AppStorage());
}
