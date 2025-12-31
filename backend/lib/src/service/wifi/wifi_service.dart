import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'dart:io' as io;

import 'package:logging/logging.dart';

class WiFiService {
  static final Logger _log = new Logger('WiFiService');
  // ignore: unused_field
  final WiFiConfig _config;
  WiFiService(this._config);

  Future<List<WiFiNetworkInfo>> scan() async {
    _log.info('scan');
    try {
      var result = await io.Process.run(
        'nmcli',
        ['device', 'wifi', 'list'],
        environment: {'LC_ALL': 'C'},
      );
      if (result.exitCode == 0) {
        return parseScanOutput(result.stdout.toString());
      } else {
        throw Exception(
          'nmcli device wifi list -> exit code: ${result.exitCode}',
        );
      }
    } catch (e, s) {
      _log.severe('scan', e, s);
    }
    return <WiFiNetworkInfo>[];
  }

  static final _parseRateRegExp = RegExp(r'[^0-9]');

  void addWiFiConnection(String name, String SSID, String psk) async {
    _log.info('addWiFiConnection "$SSID"');

    try {
      var result = await io.Process.run(
        'nmcli',
        ['device', 'wifi', 'connect', SSID, 'password', psk, 'name', name],
        environment: {'LC_ALL': 'C'},
      );
      if (result.exitCode != 0) {
        throw Exception(
          'nmcli device wifi connect "$SSID" password "***" name "$name" -> exit code: ${result.exitCode}',
        );
      }
    } catch (e, s) {
      _log.severe('addWiFiConnection', e, s);
    }
  }

  void upConnection(String connectionUUID) async {
    _log.info('upConnection "$connectionUUID"');
    try {
      /*
nmcli connection up  <UUID>
 */
      var result = await io.Process.run(
        'nmcli',
        ['connection', 'up', '$connectionUUID'],
        environment: {'LC_ALL': 'C'},
      );
      _log.info("nmcli connection up -> '${result.stdout.toString()}'");
      if (result.exitCode != 0) {
        throw Exception(
          'nmcli connection up $connectionUUID -> exitCode: ${result.exitCode}',
        );
      }
    } catch (e, s) {
      _log.severe('upConnection "$connectionUUID"', e, s);
      throw e;
    }
  }

  void downConnection(String connectionUUID) async {
    _log.info('downConnection "$connectionUUID"');
    try {
      /*
nmcli connection down  <UUID>
 */
      var result = await io.Process.run(
        'nmcli',
        ['connection', 'down', '$connectionUUID'],
        environment: {'LC_ALL': 'C'},
      );
      _log.info("nmcli connection down -> '${result.stdout.toString()}'");
      if (result.exitCode != 0) {
        throw Exception(
          'nmcli connection down $connectionUUID -> exitCode: ${result.exitCode}',
        );
      }
    } catch (e, s) {
      _log.severe('downConnection "$connectionUUID"', e, s);
      throw e;
    }
  }

  void deleteConnection(String connectionUUID) async {
    _log.info('deleteConnection "$connectionUUID"');
    try {
      /*
nmcli connection delete <UUID>
 */
      var result = await io.Process.run(
        'nmcli',
        ['connection', 'remove', '$connectionUUID'],
        environment: {'LC_ALL': 'C'},
      );
      _log.info("nmcli connection remove -> '${result.stdout.toString()}'");
      if (result.exitCode != 0) {
        throw Exception(
          'nmcli connection remove $connectionUUID -> exitCode: ${result.exitCode}',
        );
      }
    } catch (e, s) {
      _log.severe('deleteConnection "$connectionUUID"', e, s);
      throw e;
    }
  }

  List<WiFiNetworkInfo> parseScanOutput(String outputStr) {
    List<String> lines = outputStr.split('\n');
    lines.removeWhere((element) => element.isEmpty);
    if (lines.isEmpty) {
      return <WiFiNetworkInfo>[];
    }

    final headers = lines[0];
    const neededColumns = [
      'BSSID',
      ' SSID',
      'MODE',
      'RATE',
      'BARS',
      'SIGNAL',
      'SECURITY',
      'RATE',
      'CHAN',
    ];
    final columnIndices = <String, List<int>>{};

    // Находим позиции начала и конца каждого столбца
    for (final column in neededColumns) {
      final index = headers.indexOf(column);
      if (index == -1) continue;

      // Ищем конец столбца (либо следующий столбец, либо конец строки)
      int endIndex = headers.length;
      for (final otherColumn in neededColumns) {
        if (otherColumn == column) continue;
        final otherIndex = headers.indexOf(otherColumn);
        if (otherIndex > index && otherIndex < endIndex) {
          endIndex = otherIndex;
        }
      }

      columnIndices[column.trim()] = [index, endIndex];
    }

    // Обрабатываем данные, начиная со второй строки
    final networks = <WiFiNetworkInfo>[];
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim().isEmpty) continue;

      try {
        // Извлекаем данные из каждого столбца
        String ssid;
        String bssid;
        int signal;
        String security;
        int rate;
        int channel;
        List<int> indices;

        indices = columnIndices['BSSID']!;
        bssid = line.substring(indices[0], indices[1]).trim();
        if (bssid.isEmpty || bssid == '--')
          continue; // Пропускаем сети без BSSID

        indices = columnIndices['SSID']!;
        ssid = line.substring(indices[0], indices[1]).trim();
        if (ssid.isEmpty || ssid == '--') continue; // Пропускаем сети без SSID

        indices = columnIndices['SIGNAL']!;
        final signalStr = line.substring(indices[0], indices[1]).trim();
        signal = int.tryParse(signalStr) ?? 0;

        indices = columnIndices['CHAN']!;
        final channelStr = line.substring(indices[0], indices[1]).trim();
        channel = int.tryParse(channelStr) ?? 0;

        indices = columnIndices['SECURITY']!;
        security = line.substring(indices[0] /*, indices[1]*/).trim();

        indices = columnIndices['RATE']!;
        final rateStr = line.substring(indices[0], indices[1]).trim();
        rate = int.tryParse(rateStr.replaceAll(_parseRateRegExp, '')) ?? 0;

        networks.add(
          WiFiNetworkInfo(
            BSSID: bssid,
            SSID: ssid,
            signal: signal,
            channel: channel,
            security: security,
            rate: rate,
          ),
        );
      } catch (e, s) {
        _log.severe('Error parsing line $i', e, s);
      }
    }

    return networks;
  }

  Future<List<WiFiConnectionInfo>> getConnections() async {
    _log.info('getConnections');
    try {
      var result = await io.Process.run(
        'nmcli',
        ['connection', 'show'],
        environment: {'LC_ALL': 'C'},
      );
      if (result.exitCode == 0) {
        return parseConnectionsOutput(result.stdout.toString());
      } else {
        throw Exception(
          'nmcli connection show -> exit code: ${result.exitCode}',
        );
      }
    } catch (e, s) {
      _log.severe('getConnections', e, s);
      throw e;
    }
  }

  List<WiFiConnectionInfo> parseConnectionsOutput(String outputStr) {
    List<String> lines = outputStr.split('\n');
    lines.removeWhere((element) => element.isEmpty);
    if (lines.isEmpty) {
      return <WiFiConnectionInfo>[];
    }

    final headers = lines[0];
    const neededColumns = ['NAME', 'UUID', 'TYPE', 'DEVICE'];
    final columnIndices = <String, List<int>>{};

    // Находим позиции начала и конца каждого столбца
    for (final column in neededColumns) {
      final index = headers.indexOf(column);
      if (index == -1) continue;

      // Ищем конец столбца (либо следующий столбец, либо конец строки)
      int endIndex = headers.length;
      for (final otherColumn in neededColumns) {
        if (otherColumn == column) continue;
        final otherIndex = headers.indexOf(otherColumn);
        if (otherIndex > index && otherIndex < endIndex) {
          endIndex = otherIndex;
        }
      }

      columnIndices[column.trim()] = [index, endIndex];
    }

    // Обрабатываем данные, начиная со второй строки
    final result = <WiFiConnectionInfo>[];
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim().isEmpty) continue;

      try {
        // Извлекаем данные из каждого столбца
        String name;
        String uuid;
        String type;
        String device;

        List<int> indices;

        indices = columnIndices['NAME']!;
        name = line.substring(indices[0], indices[1]).trim();

        indices = columnIndices['UUID']!;
        uuid = line.substring(indices[0], indices[1]).trim();
        if (uuid.isEmpty || uuid == '--') continue; // Пропускаем сети без SSID

        indices = columnIndices['TYPE']!;
        type = line.substring(indices[0], indices[1]).trim();
        if (type.isEmpty || type == '--') continue;

        indices = columnIndices['DEVICE']!;
        device = line.substring(indices[0] /*, indices[1]*/).trim();

        result.add(
          WiFiConnectionInfo(
            name: name,
            UUID: uuid,
            type: type,
            device: device,
          ),
        );
      } catch (e, s) {
        _log.severe('Error parsing line $i', e, s);
      }
    }
    return result;
  }
}
