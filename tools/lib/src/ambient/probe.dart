import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as net;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

const ambientScope = 'https://www.googleapis.com/auth/photosambient.mediaitems';
const ambientApi = 'https://photosambient.googleapis.com/v1';
const deviceCodeEndpoint = 'https://oauth2.googleapis.com/device/code';
const tokenEndpoint = 'https://oauth2.googleapis.com/token';
const jsonLimit = 2 * 1024 * 1024;
final _urlPattern = RegExp(r'''https?://[^\s<>"']+''');
final _durationPattern = RegExp(r'^\d+(?:\.\d{1,9})?s$');
final _spaces = RegExp(r'\s+');
final _random = Random.secure();
final _locks = <String>{};
final _log = Logger('ambient');

enum ProbeExit {
  ok(0),
  failed(1),
  incomplete(2),
  interrupted(130);

  const ProbeExit(this.code);
  final int code;
}

enum ProbeStage {
  authorization('authorization'),
  device('device'),
  source('source'),
  mediaList('media_list'),
  download('download'),
  deleteDevice('delete_device');

  const ProbeStage(this.wireName);
  final String wireName;
}

enum MediaKind {
  photo,
  video,
  unknown;

  static MediaKind fromMime(Object? value) => switch (value.toString().toLowerCase().split('/').first) {
    'image' => photo,
    'video' => video,
    _ => unknown,
  };
}

enum OAuthError {
  pending,
  slowDown,
  denied,
  expired,
  invalidGrant,
  unknown;

  static OAuthError parse(String value) => switch (value) {
    'authorization_pending' => pending,
    'slow_down' => slowDown,
    'access_denied' => denied,
    'expired_token' => expired,
    'invalid_grant' => invalidGrant,
    _ => unknown,
  };
}

class ProbeError implements Exception {
  const ProbeError(this.message);
  final String message;
  @override
  String toString() => message;
}

class ProbeInterrupted extends ProbeError {
  const ProbeInterrupted() : super('Interrupted by user');
}

class ApiError extends ProbeError {
  ApiError(this.status, Object? payload) : super(_message(status, payload));
  final int status;
  static String _message(int status, Object? payload) {
    final error = payload is Map ? payload['error'] : null;
    final code = error is Map ? '${error['status'] ?? 'HTTP_ERROR'}' : '${error ?? 'HTTP_ERROR'}';
    final message = error is Map
        ? '${error['message'] ?? ''}'
        : payload is Map
        ? '${payload['error_description'] ?? ''}'
        : '';
    final reasons = error is Map
        ? [
            for (final key in ['details', 'errors'])
              if (error[key] is List)
                for (final detail in error[key] as List)
                  if (detail is Map && detail['reason'] != null) '${detail['reason']}',
          ]
        : <String>[];
    return 'HTTP $status: $code: $message${reasons.isEmpty ? '' : '; reason=${reasons.join(',')}'}';
  }

  String get code {
    final start = message.indexOf(': ') + 2;
    final end = message.indexOf(': ', start);
    return end < 0 ? message.substring(start) : message.substring(start, end);
  }
}

double positive(Object? value) {
  final number = value is num ? value.toDouble() : double.tryParse(value.toString());
  if (number == null || !number.isFinite || number <= 0) {
    throw const ProbeError('Число должно быть конечным и положительным');
  }
  return number;
}

double serverDuration(Object? value) {
  if (value is! String || !_durationPattern.hasMatch(value)) {
    throw const ProbeError('Некорректный pollingConfig.pollInterval');
  }
  return positive(value.substring(0, value.length - 1));
}

String uuidV4() {
  final bytes = List.generate(16, (_) => _random.nextInt(256));
  bytes[6] = (bytes[6] & 15) | 64;
  bytes[8] = (bytes[8] & 63) | 128;
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}

void _chmod(String path, String mode) {
  if (Platform.isWindows) throw const ProbeError('Ambient probe requires POSIX private file permissions');
  final result = Process.runSync('chmod', [mode, '--', path]);
  if (result.exitCode != 0) throw const ProbeError('Не удалось ограничить права файла состояния');
}

Directory privateDirectory(Directory directory) {
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
    _chmod(directory.path, '700');
  }
  return directory;
}

Directory privateTemporaryDirectory(Directory parent, String prefix) {
  final directory = parent.createTempSync(prefix);
  _chmod(directory.path, '700');
  return directory;
}

void saveAmbientJson(File file, Object? value) {
  privateDirectory(file.parent);
  final temporary = File(p.join(file.parent.path, '.ambient-${uuidV4()}'))..createSync(exclusive: true);
  try {
    _chmod(temporary.path, '600');
    temporary.writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(value)}\n', flush: true);
    temporary.renameSync(file.path);
  } finally {
    if (temporary.existsSync()) temporary.deleteSync();
  }
}

Future<T> withStateLock<T>(Directory directory, Future<T> Function() action) async {
  privateDirectory(directory);
  final path = directory.resolveSymbolicLinksSync();
  if (!_locks.add(path)) throw const ProbeError('Другой probe уже использует этот --state-dir');
  RandomAccessFile? handle;
  try {
    final file = File(p.join(path, '.lock'))..createSync();
    _chmod(file.path, '600');
    handle = await file.open(mode: FileMode.append);
    try {
      await handle.lock(FileLock.exclusive);
    } on FileSystemException {
      throw const ProbeError('Другой probe уже использует этот --state-dir');
    }
    return await action();
  } finally {
    await handle?.close();
    _locks.remove(path);
  }
}

String mediaUrl(String value) {
  Uri uri;
  try {
    uri = Uri.parse(value);
  } on FormatException {
    throw const ProbeError('Некорректный HTTPS media URL Google');
  }
  final trusted = [
    'googleusercontent.com',
    'ggpht.com',
  ].any((domain) => uri.host == domain || uri.host.endsWith('.$domain'));
  if (uri.scheme != 'https' || !trusted || uri.userInfo.isNotEmpty || uri.port != 443 || uri.fragment.isNotEmpty) {
    throw const ProbeError('baseUrl/redirect не является ожидаемым HTTPS media URL Google');
  }
  return value;
}

Future<void> discardResponse(net.StreamedResponse response) => response.stream.listen((_) {}).cancel();

class AmbientHttp {
  AmbientHttp({net.Client? client, this.timeout = const Duration(seconds: 30)}) : client = client ?? net.Client();
  final net.Client client;
  final Duration timeout;
  final secrets = <String>{};
  final _closed = Completer<void>();

  String clean(Object message) {
    var result = message.toString();
    final values = secrets.where((s) => s.isNotEmpty).toList()..sort((a, b) => b.length.compareTo(a.length));
    for (final secret in values) {
      result = result.replaceAll(secret, '[redacted]');
    }
    result = result.replaceAll(_urlPattern, '[url]');
    return result.substring(0, min(result.length, 2000));
  }

  void close() {
    if (!_closed.isCompleted) _closed.complete();
    client.close();
  }

  Future<net.StreamedResponse> open(
    String url, {
    List<int>? data,
    Map<String, String>? headers,
    bool media = false,
    Duration? requestTimeout,
    String? method,
  }) async {
    for (var redirect = 0; redirect < 6; redirect++) {
      if (media) mediaUrl(url);
      final aborted = Completer<void>();
      final request = net.AbortableRequest(
        method ?? (data == null ? 'GET' : 'POST'),
        Uri.parse(url),
        abortTrigger: Future.any([aborted.future, _closed.future]),
      )..followRedirects = false;
      if (headers != null) request.headers.addAll(headers);
      if (data != null) request.bodyBytes = data;
      net.StreamedResponse response;
      try {
        response = await client
            .send(request)
            .timeout(
              requestTimeout ?? timeout,
              onTimeout: () {
                if (!aborted.isCompleted) aborted.complete();
                throw const ProbeError('Сетевая ошибка: истекло время HTTP-запроса');
              },
            );
      } on ProbeError {
        rethrow;
      } on Exception catch (error, stack) {
        if (_closed.isCompleted) throw const ProbeInterrupted();
        _log.warning('Ambient HTTP request failed', error, stack);
        throw ProbeError('Сетевая ошибка: ${clean(error)}');
      }
      final location = response.headers['location'];
      if (media && [301, 302, 303, 307, 308].contains(response.statusCode) && location != null) {
        await discardResponse(response);
        url = Uri.parse(url).resolve(location).toString();
        mediaUrl(url);
        continue;
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        Object? payload;
        try {
          payload = jsonDecode(utf8.decode(await readLimited(response, jsonLimit, requestTimeout: requestTimeout)));
        } on ProbeInterrupted {
          rethrow;
        } on TimeoutException {
          rethrow;
        } on Exception {
          payload = null;
        }
        throw ApiError(response.statusCode, payload);
      }
      return response;
    }
    throw const ProbeError('Слишком много перенаправлений при скачивании');
  }

  Future<List<int>> readLimited(net.StreamedResponse response, int limit, {Duration? requestTimeout}) async {
    final bytes = <int>[];
    try {
      await for (final chunk in response.stream.timeout(requestTimeout ?? timeout)) {
        if (bytes.length + chunk.length > limit) throw const ProbeError('JSON-ответ превысил 2 MiB');
        bytes.addAll(chunk);
      }
    } on Exception {
      if (_closed.isCompleted) throw const ProbeInterrupted();
      rethrow;
    }
    if (_closed.isCompleted) throw const ProbeInterrupted();
    return bytes;
  }

  Future<Map<String, dynamic>> json(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? form,
    String? token,
    Duration? requestTimeout,
  }) async {
    final headers = {'Accept': 'application/json'};
    List<int>? data;
    if (body != null) {
      headers['Content-Type'] = 'application/json';
      data = utf8.encode(jsonEncode(body));
    }
    if (form != null) {
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
      data = utf8.encode(Uri(queryParameters: form.map((key, value) => MapEntry(key, value.toString()))).query);
    }
    if (token != null && token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    final response = await open(url, data: data, headers: headers, requestTimeout: requestTimeout);
    final bytes = await readLimited(response, jsonLimit, requestTimeout: requestTimeout);
    dynamic value;
    try {
      value = jsonDecode(utf8.decode(bytes));
    } on FormatException catch (error, stack) {
      _log.warning('Ambient response decoding failed', error, stack);
      throw const ProbeError('Сервер вернул некорректный JSON');
    }
    if (value is! Map<String, dynamic>) throw const ProbeError('Ожидался JSON-объект');
    if (value.containsKey('error')) throw ApiError(200, value);
    return value;
  }
}

Object? withoutUrls(Object? value) => switch (value) {
  Map() => {
    for (final entry in value.entries)
      if (entry.key != 'baseUrl') entry.key: withoutUrls(entry.value),
  },
  List() => value.map(withoutUrls).toList(),
  _ => value,
};
MediaKind mediaKind(Map<String, dynamic> item) => MediaKind.fromMime((item['mediaFile'] as Map?)?['mimeType']);

bool _starts(List<int> bytes, List<int> signature, [int offset = 0]) =>
    bytes.length >= signature.length + offset &&
    List.generate(signature.length, (i) => bytes[offset + i] == signature[i]).every((v) => v);
MediaKind signatureKind(List<int> data) {
  if ([
        [255, 216, 255],
        [137, 80, 78, 71, 13, 10, 26, 10],
        ascii.encode('GIF87a'),
        ascii.encode('GIF89a'),
        ascii.encode('BM'),
        [73, 73, 42, 0],
        [77, 77, 0, 42],
        [255, 10],
        [0, 0, 0, 12, 74, 88, 76, 32],
      ].any((sig) => _starts(data, sig)) ||
      _starts(data, ascii.encode('RIFF')) && _starts(data, ascii.encode('WEBP'), 8)) {
    return MediaKind.photo;
  }
  if (_starts(data, ascii.encode('ftyp'), 4)) {
    return [
          'heic',
          'heix',
          'hevc',
          'hevx',
          'mif1',
          'msf1',
          'avif',
          'avis',
        ].any((brand) => _starts(data, ascii.encode(brand), 8))
        ? MediaKind.photo
        : MediaKind.video;
  }
  if ([
        [26, 69, 223, 163],
        [0, 0, 1, 186],
        [0, 0, 1, 179],
      ].any((sig) => _starts(data, sig)) ||
      _starts(data, ascii.encode('RIFF')) && _starts(data, ascii.encode('AVI '), 8)) {
    return MediaKind.video;
  }
  return MediaKind.unknown;
}

class Probe {
  Probe(
    this.options, {
    AmbientHttp? http,
    Future<void> Function(Duration)? sleep,
    this._monotonic,
    double Function()? wall,
    Future<String> Function(String)? prompt,
    void Function(String)? say,
  }) : http =
           http ??
           AmbientHttp(
             timeout: Duration(microseconds: (positive(options.option('request-timeout')) * 1000000).round()),
           ),
       _sleep = sleep ?? Future<void>.delayed,
       wall = wall ?? (() => DateTime.now().millisecondsSinceEpoch / 1000),
       prompt = prompt ?? ((_) async => throw const ProbeError('Interactive input is unavailable')),
       say = say ?? stdout.writeln {
    statePath = File(p.join(options.option('state-dir')!, 'state.json'));
    report = {
      'started_at': DateTime.now().toUtc().toIso8601String(),
      'scope': ambientScope,
      'downloads': <Map<String, dynamic>>[],
      'errors': <Map<String, dynamic>>[],
      'requested_downloads': {'photo': count('photos'), 'video': count('videos')},
    };
  }
  final ArgResults options;
  final AmbientHttp http;
  final Future<void> Function(Duration) _sleep;
  final double Function()? _monotonic;
  final double Function() wall;
  final Future<String> Function(String) prompt;
  final void Function(String) say;
  final _clock = Stopwatch()..start();
  final _cancelled = Completer<void>();
  late final File statePath;
  late final Map<String, dynamic> report;
  late Directory output;
  Map<String, dynamic> state = {}, client = {};
  ProbeStage stage = ProbeStage.authorization;
  double get monotonic => _monotonic?.call() ?? _clock.elapsedMicroseconds / 1000000;
  int count(String option) => int.parse(options.option(option)!);
  double seconds(String option) => positive(options.option(option));
  void checkCancelled() {
    if (_cancelled.isCompleted) throw const ProbeInterrupted();
  }

  void cancel() {
    if (!_cancelled.isCompleted) _cancelled.complete();
    http.close();
  }

  Future<T> _race<T>(Future<T> future) =>
      Future.any([future, _cancelled.future.then<T>((_) => throw const ProbeInterrupted())]);
  Future<void> wait(double seconds) => _race(_sleep(Duration(microseconds: (seconds * 1000000).round())));
  void save() => saveAmbientJson(statePath, state);

  void load() {
    final value = jsonDecode(File(options.option('client-file')!).readAsStringSync());
    if (value is! Map<String, dynamic> || value.containsKey('web')) {
      throw const ProbeError('Нужен OAuth JSON для TVs and Limited Input devices, не Web client');
    }
    final installed = value['installed'] ?? value;
    if (installed is! Map<String, dynamic> ||
        ['client_id', 'client_secret'].any((key) => installed[key] is! String || (installed[key] as String).isEmpty)) {
      throw const ProbeError('OAuth JSON должен содержать client_id и client_secret');
    }
    client = installed;
    http.secrets.add(client['client_secret'] as String);
    if (statePath.existsSync()) {
      final value = jsonDecode(statePath.readAsStringSync());
      if (value is! Map<String, dynamic>) throw const ProbeError('state.json должен содержать JSON-объект');
      state = value;
      if (state['client_id'] != client['client_id']) {
        throw const ProbeError('Этот state-dir принадлежит другому OAuth client; выбери другой каталог');
      }
      for (final key in ['access_token', 'refresh_token', 'device_id', 'request_id', 'source_id']) {
        if (state.containsKey(key) && state[key] is! String) throw ProbeError('Некорректное поле $key в state.json');
      }
      if (state.containsKey('expires_at')) state['expires_at'] = positive(state['expires_at']);
    }
    state['client_id'] = client['client_id'];
    for (final key in ['access_token', 'refresh_token']) {
      if (state[key] is String) http.secrets.add(state[key] as String);
    }
    if (options.flag('reauthorize')) {
      for (final key in ['access_token', 'refresh_token', 'expires_at']) {
        state.remove(key);
      }
      save();
    }
  }

  void tokens(Map<String, dynamic> value) {
    final token = value['access_token'];
    if (token is! String || token.isEmpty) throw const ProbeError('OAuth не вернул access_token');
    http.secrets.add(token);
    if ('${value['token_type'] ?? 'Bearer'}'.toLowerCase() != 'bearer') {
      throw const ProbeError('OAuth вернул неподдерживаемый token_type');
    }
    if (value.containsKey('scope') && !value['scope'].toString().split(_spaces).contains(ambientScope)) {
      throw const ProbeError('Пользователь не предоставил scope photosambient.mediaitems');
    }
    state['access_token'] = token;
    state['expires_at'] = wall() + positive(value['expires_in']);
    if (value['refresh_token'] != null && value['refresh_token'] != '') {
      if (value['refresh_token'] is! String) throw const ProbeError('OAuth вернул некорректный refresh_token');
      state['refresh_token'] = value['refresh_token'];
      http.secrets.add(value['refresh_token'] as String);
    }
    save();
  }

  Future<void> authorize() async {
    final codes = await http.json(deviceCodeEndpoint, form: {'client_id': client['client_id'], 'scope': ambientScope});
    if ([
      'device_code',
      'user_code',
      'verification_url',
    ].any((key) => codes[key] is! String || (codes[key] as String).isEmpty)) {
      throw const ProbeError('OAuth не вернул device_code/user_code/verification_url');
    }
    http.secrets.add(codes['device_code'] as String);
    final deadline = monotonic + min(positive(codes['expires_in']), seconds('auth-timeout'));
    var interval = positive(codes['interval'] ?? 5);
    say('Открой: ${codes['verification_url']}\nКод авторизации: ${codes['user_code']}');
    while (true) {
      checkCancelled();
      if (deadline - monotonic <= interval) {
        throw const ProbeError('Истекло время ожидания OAuth; запусти probe повторно');
      }
      await wait(interval);
      if (monotonic >= deadline) throw const ProbeError('Истекло время ожидания OAuth');
      try {
        tokens(
          await http.json(
            tokenEndpoint,
            form: {
              'client_id': client['client_id'],
              'client_secret': client['client_secret'],
              'device_code': codes['device_code'],
              'grant_type': 'urn:ietf:params:oauth:grant-type:device_code',
            },
            requestTimeout: Duration(
              microseconds: (min(http.timeout.inMicroseconds / 1000000, deadline - monotonic) * 1000000).round(),
            ),
          ),
        );
        return;
      } on ApiError catch (error) {
        switch (OAuthError.parse(error.code)) {
          case OAuthError.slowDown:
            interval += 5;
          case OAuthError.pending:
            break;
          default:
            rethrow;
        }
      }
    }
  }

  Future<String> token({bool force = false}) async {
    checkCancelled();
    if (!force && state['access_token'] is String && (state['expires_at'] as num? ?? 0) > wall() + 60) {
      return state['access_token'] as String;
    }
    if (state['refresh_token'] is String && (state['refresh_token'] as String).isNotEmpty) {
      tokens(
        await http.json(
          tokenEndpoint,
          form: {
            'client_id': client['client_id'],
            'client_secret': client['client_secret'],
            'refresh_token': state['refresh_token'],
            'grant_type': 'refresh_token',
          },
        ),
      );
    } else {
      await authorize();
    }
    return state['access_token'] as String;
  }

  Future<Map<String, dynamic>> api(String resource, {Map<String, dynamic>? query, Map<String, dynamic>? body}) async {
    final url = Uri.parse('$ambientApi/$resource')
        .replace(queryParameters: query?.map((key, value) => MapEntry(key, value.toString())))
        .toString();
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        return await http.json(
          url,
          body: body,
          token: await token(force: attempt > 0),
        );
      } on ApiError catch (error) {
        if (error.status != 401 || attempt > 0) rethrow;
      }
    }
    throw const ProbeError('OAuth refresh failed');
  }

  Future<Map<String, dynamic>> device() async {
    stage = ProbeStage.device;
    Map<String, dynamic> device;
    if (state['device_id'] is String && (state['device_id'] as String).isNotEmpty) {
      device = await api('devices/${Uri.encodeComponent(state['device_id'] as String)}');
    } else {
      state.putIfAbsent('request_id', uuidV4);
      save();
      device = await api(
        'devices',
        query: {'requestId': state['request_id']},
        body: {'displayName': options.option('display-name')},
      );
      if (device['id'] is! String || (device['id'] as String).isEmpty) {
        throw const ProbeError('devices.create не вернул id');
      }
      state['device_id'] = device['id'];
      save();
    }
    if (device['id'] is! String || (device['id'] as String).isEmpty) {
      throw const ProbeError('API вернул устройство без id');
    }
    report['device_id'] = device['id'];
    stage = ProbeStage.source;
    if (device['mediaSourcesSet'] != true || options.flag('configure')) {
      if (device['settingsUri'] is! String || (device['settingsUri'] as String).isEmpty) {
        throw const ProbeError('У устройства нет settingsUri для выбора альбома');
      }
      say('Выбери альбом для устройства: ${device['settingsUri']}');
      if (options.flag('configure')) {
        await _race(prompt('После изменения выбора нажми Enter: '));
        device = await api('devices/${Uri.encodeComponent(device['id'] as String)}');
      }
      final deadline = monotonic + seconds('selection-timeout');
      while (device['mediaSourcesSet'] != true) {
        final config = device['pollingConfig'] ?? <String, dynamic>{};
        if (config is! Map) throw const ProbeError('Некорректный pollingConfig');
        final interval = serverDuration(config['pollInterval'] ?? '5s');
        if (monotonic + interval >= deadline) {
          throw const ProbeError('Истекло время выбора альбома; устройство сохранено, повтори запуск');
        }
        await wait(interval);
        device = await api('devices/${Uri.encodeComponent(device['id'] as String)}');
      }
    }
    saveAmbientJson(File(p.join(output.path, 'device.json')), device);
    return device;
  }

  Future<String> source(Map<String, dynamic> device) async {
    final raw = device['mediaSources'] ?? <dynamic>[];
    if (raw is! List || raw.any((item) => item is! Map<String, dynamic>)) {
      throw const ProbeError('Некорректный список mediaSources');
    }
    final usable = raw
        .cast<Map<String, dynamic>>()
        .where(
          (source) => source['id'] is String && (source['id'] as String).isNotEmpty && source['id'] != 'highlights',
        )
        .toList();
    if (usable.isEmpty) {
      throw const ProbeError('Нет выбранных источников-альбомов; highlights не поддерживает mediaSourceId');
    }
    final requested = options.option('source-id') ?? state['source_id'];
    Map<String, dynamic>? selected;
    for (var i = 0; i < usable.length; i++) {
      say('${i + 1}. ${usable[i]['displayName'] ?? '(без имени)'} — ${usable[i]['id']}');
      if (usable[i]['id'] == requested) selected = usable[i];
    }
    if (options.option('source-id') != null && selected == null) {
      throw const ProbeError('--source-id не входит в выбранные пользователем источники устройства');
    }
    if (selected == null && usable.length == 1) selected = usable.single;
    if (selected == null) {
      final choice = (await _race(prompt('Выбери номер альбома или введи его ID: '))).trim();
      for (final source in usable) {
        if (source['id'] == choice) selected = source;
      }
      final index = int.tryParse(choice);
      if (selected == null && index != null && index >= 1 && index <= usable.length) selected = usable[index - 1];
      if (selected == null) throw const ProbeError('Неизвестный источник');
    }
    state['source_id'] = selected['id'];
    save();
    report['source'] = selected;
    return selected['id'] as String;
  }

  Future<List<Map<String, dynamic>>> listMedia(String deviceId, String sourceId) async {
    stage = ProbeStage.mediaList;
    final items = <Map<String, dynamic>>[], ids = <String>{}, tokens = <String>{};
    String? pageToken;
    for (var page = 0; page < count('max-pages'); page++) {
      final response = await api(
        'mediaItems',
        query: {
          'deviceId': deviceId,
          'mediaSourceId': sourceId,
          'pageSize': count('page-size'),
          if (pageToken != null && pageToken.isNotEmpty) 'pageToken': pageToken,
        },
      );
      final entries = response['mediaItems'] ?? <dynamic>[];
      if (entries is! List) throw const ProbeError('Некорректный список mediaItems');
      for (final item in entries) {
        if (item is! Map<String, dynamic> || item['id'] is! String || (item['id'] as String).isEmpty) {
          throw const ProbeError('Некорректный media item без id');
        }
        if (item.containsKey('mediaFile') && item['mediaFile'] is! Map<String, dynamic>) {
          throw const ProbeError('Некорректный mediaFile');
        }
        if (ids.add(item['id'] as String)) items.add(item);
      }
      report['pages'] = page + 1;
      final token = response['nextPageToken'];
      if (token != null && token is! String) throw const ProbeError('Некорректный nextPageToken');
      pageToken = token as String?;
      if (pageToken == null || pageToken.isEmpty) break;
      if (!tokens.add(pageToken)) throw const ProbeError('API повторил nextPageToken; обход остановлен');
    }
    report['truncated'] = pageToken != null && pageToken.isNotEmpty;
    report['unique_items'] = items.length;
    report['counts'] = {
      for (final kind in MediaKind.values) kind.name: items.where((item) => mediaKind(item) == kind).length,
    };
    saveAmbientJson(File(p.join(output.path, 'media.json')), withoutUrls(items));
    say('Получено уникальных медиа: ${items.length}; ${report['counts']}');
    return items;
  }

  Future<Map<String, dynamic>> download(Map<String, dynamic> item) async {
    checkCancelled();
    final kind = mediaKind(item), media = item['mediaFile'] as Map<String, dynamic>;
    final base = Uri.parse(mediaUrl(media['baseUrl']?.toString() ?? ''));
    final url = base.replace(path: '${base.path}${kind == MediaKind.video ? '=dv' : '=d'}').toString();
    const extensions = {
      'image/jpeg': '.jpg',
      'image/png': '.png',
      'image/webp': '.webp',
      'image/gif': '.gif',
      'image/heic': '.heic',
      'image/avif': '.avif',
      'video/mp4': '.mp4',
      'video/webm': '.webm',
      'video/quicktime': '.mov',
    };
    final stem = '${kind.name}-${sha256.convert(utf8.encode(item['id'] as String)).toString().substring(0, 24)}';
    final temporary = File(p.join(output.path, '$stem.part'));
    final deadline = monotonic + seconds('download-timeout');
    net.StreamedResponse? response;
    var subscribed = false;
    IOSink? sink;
    try {
      for (var attempt = 0; attempt < 2; attempt++) {
        try {
          response = await http.open(
            url,
            media: true,
            headers: {'Authorization': 'Bearer ${await token(force: attempt > 0)}'},
          );
          break;
        } on ApiError catch (error) {
          if (error.status != 401 || attempt > 0) rethrow;
        }
      }
      final active = response!;
      if (active.statusCode != 200) throw ProbeError('Неожиданный HTTP ${active.statusCode} вместо целого медиа');
      final contentType = (active.headers['content-type'] ?? '').split(';').first.toLowerCase();
      if (MediaKind.fromMime(contentType) != kind && contentType != 'application/octet-stream') {
        throw ProbeError('Вместо ${kind.name} сервер вернул Content-Type=$contentType');
      }
      final mime = contentType == 'application/octet-stream' ? media['mimeType'] : contentType;
      final destination = File(p.join(output.path, '$stem${extensions[mime] ?? '.bin'}'));
      final header = active.headers['content-length'];
      final expected = header == null ? null : int.tryParse(header);
      if (header != null && (expected == null || expected < 0 || expected > count('max-download-bytes'))) {
        throw const ProbeError('Content-Length превышает лимит скачивания');
      }
      temporary.createSync(exclusive: true);
      _chmod(temporary.path, '600');
      sink = temporary.openWrite();
      final prefix = <int>[];
      var length = 0;
      subscribed = true;
      await for (final chunk in active.stream.timeout(http.timeout)) {
        checkCancelled();
        if (monotonic >= deadline) throw const ProbeError('Истекло время скачивания');
        length += chunk.length;
        if (length > count('max-download-bytes')) throw const ProbeError('Тело медиа превышает лимит скачивания');
        sink.add(chunk);
        // Backpressure also bounds buffered writes independently of file size.
        await sink.flush();
        prefix.addAll(chunk.take(max(0, 64 - prefix.length)));
      }
      checkCancelled();
      if (monotonic >= deadline) throw const ProbeError('Истекло время скачивания');
      if (length == 0 || expected != null && length != expected) {
        throw const ProbeError('Пустое или недокачанное медиа');
      }
      if (signatureKind(prefix) != kind) {
        throw const ProbeError('Сигнатура скачанного файла не соответствует ожидаемому типу медиа');
      }
      await sink.close();
      sink = null;
      final digest = await sha256.bind(temporary.openRead()).first;
      checkCancelled();
      await temporary.rename(destination.path);
      return {
        'id': item['id'],
        'kind': kind.name,
        'file': p.basename(destination.path),
        'bytes': length,
        'mime_type': contentType,
        'sha256': digest.toString(),
      };
    } on Exception {
      checkCancelled();
      rethrow;
    } finally {
      if (response != null && !subscribed) await discardResponse(response);
      await sink?.close();
      if (temporary.existsSync()) temporary.deleteSync();
    }
  }

  Future<ProbeExit> run() async {
    load();
    await token();
    if (options.flag('delete-device')) {
      stage = ProbeStage.deleteDevice;
      final id = state['device_id'] ?? state['request_id'];
      if (id is! String || id.isEmpty) throw const ProbeError('В этом state-dir нет принадлежащего probe устройства');
      try {
        await discardResponse(
          await http.open(
            '$ambientApi/devices/${Uri.encodeComponent(id)}',
            method: 'DELETE',
            headers: {'Authorization': 'Bearer ${await token()}'},
          ),
        );
      } on ApiError catch (error) {
        if (error.status != 404) rethrow;
      }
      for (final key in ['device_id', 'request_id', 'source_id']) {
        state.remove(key);
      }
      save();
      say('Тестовое устройство удалено; токены сохранены.');
      return ProbeExit.ok;
    }
    final deviceValue = await device();
    final sourceId = await source(deviceValue);
    final items = await listMedia(deviceValue['id'] as String, sourceId);
    stage = ProbeStage.download;
    for (final kind in [MediaKind.photo, MediaKind.video]) {
      final wanted = count(kind == MediaKind.photo ? 'photos' : 'videos');
      var completed = 0, attempted = 0;
      for (final item in items) {
        if (completed == wanted || attempted >= max(3, wanted)) break;
        if (mediaKind(item) != kind) continue;
        attempted++;
        try {
          final result = await download(item);
          (report['downloads'] as List).add(result);
          say('Скачан ${result['file']}: ${result['bytes']} байт');
          completed++;
        } on ProbeInterrupted {
          rethrow;
        } on Exception catch (error) {
          (report['errors'] as List).add({'id': item['id'], 'error': http.clean(error)});
          say('Не удалось скачать ${kind.name}: ${http.clean(error)}');
        }
      }
      if (completed < wanted) {
        (report['errors'] as List).add({'kind': kind.name, 'wanted': wanted, 'downloaded': completed});
        say('${kind.name}: запрошено $wanted, скачано $completed; проверка неполная');
      }
    }
    checkCancelled();
    _log.info(
      'Ambient downloads complete success=${(report['downloads'] as List).length} failed=${(report['errors'] as List).length}',
    );
    return (report['errors'] as List).isNotEmpty || report['truncated'] == true ? ProbeExit.incomplete : ProbeExit.ok;
  }
}
