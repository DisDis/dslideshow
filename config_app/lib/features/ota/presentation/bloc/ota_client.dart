import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class OTAClient {
  static final _log = Logger('OTAClient');
  final String host;
  static const int port = 8282;

  OTAClient({required this.host});

  void stop() async {
    final url = 'http://$host:$port/ota_stop';
    try {
      await http.get(
        Uri.parse(url),
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    } catch (e) {
      throw Exception('Ошибка при выполнении HTTP-запроса: $e');
    }
  }

  Future<void> uploadFile(String codeValue, String filePath) async {
    // 1. URL вашего API
    var uri = Uri.parse('http://$host:$port/ota_upload');

    // 2. Создаем MultipartRequest (POST)
    var request = http.MultipartRequest('POST', uri);

    // 3. Добавляем текстовое поле 'code'
    request.fields['code'] = codeValue;

    // 4. Добавляем файл 'file'
    // MultipartFile.fromPath автоматически определяет content-type,
    // но вы можете указать его вручную, если нужно.
    var multipartFile = await http.MultipartFile.fromPath(
      'file', // Название поля на сервере
      filePath,
    );
    request.files.add(multipartFile);

    // 5. Отправляем запрос
    try {
      var streamedResponse = await request.send();

      // 6. Обрабатываем ответ
      if (streamedResponse.statusCode == 200) {
        // Если нужно получить тело ответа (строку):
        var response = await http.Response.fromStream(streamedResponse);
        _log.info("Server response: ${response.body}");
      } else {
        throw Exception('Ошибка загрузки: ${streamedResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Произошла ошибка соединения: $e');
    }
  }

  Future<Map<String, dynamic>> start() async {
    final url = 'http://$host:$port/ota_start?format=json';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'content-type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey('version')) {
          return jsonData;
        } else {
          throw Exception('Неверный формат ответа: отсутствует поле "items"');
        }
      } else {
        throw Exception(
          'Ошибка при старте OTA: ${response.statusCode} - ${response.body}',
        );
      }
    } on FormatException {
      throw Exception('Неверный формат JSON в ответе сервера');
    } catch (e) {
      throw Exception('Ошибка при выполнении HTTP-запроса: $e');
    }
  }
}
