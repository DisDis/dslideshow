// import 'package:dslideshow_backend/src/command/wifi_commands.dart';
// import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
// import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'dart:convert';

import 'package:dslideshow_common/serializers.dart';
import 'package:dslideshow_common/src/rpc/error.dart';
import 'package:test/test.dart';

void main() {
  // final actual = ErrorResult(id: 0, error: "errorMsg");

  group('Encode', () {
    test('encode object', () {
      final actual = ErrorResult(id: 0, error: "errorMsg");
      expect(json.encode(actual), equals('{"error":"errorMsg","id":0}'));
    });

    test('encode to universal format', () {
      final actual = ErrorResult(id: 0, error: "errorMsg");
      expect(json.encode(serializers.serialize(actual)), equals('["ErrorResult",{"error":"errorMsg","id":0}]'));
    });

    test('decode from universal format', () {
      final actual = serializers.deserialize(json.decode('["ErrorResult",{"error":"errorMsg","id":0}]'));
      expect(actual, equals(ErrorResult(id: 0, error: "errorMsg")));
    });
    test('encode to universal format, error', () {
      final actual = 123;
      expect(() => json.encode(serializers.serialize(actual)), throwsA(TypeMatcher<ArgumentError>()));
    });
  });
}

Serializers serializers = _SerializersImpl();

class _SerializersImpl implements Serializers {
  Object? serialize<T>(T object) {
    switch (T) {
      case ErrorResult:
        return ["ErrorResult", object];
      default:
        throw ArgumentError('Not found serializer for "$T"');
    }
  }

  Object? deserialize(Object? object) {
    if (object is List) {
      return _deserializeByType(object[0], object[1]);
    }
    throw ArgumentError('Not found deserialize for "$object"');
  }

  Object? _deserializeByType(String typeName, Map<String, dynamic> object) {
    switch (typeName) {
      case 'ErrorResult':
        return ErrorResult.fromJson(object);
      default:
        throw ArgumentError('Not found deserialize for "$typeName"');
    }
  }
}
