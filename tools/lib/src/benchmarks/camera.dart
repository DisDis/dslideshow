import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:path/path.dart' as p;

import 'json_io.dart';

final _spaces = RegExp(r'\s+');
Map<(String, int), List<int>> cameraEndpoints(Map<String, dynamic> config) {
  final result = <(String, int), List<int>>{};
  var index = 0;
  for (final screen in asList(asMap(config['slideshow'])['specialScreens'])) {
    if (screen['type'] != 'cameras') continue;
    for (final camera in asList(asMap(screen['options'])['cameras'])) {
      try {
        final url = Uri.parse(asMap(camera)['url'] as String);
        if (!['http', 'https'].contains(url.scheme)) continue;
        final ip = InternetAddress.tryParse(url.host);
        if (ip == null || ip.type != InternetAddressType.IPv4) continue;
        final address = ip.rawAddress.reversed.map((v) => v.toRadixString(16).padLeft(2, '0')).join().toUpperCase();
        (result[(
                  address,
                  url.hasPort
                      ? url.port
                      : url.scheme == 'https'
                      ? 443
                      : 80,
                )] ??=
                [])
            .add(index);
      } on Object {
        /* Invalid or non-IPv4 source still reserves its index. */
      } finally {
        index++;
      }
    }
  }
  return result;
}

(Map<String, int>, Map<String, int>) tcpStates(
  String source,
  Set<String> owned,
  Map<(String, int), List<int>> endpoints,
) {
  final states = <String, int>{}, mqtt = <String, int>{};
  for (final line in const LineSplitter().convert(source).skip(1)) {
    final fields = line.trim().split(_spaces);
    if (fields.length < 10 || !owned.contains('socket:[${fields[9]}]')) continue;
    final remote = fields[2].split(':');
    if (remote.length != 2) continue;
    final port = int.tryParse(remote[1], radix: 16);
    if (port == null) continue;
    final indices = endpoints[(remote[0], port)];
    if (indices != null) {
      final key = '${indices.join(',')}:${fields[3]}';
      states.update(key, (n) => n + 1, ifAbsent: () => 1);
    }
    if (port == 1883) mqtt.update(fields[3], (n) => n + 1, ifAbsent: () => 1);
  }
  return (states, mqtt);
}

Uri _cameraHttpTarget(String authority) {
  final target = Uri.parse('//$authority');
  if (target.host.isEmpty ||
      !target.hasPort ||
      target.userInfo.isNotEmpty ||
      target.path.isNotEmpty ||
      target.hasQuery ||
      target.hasFragment) {
    throw ArgumentError('Expected HOST:PORT without URL, auth, or path');
  }
  return target;
}

/// Opens one fresh /info connection, records headers and closes before body IO.
Future<Map<String, dynamic>> cameraHttpHeaders(
  String authority, {
  Duration timeout = const Duration(seconds: 6),
}) async {
  final target = _cameraHttpTarget(authority);
  if (timeout <= Duration.zero) throw ArgumentError('HTTP request timeout must be positive');
  final clock = Stopwatch()..start(),
      client = HttpClient(),
      sample = <String, dynamic>{'utc': DateTime.now().toUtc().toIso8601String()};
  try {
    await (() async {
      final request = await client.getUrl(Uri(scheme: 'http', host: target.host, port: target.port, path: '/info'));
      request.headers.set(HttpHeaders.connectionHeader, 'close');
      final response = await request.close();
      sample['status'] = response.statusCode;
      // Neither read nor retain the response body, including a stalled body.
      client.close(force: true);
    })().timeout(timeout);
  } on TimeoutException {
    sample['exception_type'] = 'TimeoutError';
  } on Object catch (error) {
    sample['exception_type'] = error.runtimeType.toString();
  } finally {
    client.close(force: true);
  }
  sample['rtt_ms'] = clock.elapsedMicroseconds / 1000;
  return sample;
}

Future<Map<String, dynamic>> cameraHttpProbe(
  String authority, {
  Duration duration = const Duration(seconds: 120),
  Duration interval = const Duration(seconds: 1),
  Duration requestTimeout = const Duration(seconds: 6),
}) async {
  _cameraHttpTarget(authority);
  if (duration <= Duration.zero || duration > const Duration(seconds: 1800)) {
    throw ArgumentError('Duration must be between 1 and 1800 seconds');
  }
  if (interval <= Duration.zero || requestTimeout <= Duration.zero) {
    throw ArgumentError('Sampling interval and timeout must be positive');
  }
  final clock = Stopwatch()..start(), samples = <Map<String, dynamic>>[];
  var next = Duration.zero;
  while (clock.elapsed < duration) {
    final pause = next - clock.elapsed, remainingBeforePause = duration - clock.elapsed;
    if (pause > Duration.zero && remainingBeforePause > Duration.zero) {
      await Future<void>.delayed(pause < remainingBeforePause ? pause : remainingBeforePause);
    }
    final sent = clock.elapsed, remaining = duration - sent;
    if (remaining <= Duration.zero) break;
    final budget = remaining < requestTimeout ? remaining : requestTimeout;
    final sample = await cameraHttpHeaders(authority, timeout: budget);
    sample['elapsed_s'] = sent.inMicroseconds / 1000000;
    samples.add(sample);
    next += interval;
    if (next < clock.elapsed) {
      final missed = ((clock.elapsed - next).inMicroseconds / interval.inMicroseconds).floor() + 1;
      next += interval * missed;
    }
  }
  return {
    'probe': 'camera_http_info_headers',
    'duration_s': duration.inMicroseconds / 1000000,
    'actual_duration_s': clock.elapsedMicroseconds / 1000000,
    'samples': samples,
  };
}

Future<void> cameraSocketProbe(File config, int pid, {int durationSeconds = 240, Directory? procRoot}) async {
  if (durationSeconds < 1 || durationSeconds > 1800) throw ArgumentError('Invalid duration');
  final root = procRoot ?? Directory('/proc'),
      endpoints = cameraEndpoints(readJson(config, [])),
      clock = Stopwatch()..start();
  while (clock.elapsed.inSeconds < durationSeconds) {
    final proc = Directory(p.join(root.path, pid.toString())), owned = <String>{};
    final fd = Directory(p.join(proc.path, 'fd'));
    for (final descriptor in fd.listSync(followLinks: false)) {
      try {
        owned.add(p.basename(Link(descriptor.path).targetSync()));
      } on FileSystemException {
        /* FD may close between list/readlink. */
      }
    }
    final (states, mqtt) = tcpStates(File(p.join(root.path, 'net/tcp')).readAsStringSync(), owned, endpoints);
    stdout.writeln(
      jsonEncode({
        'utc': DateTime.now().toUtc().toIso8601String(),
        'elapsed_s': clock.elapsedMicroseconds / 1000000,
        'camera_tcp_states': states,
        'mqtt_tcp_states': mqtt,
        'fds': fd.listSync().length,
        'threads': Directory(p.join(proc.path, 'task')).listSync().length,
      }),
    );
    final remaining = Duration(seconds: durationSeconds) - clock.elapsed;
    if (remaining > Duration.zero) {
      await Future<void>.delayed(Duration(microseconds: math.min(1000000, remaining.inMicroseconds)));
    }
  }
}
