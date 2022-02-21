import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'dart:io' as io;

import 'package:logging/logging.dart';

class WiFiService {
  static final Logger _log = new Logger('WiFiService');
  final WiFiConfig _config;
  WiFiService(this._config);

  Future<Iterable<WiFiNetworkInfo>> scan() async {
    _log.info('scan');
    try {
      var result = await io.Process.run(_config.scanWiFiScript, [_config.devId], environment: {'LC_ALL': 'C'});
      if (result.exitCode == 0) {
        return _parseScanOutput(result.stdout.toString().split('\n\n'));
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
wpa_cli add_network 
wpa_cli set_network <id> ssid "Jazzir_2G"
wpa_cli set_network <id> psk "password"
wpa_cli enable_network <id>

 */

      var result = await io.Process.run('wpa_cli', ['add_network'], environment: {'LC_ALL': 'C'});
      if (result.exitCode != 0) {
        throw Exception('wpa_cli add_network -> exitCode: ${result.exitCode}');
      }
      var newNetworkOutput = result.stdout.toString().split('\n\n');
      final networkId = int.parse(newNetworkOutput.last);
      result = await io.Process.run('wpa_cli', ['set_network', '$networkId', 'ssid', '"$SSID"'],
          environment: {'LC_ALL': 'C'});
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli set_network $networkId ssid "$SSID" -> exitCode: ${result.exitCode}');
      }
      result =
          await io.Process.run('wpa_cli', ['set_network', '$networkId', 'psk', '"$psk"'], environment: {'LC_ALL': 'C'});
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli set_network $networkId psk "**....**" -> exitCode: ${result.exitCode}');
      }
      enableNetwork(networkId);
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

      var result = await io.Process.run('wpa_cli', ['enable_network', '$networkId'], environment: {'LC_ALL': 'C'});
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

      var result = await io.Process.run('wpa_cli', ['disable_network', '$networkId'], environment: {'LC_ALL': 'C'});
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
      var result = await io.Process.run('wpa_cli', ['save_config'], environment: {'LC_ALL': 'C'});
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
      var result = await io.Process.run('wpa_cli', ['remove_network', '$networkId'], environment: {'LC_ALL': 'C'});
      if (result.exitCode != 0 || result.stdout.toString().indexOf('OK') == -1) {
        throw Exception('wpa_cli remove_network $networkId -> exitCode: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('removeNetwork "$networkId"', e, s);
      throw e;
    }
  }

  List<WiFiNetworkInfo> _parseScanOutput(List<String> output) {
    if (output.isEmpty) {
      return <WiFiNetworkInfo>[];
    }
    output.removeWhere((element) => element.isEmpty);
    var result = <WiFiNetworkInfo>[];
    var current = WiFiNetworkInfoBuilder()..SSID = EMPTY_SSID;

// SSID: Koti783
// signal: -82.00 dBm
// capability: ESS Privacy ShortPreamble SpectrumMgmt ShortSlotTime (0x0531)
// freq: 2437

    output.forEach((element) {
      try {
        //_findHardware.firstMatch(str)?.group(1) ?? 'Unknown';
        if (element.startsWith(KEY_SSID)) {
          if (current.SSID != EMPTY_SSID) {
            result.add(current.build());
            current = WiFiNetworkInfoBuilder()..SSID = EMPTY_SSID;
          }
          current.SSID = element.substring(KEY_SSID.length);
        } else if (element.startsWith(KEY_SIGNAL)) {
          current.signal = element.substring(KEY_SIGNAL.length);
        } else if (element.startsWith(KEY_CAPABILITY)) {
          current.capability = element.substring(KEY_CAPABILITY.length);
        } else if (element.startsWith(KEY_FREQ)) {
          current.freq = int.tryParse(element.substring(KEY_FREQ.length)) ?? -1;
        }
      } catch (e, st) {
        _log.severe('_parseScanOutput', e, st);
      }
    });
    if (current.SSID != EMPTY_SSID) {
      result.add(current.build());
    }
    return result;
  }

  Future<Iterable<WiFiStoredNetworkInfo>> getStored() async {
    _log.info('getStored');
    try {
      var result = await io.Process.run('wpa_cli', ['list_networks'], environment: {'LC_ALL': 'C'});
      if (result.exitCode == 0) {
        return _parseStoredOutput(result.stdout.toString().split('\n\n'));
      } else {
        throw Exception('wpa_cli list_networks -> exit code: ${result.exitCode}');
      }
    } catch (e, s) {
      _log.severe('getStored', e, s);
      throw e;
    }
  }

  List<WiFiStoredNetworkInfo> _parseStoredOutput(List<String> output) {
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
        if (args.length > 2) {
          result.add(WiFiStoredNetworkInfo((b) => b
            ..id = int.tryParse(args[0]) ?? -1
            ..SSID = args[1]));
        }
      } catch (e, st) {
        _log.severe('_parseStoredOutput', e, st);
      }
    });

    return result;
  }
}
