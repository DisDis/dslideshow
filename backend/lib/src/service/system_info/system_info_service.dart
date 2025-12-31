import 'dart:io' as io;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:logging/logging.dart';

class SystemInfoService {
  static final Logger _log = new Logger('SystemInfoService');

  static final RegExp _findHardware = new RegExp('Hardware *[^ ]*([^\n]*)');
  static final RegExp _findRevision = new RegExp('Revision *[^ ]*([^\n]*)');
  static final RegExp _findModel = new RegExp('Model *[^ ]*([^\n]*)');
  static final RegExp _findMem = new RegExp(
    'Mem:[ ]*([^ ]*)[ ]*([^ ]*)[ ]*([^ ]*)',
  );
  static final RegExp _findSwap = new RegExp(
    'Swap:[ ]*([^ ]*)[ ]*([^ ]*)[ ]*([^ ]*)',
  );

  SystemInfo? _lastInfo;

  final Duration _networkInfoUpdatePeriod = new Duration(minutes: 1);
  static final RegExp _findFlags = new RegExp('flags=[^<]*<[^>]*>');
  static final RegExp _findIp4 = new RegExp('inet ([^ ]*)');
  static final RegExp _findIp6 = new RegExp('inet6 ([^ ]*)');
  final HardwareConfig _config;

  SystemInfoService(this._config);

  Future<SystemInfo> getFullInfo() async {
    UpdateInfo updateInfo = await getUpdateInfo();
    if (_lastInfo == null) {
      final _cpuInfo = await _getCpuInfo();
      final _osInfo = await _getOSInfo();
      final _networkInfo = await _getNetworkInfo();
      _lastInfo = new SystemInfo(
        updateInfo: updateInfo,
        cpuInfo: _cpuInfo,
        osInfo: _osInfo,
        networkInfo: _networkInfo,
      );
    } else {
      var delta = new DateTime.now().difference(
        new DateTime.fromMillisecondsSinceEpoch(
          _lastInfo!.networkInfo.lastUpdate,
        ),
      );
      if (delta > _networkInfoUpdatePeriod) {
        final _networkInfo = await _getNetworkInfo();
        _lastInfo = _lastInfo?.copyWith(networkInfo: _networkInfo);
      }
      _lastInfo = _lastInfo?.copyWith(updateInfo: updateInfo);
    }
    return _lastInfo!;
  }

  Future<List<NetworkInterfaceInfo>> getNetworkInterfaces() async {
    //    _log.info('getNetworkInterfaces');
    try {
      var result = await io.Process.run(
        _config.systemIfConfigScript,
        [],
        environment: {'LC_ALL': 'C'},
      );
      if (result.exitCode == 0) {
        return _parseIfconfigOutput(result.stdout.toString().split('\n\n'));
      }
    } catch (e, s) {
      _log.severe('getNetworkInterfaces', e, s);
    }
    return <NetworkInterfaceInfo>[];
  }

  Future<UpdateInfo> getUpdateInfo() async {
    var b = UpdateInfo(
      lastUpdate: DateTime.now().millisecondsSinceEpoch,
      cpuLoad1: 1,
      cpuLoad5: 1,
      cpuLoad15: 1,
      memTotal: 1,
      memUsed: 1,
      swapTotal: 1,
      swapUsed: 1,
      diskUsedPercent: 0,
      diskUsed: 0,
      diskAvailable: 0,
      uptime: '',
      sensors: List.empty(),
    );

    try {
      var result = await io.Process.run('df', []);
      if (result.exitCode == 0) {
        var str = result.stdout.toString();
        var strArr = str.split('\n');
        var diskInfo = strArr.firstWhere(
          (element) => element.startsWith(_config.systemDiskDev),
          orElse: () => '',
        );
        if (diskInfo.isNotEmpty) {
          var parseDiskInfo = RegExp(
            '${_config.systemDiskDev} *([^ ]*) *([^ ]*) *([^ ]*) *([^ %]*)',
          );
          //  Файл.система   Размер Использовано  Дост Использовано% Cмонтировано в

          var info = parseDiskInfo.firstMatch(diskInfo)!;
          b = b.copyWith(
            diskUsed: int.tryParse(info.group(2)!) ?? 0,
            diskAvailable: int.tryParse(info.group(3)!) ?? 0,
            diskUsedPercent: int.tryParse(info.group(4)!) ?? 0,
          );
        }
      }
      result = await io.Process.run('uptime', ['-p']);
      if (result.exitCode == 0) {
        b = b.copyWith(uptime: result.stdout.toString());
      }

      //LC_ALL=C free
      result = await io.Process.run('free', [], environment: {'LC_ALL': 'C'});
      if (result.exitCode == 0) {
        var str = result.stdout.toString();
        //              total        used        free
        var info = _findMem.firstMatch(str)!;
        var infoSwap = _findSwap.firstMatch(str)!;

        b = b.copyWith(
          memTotal: int.tryParse(info.group(1)!) ?? 0,
          memUsed: int.tryParse(info.group(2)!) ?? 0,
          swapTotal: int.tryParse(infoSwap.group(1)!) ?? 0,
          swapUsed: int.tryParse(infoSwap.group(2)!) ?? 0,
        );
      }
      result = await io.Process.run('cat', ['/proc/loadavg']);
      if (result.exitCode == 0) {
        var str = result.stdout.toString();
        var arrData = str.split(' ');
        b = b.copyWith(
          cpuLoad1: double.tryParse(arrData[0]) ?? 0,
          cpuLoad5: double.tryParse(arrData[1]) ?? 0,
          cpuLoad15: double.tryParse(arrData[2]) ?? 0,
        );
      }
      //  _log.info(b.build());
    } catch (e, s) {
      _log.severe('getUpdateInfo', e, s);
    }
    b = b.copyWith(sensors: await _getSensorInfo());

    return b;
  }

  Future<bool> hasInternet() async {
    //    _log.info('hasInternet');
    try {
      var result = await io.Process.run(
        'ping',
        ['-c', '1', '8.8.8.8'],
        environment: {'LC_ALL': 'C'},
      );
      if (result.exitCode == 0) {
        return !result.stdout.toString().contains('100% packet loss');
      }
    } catch (e, s) {
      _log.severe('hasInternet', e, s);
    }
    return false;
  }

  Future<SystemInfo?> init() {
    return getFullInfo();
  }

  Future<CpuInfo> _getCpuInfo() async {
    //    _log.info('_getCpuInfo');
    var b = new CpuInfo(cores: 0, hardware: '', model: '', revision: '');

    try {
      var result = await io.Process.run('nproc', ['--all']);
      if (result.exitCode == 0) {
        b = b.copyWith(cores: int.tryParse(result.stdout.toString()) ?? 0);
      }

      result = await io.Process.run('cat', ['/proc/cpuinfo']);
      if (result.exitCode == 0) {
        var str = result.stdout.toString();
        b = b.copyWith(
          hardware: _findHardware.firstMatch(str)?.group(1) ?? 'Unknown',
          model: _findModel.firstMatch(str)?.group(1) ?? 'Unknown',
          revision: _findRevision.firstMatch(str)?.group(1) ?? 'Unknown',
        );
      }
      //      _log.info(b.build());
    } catch (e, s) {
      _log.severe('_getCpuInfo', e, s);
    }
    return b;
  }

  Future<NetworkInfo> _getNetworkInfo() async {
    return NetworkInfo(
      lastUpdate: new DateTime.now().millisecondsSinceEpoch,
      interfaces: await getNetworkInterfaces(),
      hasInternet: await hasInternet(),
    );
  }

  Future<OSInfo> _getOSInfo() async {
    var b = OSInfo(name: '', osType: OSType.unknown);
    try {
      var result = await io.Process.run('uname', ['-a']);
      if (result.exitCode == 0) {
        final osInfo = result.stdout.toString().replaceAll('\n', '');
        b = b.copyWith(name: osInfo, osType: _resolveOSType(osInfo));
      }
      //  _log.info(b.build());
    } catch (e, s) {
      _log.severe('_getOSInfo', e, s);
    }
    return b;
  }

  Future<List<SensorInfo>> _getSensorInfo() async {
    var result = <SensorInfo>[];
    //  vcgencmd measure_temp
    try {
      //'vcgencmd', ['measure_temp'],
      var resultCommand = await io.Process.run(
        _config.sensorsScript,
        [],
        environment: {'LC_ALL': 'C'},
      );
      //temp=61.3'C
      if (resultCommand.exitCode == 0) {
        //temp=49.0'C
        var arr = resultCommand.stdout.toString().split('=');
        result.add(SensorInfo(name: arr[0], value: arr[1]));
      }
    } catch (e, s) {
      _log.severe('_getSensorInfo', e, s);
    }

    return result;
  }

  List<NetworkInterfaceInfo> _parseIfconfigOutput(List<String> output) {
    if (output.isEmpty) {
      return <NetworkInterfaceInfo>[];
    }
    output.removeWhere((element) => element.isEmpty);
    var result = <NetworkInterfaceInfo>[];
    output.forEach((element) {
      try {
        var interfaceName = element.substring(0, element.indexOf(':'));
        var interfaceStatus =
            _findFlags.firstMatch(element)!.group(0)!.indexOf('RUNNING') != -1
            ? NetworkInterfaceStatus.running
            : NetworkInterfaceStatus.offline;
        var interfaceIp4 = _findIp4.firstMatch(element);
        var interfaceIp4Str = interfaceIp4 == null
            ? ''
            : interfaceIp4.groupCount == 1
            ? interfaceIp4.group(1)
            : '';
        var interfaceIp6 = _findIp6.firstMatch(element);
        var interfaceIp6Str = interfaceIp6 == null
            ? ''
            : interfaceIp6.groupCount == 1
            ? interfaceIp6.group(1)
            : '';
        result.add(
          NetworkInterfaceInfo(
            name: interfaceName,
            status: interfaceStatus,
            ip4: interfaceIp4Str ?? '',
            ip6: interfaceIp6Str ?? '',
          ),
        );
      } catch (e, st) {
        _log.severe('_parseIfconfigOutput', e, st);
      }
    });
    return result;
  }

  OSType _resolveOSType(String osInfo) {
    if (osInfo.toLowerCase().contains('linux')) {
      return OSType.linux;
    }

    if (osInfo.toLowerCase().contains('darwin')) {
      return OSType.ios;
    }

    return OSType.unknown;
  }
}
