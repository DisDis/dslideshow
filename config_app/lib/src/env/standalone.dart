// ignore_for_file: prefer-match-file-name
// import 'dart:convert';
// import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// final _cookieJar = AutoSaveCookieJar(cookieFileStorage: "../cookie_storage.json");
final _log = Logger('standalone');

void initEnvironment() {
  _log.info('initEnvironment - Standalone');
}

void configHttpAdapter(dynamic obj) {
  _log.info('configHttpAdapter :$obj');
  // if (obj is Dio) {
  //   obj.interceptors.add(CookieManager(_cookieJar));
  //   //TODO: only for dev, pls remove in prod
  //   obj.interceptors
  //       .add(PrettyDioLogger(requestHeader: false, requestBody: false, responseHeader: false, responseBody: true));
  // }
}
/*
class AutoSaveCookieJar extends DefaultCookieJar {
  final String cookieFileStorage;
  static final _log = Logger('AutoSaveCookieJar');
  AutoSaveCookieJar({required this.cookieFileStorage}) {
    _loadCookieFromFile();
  }

  @override
  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) {
    final result = super.saveFromResponse(uri, cookies);
    _saveCookieToFile();
    return result;
  }

  void _saveCookieToFile() {
    try {
      _log.info("Saving cookies to file");
      final cookieFile = File(cookieFileStorage);
      final strData = json.encode(hostCookies);
      cookieFile.writeAsStringSync(strData);
    } catch (e, st) {
      _log.fine("_saveCookieToFile", e, st);
    }
  }

  void _loadCookieFromFile() {
    try {
      _log.info("Loading cookies from file");
      final cookieFile = File(cookieFileStorage);
      if (!cookieFile.existsSync()) {
        _log.info("Cookie file is not exist");
        return;
      }

      final cookieJson = (json.decode(cookieFile.readAsStringSync()) as Map<String, dynamic>);
      //.cast<String, Map<String, Map<String, String>>>();
      //{"localhost":{"/v1":{"wa_session":"wa_session=1234567; Path=/v1; Secure; HttpOnly;_crt=123459"}}}
      final Map<String, Map<String, Map<String, SerializableCookie>>> cookieData =
          <String, Map<String, Map<String, SerializableCookie>>>{};
      cookieJson.forEach((key, value) {
        final v = cookieData.putIfAbsent(key, () => <String, Map<String, SerializableCookie>>{});
        if (value is Map<String, dynamic>) {
          value.forEach((key2, value2) {
            final v2 = v.putIfAbsent(key2, () => <String, SerializableCookie>{});
            if (value2 is Map<String, dynamic>) {
              value2.forEach((key3, value3) {
                v2[key3] = SerializableCookie.fromJson(value3 as String);
              });
            }
          });
        }
      });

      hostCookies.addAll(cookieData);
      _log.info("Coockies was loaded");
    } catch (e, st) {
      _log.fine("_loadCookieFromFile: ${e.toString()}", e, st);
    }
  }
}
*/
