import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'dart:io' as io;

import 'package:logging/logging.dart';

class WiFiService {
  static final Logger _log = new Logger('WiFiService');
  final WiFiConfig _config;
  WiFiService(this._config);

  Future<Iterable<WiFiNetworkInfo>> scan() async {
    //    _log.info('getNetworkInterfaces');
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

  // static final RegExp _findSSID = new RegExp(r'SSID\: (.*)$');

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
}
