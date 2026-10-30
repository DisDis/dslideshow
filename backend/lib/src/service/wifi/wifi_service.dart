import 'dart:async';
import 'dart:io' as io;

import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/system_info/system_command_runner.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:logging/logging.dart';

enum _WiFiAction { list, rescan, add, up, down, delete, connections }

enum _WiFiFailureReason { launch, exitCode, timeout, outputLimit, cancelled, execution }

/// A safe failure boundary: never retains process arguments or output.
class _WiFiCommandFailure implements Exception {
  final _WiFiAction action;
  final _WiFiFailureReason reason;
  final int? code;

  const _WiFiCommandFailure(this.action, this.reason, this.code);

  @override
  String toString() => 'Wi-Fi ${action.name} failed (${reason.name}${code == null ? '' : ', code=$code'})';
}

class WiFiService {
  static final Logger _log = Logger('WiFiService');
  // ignore: unused_field
  final WiFiConfig _config;
  final SystemCommandRunner _commandRunner;
  bool _closed = false;
  Future<void>? _closing;

  static const commandTimeout = Duration(seconds: 60);

  WiFiService(this._config, {SystemCommandRunner? commandRunner})
    : _commandRunner = commandRunner ?? BoundedSystemCommandRunner(deadline: commandTimeout);

  static const _environment = {'LC_ALL': 'C'};
  static final _parseRateRegExp = RegExp(r'[^0-9]');

  Future<io.ProcessResult> _run(_WiFiAction action, String executable, List<String> arguments) async {
    _log.info('event=started action=${action.name}');
    try {
      if (_closed) throw StateError('Wi-Fi service is closed');
      final result = await _commandRunner.run(executable, arguments, environment: _environment);
      if (_closed) throw StateError('Wi-Fi service is closed');
      if (result.exitCode != 0) {
        throw _WiFiCommandFailure(action, _WiFiFailureReason.exitCode, result.exitCode);
      }
      _log.info(
        'event=completed action=${action.name} '
        'exitCode=0',
      );
      return result;
    } catch (error) {
      final failure = error is _WiFiCommandFailure
          ? error
          : _WiFiCommandFailure(
              action,
              _closed
                  ? _WiFiFailureReason.cancelled
                  : switch (error) {
                      io.ProcessException() => _WiFiFailureReason.launch,
                      TimeoutException() => _WiFiFailureReason.timeout,
                      SystemCommandOutputLimit() => _WiFiFailureReason.outputLimit,
                      _ => _WiFiFailureReason.execution,
                    },
              error is io.ProcessException ? error.errorCode : null,
            );
      _log.log(
        failure.reason == _WiFiFailureReason.cancelled ? Level.INFO : Level.WARNING,
        'event=failed action=${action.name} '
        'reason=${failure.reason.name} type=${error.runtimeType}'
        '${failure.code == null ? '' : ' code=${failure.code}'}',
      );
      throw failure;
    }
  }

  Future<List<WiFiNetworkInfo>> list([bool isRescan = true]) async {
    final args = ['nmcli', 'device', 'wifi', 'list'];
    if (isRescan) args.addAll(['--rescan', 'auto']);
    final result = await _run(_WiFiAction.list, 'sudo', args);
    return parseScanOutput(result.stdout.toString());
  }

  Future<void> rescan() async {
    await _run(_WiFiAction.rescan, 'sudo', ['nmcli', 'device', 'wifi', 'rescan']);
  }

  Future<void> addWiFiConnection(String name, String SSID, String psk) async {
    await _run(_WiFiAction.add, 'sudo', ['nmcli', 'device', 'wifi', 'connect', SSID, 'password', psk, 'name', name]);
  }

  Future<void> upConnection(String connectionUUID) async {
    await _run(_WiFiAction.up, 'sudo', ['nmcli', 'connection', 'up', connectionUUID]);
  }

  Future<void> downConnection(String connectionUUID) async {
    await _run(_WiFiAction.down, 'sudo', ['nmcli', 'connection', 'down', connectionUUID]);
  }

  Future<void> deleteConnection(String connectionUUID) async {
    await _run(_WiFiAction.delete, 'sudo', ['nmcli', 'connection', 'delete', connectionUUID]);
  }

  List<WiFiNetworkInfo> parseScanOutput(String outputStr) {
    List<String> lines = outputStr.split('\n');
    lines.removeWhere((element) => element.isEmpty);
    if (lines.isEmpty) {
      return <WiFiNetworkInfo>[];
    }

    final headers = lines[0];
    const neededColumns = ['BSSID', ' SSID', 'MODE', 'RATE', 'BARS', 'SIGNAL', 'SECURITY', 'RATE', 'CHAN'];
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
        if (bssid.isEmpty || bssid == '--') continue; // Пропускаем сети без BSSID

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
          WiFiNetworkInfo(BSSID: bssid, SSID: ssid, signal: signal, channel: channel, security: security, rate: rate),
        );
      } catch (error) {
        _log.warning('Wi-Fi scan row rejected row=$i type=${error.runtimeType}');
      }
    }

    return networks;
  }

  Future<List<WiFiConnectionInfo>> getConnections() async {
    final result = await _run(_WiFiAction.connections, 'nmcli', ['connection', 'show']);
    return parseConnectionsOutput(result.stdout.toString());
  }

  /// Stops owned commands and waits for process/pipe cleanup before returning.
  Future<void> close() => _closing ??= () async {
    _closed = true;
    await _commandRunner.close();
  }();

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

        result.add(WiFiConnectionInfo(name: name, UUID: uuid, type: type, device: device));
      } catch (error) {
        _log.warning('Wi-Fi connection row rejected row=$i type=${error.runtimeType}');
      }
    }
    return result;
  }
}
