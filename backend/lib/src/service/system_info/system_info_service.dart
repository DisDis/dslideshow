import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/system_info/cpu_info.dart';
import 'package:dslideshow_backend/src/service/system_info/sensor_info.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_backend/src/service/system_info/update_info.dart';
import 'package:logging/logging.dart';
import 'dart:io' as io;

import 'network_info.dart';
import 'os_info.dart';

class SystemInfoService{
  static final Logger _log = new Logger('SystemInfoService');
  final HardwareConfig _config;

  SystemInfoService(this._config);

  SystemInfo _lastInfo;

  final Duration _networkInfoUpdatePeriod = new Duration(minutes: 1);

  Future<SystemInfo> getFullInfo() async{
    UpdateInfoBuilder updateInfo = await getUpdateInfo();
    if (_lastInfo == null){
      final _cpuInfo = await _getCpuInfo();
      final _osInfo = await _getOSInfo();
      final _networkInfo = await _getNetworkInfo();
      _lastInfo = new SystemInfo((b){
        b.updateInfo = updateInfo;
        b.cpuInfo = _cpuInfo;
        b.osInfo = _osInfo;
        b.networkInfo = _networkInfo;
      });
    } else {
      var delta = new DateTime.now().difference(_lastInfo.networkInfo.lastUpdate);
      if (delta >  _networkInfoUpdatePeriod ){
        final _networkInfo = await _getNetworkInfo();
        _lastInfo = _lastInfo.rebuild((builder) => builder.networkInfo = _networkInfo);
      }
      _lastInfo = _lastInfo.rebuild((builder) => builder.updateInfo = updateInfo);
    }
    return _lastInfo;
  }

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


  static final RegExp _findHardware = new RegExp('Hardware *[^ ]*([^\n]*)');
  static final RegExp _findRevision = new RegExp('Revision *[^ ]*([^\n]*)');
  static final RegExp _findModel = new RegExp('Model *[^ ]*([^\n]*)');

  static final RegExp _findMem = new RegExp('Mem:[ ]*([^ ]*)[ ]*([^ ]*)[ ]*([^ ]*)');
  static final RegExp _findSwap = new RegExp('Swap:[ ]*([^ ]*)[ ]*([^ ]*)[ ]*([^ ]*)');

  Future<UpdateInfoBuilder> getUpdateInfo() async{
    final b = new UpdateInfoBuilder();
    b.lastUpdate = new DateTime.now();
    b.cpuLoad1 = 1;
    b.cpuLoad5 = 1;
    b.cpuLoad15 = 1;
    b.memTotal = 1;
    b.memUsed = 1;
    b.swapTotal = 1;
    b.swapUsed = 1;
    b.diskUsedPercent = '';
    b.diskUsed = '';
    b.diskAvail = '';
    b.uptime = '';


    try {
      var result = await io.Process.run('df', ['-h']);
      if (result.exitCode == 0){
        var str = result.stdout.toString();
        var strArr = str.split('\n');
        var diskInfo = strArr.firstWhere((element) => element.startsWith(_config.systemDiskDev),orElse: ()=>'');
        if (diskInfo.isNotEmpty) {
          var parseDiskInfo = RegExp('${_config.systemDiskDev} *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)');
          //Файл.система   Размер Использовано  Дост Использовано% Cмонтировано в
          var info = parseDiskInfo.firstMatch(diskInfo);
          b.diskUsed = info.group(2);
          b.diskAvail = info.group(3);
          b.diskUsedPercent = info.group(4);
        }
      }
      result = await io.Process.run('uptime', ['-p']);
      if (result.exitCode == 0){
        b.uptime = result.stdout.toString();
      }
      //LC_ALL=C free
      result = await io.Process.run('free', [] , environment:{'LC_ALL': 'C'});
      if (result.exitCode == 0){
        var str = result.stdout.toString();
        //              total        used        free
        var info = _findMem.firstMatch(str);
        b.memTotal = int.tryParse(info.group(1));
        b.memUsed = int.tryParse(info.group(2));
        info = _findSwap.firstMatch(str);
        b.swapTotal = int.tryParse(info.group(1));
        b.swapUsed = int.tryParse(info.group(2));
      }
      result = await io.Process.run('cat', ['/proc/loadavg'] );
      if (result.exitCode == 0) {
        var str = result.stdout.toString();
        var arrData = str.split(' ');
        b.cpuLoad1 = double.tryParse(arrData[0]);
        b.cpuLoad5 = double.tryParse(arrData[1]);
        b.cpuLoad15 = double.tryParse(arrData[2]);
      }
      _log.info(b.build());
    } catch (e, s) {
      _log.severe('_getCpuInfo', e, s);
    }
    b.sensors.addAll( await  _getSensorInfo() );

    return b;
  }

  Future<CpuInfoBuilder>_getCpuInfo() async{
    _log.info('_getCpuInfo');
    final b = new CpuInfoBuilder();
    b.cores = 0;
    b.hardware = '';
    b.model = '';
    b.revision = '';

    try {
      var result = await io.Process.run('nproc', ['--all']);
      if (result.exitCode == 0){
        b.cores =  int.tryParse(result.stdout.toString());
      }

      result = await io.Process.run('cat', ['/proc/cpuinfo']);
      if (result.exitCode == 0){
        var str = result.stdout.toString();
        b.hardware = _findHardware.firstMatch(str).group(1);
        b.model = _findModel.firstMatch(str).group(1);
        b.revision = _findRevision.firstMatch(str).group(1);
      }
      _log.info(b.build());
    } catch (e, s) {
      _log.severe('_getCpuInfo', e, s);
    }
    return b;
  }
  Future<OSInfoBuilder>_getOSInfo() async{
    final b = new OSInfoBuilder();
    b.name = '';
    try {
      var result = await io.Process.run('uname', ['-a']);
      if (result.exitCode == 0){
        b.name = result.stdout.toString();
      }
      _log.info(b.build());
    } catch (e, s) {
      _log.severe('_getOSInfo', e, s);
    }
    return b;
  }
  Future<NetworkInfoBuilder>_getNetworkInfo() async{
    final b = new NetworkInfoBuilder();
    b.lastUpdate = new DateTime.now();
    b.interfaces.addAll(await getNetworkInterfaces());
    b.hasInternet = await hasInternet();
    return b;
  }

  Future<Iterable<SensorInfo>>_getSensorInfo() async{
    var result = <SensorInfo>[];
    //vcgencmd measure_temp
    try {
      var resultCommand = await io.Process.run('vcgencmd', ['measure_temp']);
      if (resultCommand.exitCode == 0){
        final b = new SensorInfoBuilder();
        //temp=49.0'C
        var arr = resultCommand.stdout.toString().split('=');
        b.name = arr[0];
        b.value = arr[1];
        result.add(b.build());
      }
    } catch (e, s) {
      _log.severe('_getSensorInfo', e, s);
    }

    return result;
  }
}

