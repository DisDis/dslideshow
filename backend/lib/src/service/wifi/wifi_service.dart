import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'dart:io' as io;

import 'package:logging/logging.dart';

class WiFiService {
  static final Logger _log = new Logger('WiFiService');
  final WiFiConfig _config;
  WiFiService(this._config);

  Future<List<WiFiNetworkInfo>> scan() async {
    _log.info('scan');
    try {
      var result = await io.Process.run(_config.scanWiFiScript, [_config.devId], environment: {'LC_ALL': 'C'});
      if (result.exitCode == 0) {
        return parseScanOutput(result.stdout.toString());
      }
    } catch (e, s) {
      _log.severe('scan', e, s);
    }
    return <WiFiNetworkInfo>[];
  }

  static const EMPTY_SSID = r'$$$$$!@  EMPTY SSID #$%^$$$$';
  static const KEY_SSID = 'SSID: ';
  static const KEY_SIGNAL = 'signal: ';
  static const KEY_CAPABILITY = 'capability: ';
  static const KEY_FREQ = 'freq: ';

  void addNetwork(String SSID, String psk) async {
    _log.info('addNetwork "$SSID"');
    try {
/*
wpa_cli doesn't work
 */

      final newNetworkData = """
network={
	ssid="${SSID}"
	psk="${psk}"
}
""";
      final wpaData = io.File('/etc/wpa_supplicant/wpa_supplicant.conf').readAsStringSync() + newNetworkData;

      io.File('/etc/wpa_supplicant/wpa_supplicant.conf').writeAsStringSync(wpaData);
    } catch (e, s) {
      _log.severe('addNetwork "$SSID"', e, s);
      throw e;
    }
  }

  void enableNetwork(int networkId) async {
    _log.info('enableNetwork "$networkId"');
    try {
/*
wpa_cli enable_network <id>
 */

      var result = await io.Process.run('wpa_cli', ['-i', _config.devId, 'enable_network', '$networkId'], environment: {'LC_ALL': 'C'});
      _log.info("wpa_cli enable_network -> '${result.stdout.toString()}'");
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli enable_network $networkId -> exitCode: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('enableNetwork "$networkId"', e, s);
      throw e;
    }
  }

  void disableNetwork(int networkId) async {
    _log.info('disableNetwork "$networkId"');
    try {
/*
wpa_cli disable_network <id>
 */

      var result = await io.Process.run('wpa_cli', ['-i', _config.devId, 'disable_network', '$networkId'], environment: {'LC_ALL': 'C'});
      _log.info("wpa_cli disable_network -> '${result.stdout.toString()}'");
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli disable_network $networkId -> exitCode: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('disableNetwork "$networkId"', e, s);
      throw e;
    }
  }

  void saveConfig() async {
    _log.info('saveConfig');
    try {
      var result = await io.Process.run('wpa_cli', ['-i', _config.devId, 'save_config'], environment: {'LC_ALL': 'C'});
      _log.info("wpa_cli save_config -> '${result.stdout.toString()}'");
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli save_config -> exitCode: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('saveConfig', e, s);
      throw e;
    }
  }

  void removeNetwork(int networkId) async {
    _log.info('removeNetwork "$networkId"');
    try {
      var result = await io.Process.run('wpa_cli', ['-i', _config.devId, 'remove_network', '$networkId'], environment: {'LC_ALL': 'C'});
      _log.info("wpa_cli remove_network -> '${result.stdout.toString()}'");
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli remove_network $networkId -> exitCode: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('removeNetwork "$networkId"', e, s);
      throw e;
    }
  }

  List<WiFiNetworkInfo> parseScanOutput(String outputStr) {
    List<String> output = outputStr.split('\n');
    if (output.isEmpty) {
      return <WiFiNetworkInfo>[];
    }
    output.removeWhere((element) => element.isEmpty);
    var result = <WiFiNetworkInfo>[];
    var current = WiFiNetworkInfo(
      SSID: EMPTY_SSID,
      signal: -99,
      capability: '',
      freq: -1,
    );

// SSID: Koti783
// signal: -82.00 dBm
// capability: ESS Privacy ShortPreamble SpectrumMgmt ShortSlotTime (0x0531)
// freq: 2437

    output.forEach((element) {
      try {
        int tmpI;
        if ((tmpI = element.indexOf(KEY_SSID)) != -1) {
          if (current.SSID != EMPTY_SSID) {
            result.add(current);
            current = WiFiNetworkInfo(
              SSID: EMPTY_SSID,
              signal: -99,
              capability: '',
              freq: -1,
            );
          }
          current = current.copyWith(SSID: element.substring(tmpI + KEY_SSID.length));
        } else if ((tmpI = element.indexOf(KEY_SIGNAL)) != -1) {
          final signalStr = element.substring(tmpI + KEY_SIGNAL.length);
          final signalInt = int.tryParse(signalStr.substring(0, signalStr.indexOf('.')));
          current = current.copyWith(signal: signalInt ?? -99);
        } else if ((tmpI = element.indexOf(KEY_CAPABILITY)) != -1) {
          current = current.copyWith(capability: element.substring(tmpI + KEY_CAPABILITY.length));
        } else if ((tmpI = element.indexOf(KEY_FREQ)) != -1) {
          current = current.copyWith(freq: int.tryParse(element.substring(tmpI + KEY_FREQ.length)) ?? -1);
        }
      } catch (e, st) {
        _log.severe('_parseScanOutput', e, st);
      }
    });
    if (current.SSID != EMPTY_SSID) {
      result.add(current);
    }
    return result;
  }

  Future<List<WiFiStoredNetworkInfo>> getStored() async {
    _log.info('getStored');
    try {
      var result = await io.Process.run('wpa_cli', ['-i', _config.devId, 'list_networks'], environment: {'LC_ALL': 'C'});
      if (result.exitCode == 0) {
        return parseStoredOutput(result.stdout.toString());
      } else {
        throw Exception('wpa_cli list_networks -> exit code: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('getStored', e, s);
      throw e;
    }
  }

  List<WiFiStoredNetworkInfo> parseStoredOutput(String outputStr) {
    List<String> output = outputStr.split('\n');
    if (output.isEmpty) {
      return <WiFiStoredNetworkInfo>[];
    }
    output.removeWhere((element) => element.isEmpty);
    var result = <WiFiStoredNetworkInfo>[];
/*
Selected interface 'p2p-dev-wlan0'
network id / ssid / bssid / flags
0\tJazzir_5G\tany	
1\tJazzir_2G\tany	
 */

    output.forEach((element) {
      try {
        if (element.indexOf('\t') == -1) {
          return;
        }
        var args = element.split('\t');
        if (args.length > 3) {
          result.add(WiFiStoredNetworkInfo(
            id: int.tryParse(args[0]) ?? -1,
            SSID: args[1],
            disabled: args[3].contains('DISABLED'),
          ));
        }
      } catch (e, st) {
        _log.severe('_parseStoredOutput', e, st);
      }
    });

    return result;
  }
}
