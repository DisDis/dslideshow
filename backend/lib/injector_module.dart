import 'package:dslideshow_backend/config.dart';
//import 'package:dslideshow_server/universe_service/src/universe_service.dart';
//import 'package:dslideshow_server/world_service/src/world_service.dart';
//import 'package:crazy_pigs_common/game/service/round_generator_service.dart';
import 'package:dslideshow_common/injector/di.dart';

import 'src/service/hardware/hardware.dart';
//import 'package:dslideshow_server/result_service/src/db_service.dart';
//import 'package:dslideshow_server/result_service/src/result_service.dart';
//import 'package:dslideshow_server/web_server/web_server.dart';

Module getInjectorModule(){
  return
    new Module()
      ..bind(AppConfig, toFactory: () => new AppConfig())
      ..bind(AppStorage, toFactory: () => new AppStorage())
      ;
//      ..bind(HardwareService, toFactory: (AppConfig _config) => new HardwareService(_config), inject: <dynamic>[AppConfig]);
//      ..bind(WebServer, toFactory: (AppConfig _config, DBService _dbService) => new WebServer(_config, _dbService), inject: <dynamic>[AppConfig, DBService])
//      ..bind(DBService, toFactory: (AppConfig _config)=>new DBService(_config), inject: <dynamic>[AppConfig])
//      ..bind(ResultService, toFactory: (AppConfig _config, DBService _dbService) => new ResultService(_config, _dbService), inject: <dynamic>[AppConfig, DBService])
//      ..bind(RoundGeneratorService, toFactory: () => new RoundGeneratorService())
//      ..bind(WorldService, toFactory: (AppConfig _config, RoundGeneratorService _roundGeneratorService) => new WorldService(_config, _roundGeneratorService), inject: <dynamic>[AppConfig, RoundGeneratorService])
//      ..bind(UniverseService, toFactory: (AppConfig _config, DBService _dbService) => new UniverseService(_config, _dbService), inject: <dynamic>[AppConfig, DBService]);
}