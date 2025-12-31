import 'package:dslideshow_backend/src/web_client/web_client.dart';
import 'package:test/test.dart';

void main() {
  group('WebClient', () {
    test('should initialize correctly', () {
      final client = WebClient(host: 'localhost', port: 8080, code: '12345');

      expect(client.host, equals('localhost'));
      expect(client.port, equals(8080));
      expect(client.code, equals('12345'));
    });

    // Тестирование метода getMediaItems будет невозможно без запущенного сервера
    // Но мы можем протестировать формирование URL и базовую логику
    test('should have getMediaItems method', () {
      final client = WebClient(host: 'localhost', port: 8080, code: '12345');

      // Проверяем, что метод существует
      expect(client.getMediaItems, isNotNull);
    });
  });
}
