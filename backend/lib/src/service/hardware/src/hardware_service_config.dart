import 'package:dslideshow_backend/config.dart';

class HardwareConfig  extends BaseConfig {
  int _simulationTime;
  int get simulationTime => _simulationTime ??= readInt("simulationTime", 4500);

  int _tickMs;
  int get tickMs => _tickMs ??= readInt("tickMs", 50);

  int _worldCount;
  int get worldCount =>  _worldCount ??= readInt("worldCount", 1);

  int _botsInGame;
  int get botsInGame =>  _botsInGame ??= readInt("botsInGame", 5);

  int _avatarCount;
  int get avatarCount =>  _avatarCount ??= readInt("avatarCount", 2);


  HardwareConfig(Map<String, dynamic> config) :super(config);
}