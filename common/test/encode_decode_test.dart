import 'dart:convert';

import 'package:dslideshow_common/src/rpc/error.dart';
import 'package:test/test.dart';

void main() {
  test('ErrorResult preserves its payload through real JSON encoding', () {
    const result = ErrorResult(id: 7, error: 'Ошибка: "photo"');
    final payload = jsonDecode(jsonEncode(result)) as Map<String, dynamic>;
    expect(payload, {'error': 'Ошибка: "photo"', 'id': 7});
    expect(ErrorResult.fromJson(payload), result);
  });

  test('ErrorResult rejects a malformed error payload', () {
    expect(
      () => ErrorResult.fromJson({'error': 123, 'id': 7}),
      throwsA(isA<TypeError>()),
    );
  });
}
