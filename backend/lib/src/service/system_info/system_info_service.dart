import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:logging/logging.dart';
import 'dart:io' as io;

import 'network_info.dart';

class SystemInfoService{
  static final Logger _log = new Logger('SystemInfoService');
  final HardwareConfig _config;

  SystemInfoService(this._config);

  Future<bool> hasInternet()async {
    _log.info('hasInternet');
    try {
      var result = await io.Process.run('ping', ['-c', '1', '8.8.8.8']);
      if (result.exitCode == 0) {
        return !result.stdout.toString().contains('100% packet loss');
      }
    } catch (e, s) {
      _log.severe('hasInternet', e, s);
    }
    return false;
  }

  Future<Iterable<NetworkInterfaceInfo>> getNetworkInterfaces() async{
    _log.info('getNetworkInterfaces');
    try {
        var result = await io.Process.run(_config.systemIfConfigScript, []);
        if (result.exitCode == 0){
          return _parseIfconfigOutput(result.stdout.toString().split('\n\n'));
        }
    } catch (e, s) {
      _log.severe('getNetworkInterfaces', e, s);
    }
    return <NetworkInterfaceInfo>[];
  }

  final RegExp _findFlags = new RegExp('flags=[^<]*<[^>]*>');
  final RegExp _findIp4 = new RegExp('inet ([^ ]*)');
  final RegExp _findIp6 = new RegExp('inet6 ([^ ]*)');


  List<NetworkInterfaceInfo> _parseIfconfigOutput(List<String> output) {
    if (output == null || output.isEmpty){
      return <NetworkInterfaceInfo>[];
    }
    output.removeWhere((element) => element == null || element.isEmpty);
    var result = <NetworkInterfaceInfo>[];
    output.forEach((element) {
      try {
        var interfaceName = element.substring(0, element.indexOf(':'));
        var interfaceStatus = _findFlags.firstMatch(element).group(0).indexOf('RUNNING') != -1 ? NetworkInterfaceStatus
            .running : NetworkInterfaceStatus.offline;
        var interfaceIp4 = _findIp4.firstMatch(element);
        var interfaceIp4Str = interfaceIp4 == null? '' : interfaceIp4.groupCount == 1 ? interfaceIp4.group(1) : '';
        var interfaceIp6 = _findIp6.firstMatch(element);
        var interfaceIp6Str = interfaceIp6 == null? '' : interfaceIp6.groupCount == 1 ? interfaceIp6.group(1) : '';
        result.add(new NetworkInterfaceInfo((b) {
          b.name = interfaceName;
          b.status = interfaceStatus;
          b.ip4 = interfaceIp4Str;
          b.ip6 = interfaceIp6Str;
        }));
      } catch(e, st){
        _log.severe('_parseIfconfigOutput', e, st);
      }
    });
    return result;
  }
}

