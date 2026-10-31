import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../command/drive_command.dart';
import '../storage/cloud_storage_transfer.dart';
import 'yandex_drive_models.dart';
import 'yandex_drive_paths.dart';

enum _YandexDriveOperation { deviceCode, token, identity, resources, downloadLink, downloadContent }

class YandexDriveDownload {
  YandexDriveDownload(this.response, this._client);
  final http.StreamedResponse response;
  final http.Client _client;
  void close() => _client.close();
}

/// Only this boundary knows Yandex HTTP fields, codes and endpoints.
/// It never forwards a raw transport exception or response body to callers.
class YandexDriveApi {
  YandexDriveApi({
    http.Client Function()? clientFactory,
    Uri? oauthBase,
    Uri? diskBase,
    Future<void> Function(Duration)? delay,
    this.timeout = const Duration(seconds: 30),
  }) : _clientFactory = clientFactory ?? http.Client.new,
       _oauthBase = oauthBase ?? Uri.https('oauth.yandex.ru', '/'),
       _diskBase = diskBase ?? Uri.https('cloud-api.yandex.net', '/v1/disk'),
       _delay = delay ?? Future<void>.delayed;

  static const pageSize = 100;
  static final _log = Logger('YandexDriveApi');
  static const _maxJsonBytes = 2 * 1024 * 1024;
  static const _scope = 'cloud_api:disk.read cloud_api:disk.info';
  static const _verificationHosts = {'oauth.yandex.ru', 'oauth.yandex.com', 'ya.ru'};
  final http.Client Function() _clientFactory;
  final Uri _oauthBase;
  final Uri _diskBase;
  final Future<void> Function(Duration) _delay;
  final Duration timeout;
  final _clients = <http.Client>{};
  bool _closed = false;

  Future<YandexDriveDeviceResponse> startDevice(String clientId) async {
    final json = await _request(
      'POST',
      _oauthBase.resolve('device/code'),
      operation: _YandexDriveOperation.deviceCode,
      form: {'client_id': clientId, 'scope': _scope},
      oauthErrors: true,
    );
    if (json['error'] case final String error) {
      throw CloudStorageException(oauthFailure(error));
    }
    try {
      final result = YandexDriveDeviceResponse.fromJson(json);
      if (result.deviceCode.isEmpty ||
          result.userCode.isEmpty ||
          result.userCode.length > 100 ||
          result.verificationUrl.scheme != 'https' ||
          !_verificationHosts.contains(result.verificationUrl.host) ||
          result.interval < 1 ||
          result.interval > 300 ||
          result.expiresIn < 1 ||
          result.expiresIn > 3600) {
        throw const FormatException();
      }
      return result;
    } catch (error, stack) {
      _log.fine('Drive response decoding failed', error, stack);
      throw const CloudStorageException(DriveFailure.invalidResponse);
    }
  }

  Future<YandexDriveTokenResponse> token(Map<String, String> form) async {
    final json = await _request(
      'POST',
      _oauthBase.resolve('token'),
      operation: _YandexDriveOperation.token,
      form: form,
      oauthErrors: true,
    );
    try {
      return YandexDriveTokenResponse.fromJson(json);
    } catch (error, stack) {
      _log.fine('Drive response decoding failed', error, stack);
      throw const CloudStorageException(DriveFailure.invalidResponse);
    }
  }

  Future<YandexDriveUser> identity(String token) async {
    final json = await _request(
      'GET',
      _diskBase.replace(queryParameters: {'fields': 'user'}),
      operation: _YandexDriveOperation.identity,
      token: token,
    );
    try {
      final user = YandexDriveDiskInfo.fromJson(json).user;
      if (!YandexDrivePaths.validAccountId(user.uid)) throw const FormatException();
      return user;
    } catch (error, stack) {
      _log.fine('Drive response decoding failed', error, stack);
      throw const CloudStorageException(DriveFailure.invalidResponse);
    }
  }

  Future<YandexDriveResource> resources(String token, String remotePath, int offset) async {
    if (offset < 0) throw const CloudStorageException(DriveFailure.invalidRequest);
    final json = await _request(
      'GET',
      _endpoint('resources', {
        'path': YandexDrivePaths.normalize(remotePath),
        'offset': '$offset',
        'limit': '$pageSize',
        'sort': 'name',
        'fields':
            'path,name,type,size,md5,sha256,_embedded.items.path,_embedded.items.name,_embedded.items.type,'
            '_embedded.items.size,_embedded.items.md5,_embedded.items.sha256,_embedded.offset,_embedded.limit,_embedded.total',
      }),
      operation: _YandexDriveOperation.resources,
      token: token,
    );
    try {
      final resource = YandexDriveResource.fromJson(json);
      final children = resource.children;
      if (children != null &&
          (children.items.length > pageSize ||
              children.offset != offset ||
              children.total < 0 ||
              children.limit < 0 ||
              children.limit > pageSize))
        throw const FormatException();
      if (YandexDrivePaths.normalize(resource.path) != YandexDrivePaths.normalize(remotePath))
        throw const FormatException();
      for (final child in children?.items ?? <YandexDriveResource>[]) {
        final normalized = YandexDrivePaths.normalize(child.path);
        if (!YandexDrivePaths.contains(resource.path, normalized) || normalized == resource.path || child.size < 0) {
          throw const FormatException();
        }
      }
      return resource;
    } catch (error, stack) {
      _log.fine('Drive response decoding failed', error, stack);
      throw const CloudStorageException(DriveFailure.invalidResponse);
    }
  }

  /// Starts a media download that finishes before provider shutdown.
  ///
  /// The owner waits for the file before closing this API and closes the
  /// returned download after consuming and publishing its body.
  Future<YandexDriveDownload> download(String token, String remotePath) async {
    final json = await _request(
      'GET',
      _endpoint('resources/download', {'path': remotePath}),
      operation: _YandexDriveOperation.downloadLink,
      token: token,
    );
    Uri href;
    try {
      href = YandexDriveDownloadLink.fromJson(json).href;
    } catch (error, stack) {
      _log.fine('Drive response decoding failed', error, stack);
      throw const CloudStorageException(DriveFailure.invalidResponse);
    }
    // The short-lived download URL is provided by Yandex. Never send the OAuth
    // header to that separate host, or to a redirected download host.
    const operation = _YandexDriveOperation.downloadContent;
    for (var redirect = 0; redirect < 5; redirect++) {
      if (href.scheme != 'https' || href.userInfo.isNotEmpty || href.host.isEmpty) {
        throw const CloudStorageException(DriveFailure.invalidResponse);
      }
      _ensureOpen();
      final client = _clientFactory();
      _clients.add(client);
      int? status;
      try {
        _log.fine('Request started operation=${operation.name} method=GET redirect=$redirect');
        final request = http.Request('GET', href)..followRedirects = false;
        final response = await client.send(request).timeout(timeout);
        status = response.statusCode;
        if (response.statusCode >= 300 && response.statusCode < 400) {
          final location = response.headers['location'];
          if (location == null) throw const CloudStorageException(DriveFailure.invalidResponse);
          href = href.resolve(location);
          _log.fine('Request redirected operation=${operation.name} method=GET status=$status redirect=$redirect');
          client.close();
          _clients.remove(client);
          continue;
        }
        if (response.statusCode != 200) throw CloudStorageException(_status(response.statusCode));
        // Downloads own their client until the caller closes the body.
        _clients.remove(client);
        _log.fine('Response accepted operation=${operation.name} method=GET status=$status redirect=$redirect');
        return YandexDriveDownload(response, client);
      } catch (error, stack) {
        client.close();
        _clients.remove(client);
        final failure = _safe(error);
        _log.fine(
          'Request failed operation=${operation.name} method=GET status=${status ?? 'none'} '
          'redirect=$redirect reason=${failure.code.name} type=${error.runtimeType}',
          error,
          stack,
        );
        throw failure;
      }
    }
    throw const CloudStorageException(DriveFailure.invalidResponse);
  }

  Uri _endpoint(String suffix, Map<String, String> query) =>
      _diskBase.replace(path: '${_diskBase.path}/$suffix', queryParameters: query);

  Future<Map<String, dynamic>> _request(
    String method,
    Uri uri, {
    required _YandexDriveOperation operation,
    String? token,
    Map<String, String>? form,
    bool oauthErrors = false,
  }) async {
    for (var attempt = 0; ; attempt++) {
      _ensureOpen();
      final client = _clientFactory();
      _clients.add(client);
      Duration? retryAfter;
      int? status;
      try {
        _log.fine('Request started operation=${operation.name} method=$method attempt=${attempt + 1}');
        final request = http.Request(method, uri)
          ..followRedirects = false
          ..headers['Accept'] = 'application/json';
        if (token != null) request.headers['Authorization'] = 'OAuth $token';
        if (form != null) request.bodyFields = form;
        final response = await client.send(request).timeout(timeout);
        status = response.statusCode;
        final retrySeconds = int.tryParse(response.headers['retry-after'] ?? '');
        if (retrySeconds != null && retrySeconds >= 0) retryAfter = Duration(seconds: retrySeconds.clamp(0, 60));
        if (response.statusCode == 429 || response.statusCode >= 500) {
          throw CloudStorageException(_status(response.statusCode));
        }
        final bytes = <int>[];
        await () async {
          await for (final chunk in response.stream.timeout(timeout)) {
            if (bytes.length + chunk.length > _maxJsonBytes)
              throw const CloudStorageException(DriveFailure.invalidResponse);
            bytes.addAll(chunk);
          }
        }().timeout(timeout);
        if (response.statusCode != 200 && !oauthErrors) throw CloudStorageException(_status(response.statusCode));
        final decoded = jsonDecode(utf8.decode(bytes));
        if (decoded is! Map<String, dynamic>) throw const CloudStorageException(DriveFailure.invalidResponse);
        if (response.statusCode != 200 && (!oauthErrors || decoded['error'] is! String)) {
          throw CloudStorageException(_status(response.statusCode));
        }
        _log.fine('Request completed operation=${operation.name} method=$method status=$status attempt=${attempt + 1}');
        return decoded;
      } catch (error, stack) {
        final failure = _safe(error);
        final retry =
            method == 'GET' &&
            attempt < 2 &&
            {DriveFailure.network, DriveFailure.rateLimited, DriveFailure.serviceUnavailable}.contains(failure.code);
        _log.fine(
          'Request ${retry ? 'retrying' : 'failed'} operation=${operation.name} method=$method '
          'status=${status ?? 'none'} attempt=${attempt + 1} '
          'reason=${failure.code.name} type=${error.runtimeType}',
          error,
          stack,
        );
        if (!retry) rethrowSafe(failure);
        await _delay(retryAfter ?? Duration(milliseconds: 500 * (1 << attempt)));
      } finally {
        client.close();
        _clients.remove(client);
      }
    }
  }

  Never rethrowSafe(CloudStorageException failure) => throw failure;
  static DriveFailure oauthFailure(String value) => switch (value) {
    'invalid_client' => DriveFailure.invalidClient,
    'invalid_scope' => DriveFailure.invalidScope,
    'unauthorized_client' => DriveFailure.clientUnavailable,
    'invalid_request' || 'unsupported_grant_type' => DriveFailure.invalidRequest,
    'access_denied' => DriveFailure.authorizationDenied,
    'expired_token' => DriveFailure.authorizationExpired,
    'invalid_grant' => DriveFailure.authorizationRequired,
    'temporarily_unavailable' => DriveFailure.serviceUnavailable,
    _ => DriveFailure.invalidResponse,
  };
  static DriveFailure _status(int status) => switch (status) {
    401 => DriveFailure.authorizationRequired,
    403 => DriveFailure.authorizationDenied,
    429 => DriveFailure.rateLimited,
    >= 500 => DriveFailure.serviceUnavailable,
    _ => DriveFailure.invalidResponse,
  };
  static CloudStorageException _safe(Object error) => error is CloudStorageException
      ? error
      : CloudStorageException(
          error is TimeoutException || error is http.ClientException || error is SocketException
              ? DriveFailure.network
              : DriveFailure.invalidResponse,
        );
  void _ensureOpen() {
    if (_closed) throw const CloudStorageException(DriveFailure.cancelled);
  }

  void close() {
    _closed = true;
    for (final client in _clients.toList()) client.close();
    _clients.clear();
  }
}
