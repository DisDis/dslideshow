import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class WebClient {
  final String host;
  final int port;
  final String code;

  WebClient({required this.host, required this.port, required this.code});

  Uri getMediaItemUri(String itemPath) {
    return Uri.parse('http://$host:$port/cache/$code/get/$itemPath');
  }

  /// Получает список всех медиа данных по роуту WebServerRoutes.getMedialItemsList
  ///
  /// Возвращает Future<List<String>>, содержащий пути к медиафайлам.
  ///
  /// Бросает исключение в случае ошибки соединения, неверного кода аутентификации
  /// или некорректного формата ответа.
  Future<List<String>> getMediaItems() async {
    final url = 'http://$host:$port/cache/$code/list';

    try {
      final response = await http.get(Uri.parse(url), headers: {'content-type': 'application/json; charset=utf-8'});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is Map<String, dynamic> && jsonData.containsKey('items')) {
          final items = jsonData['items'] as List;
          // Приводим к List<String>, проверяя типы элементов
          return items.map((item) => item.toString()).toList(growable: false);
        } else {
          throw Exception('Неверный формат ответа: отсутствует поле "items"');
        }
      } else if (response.statusCode == 403) {
        throw Exception('Неверный код аутентификации: $code');
      } else {
        throw Exception('Ошибка при получении списка медиафайлов: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on FormatException {
      throw Exception('Неверный формат JSON в ответе сервера');
    } catch (e) {
      throw Exception('Ошибка при выполнении HTTP-запроса: $e');
    }
  }

  Future<dynamic> uploadMedia(String localPath, String serverPath, void Function(int sentBytes, int totalBytes) onSendProgress) async {
    final dio = Dio();
    final url = 'http://$host:$port/upload/$code/$serverPath';
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(localPath, filename: path.basename(localPath)),
    });
    return dio.post(url, data: formData);
  }
}
