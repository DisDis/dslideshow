import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:test/test.dart';

void main() {
  group('JSON', () {
    test('EchoCommand to universal format', () {
      final actual = EchoCommand(id: 0, text: "TEXT");
      expect(json.encode(serializers.serialize(actual)), equals('["EchoCommand",{"id":0,"text":"TEXT","type":"echo"}]'));
    });

    // test('SystemInfo to universal format', () {
    //   final actual = SystemInfo();
    //   expect(json.encode(serializers.serialize(actual)), equals('["EchoCommand",{"id":0,"text":"TEXT","type":"echo"}]'));
    // });
  });
}
